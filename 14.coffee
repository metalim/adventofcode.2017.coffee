{_log,_print,test,expect} = require './util'
ansi = require('ansicolor').nice
MapWalker = require './map_walker'

class KnotHash
	constructor: ( @input )->
		@parse_codes()
		return

	parse_codes: ->
		@key = @input.split('').map (c)->c.charCodeAt()

	exec: ( v, rounds = 1 )->
		r=[0..255]
		s=0
		i=0
		last = undefined
		for [0...rounds]
			for d in v
				last = r[..]
				rr = r.concat r
				u = rr[i...i+d].reverse()
				rr = rr[...i].concat u.concat rr[i+d..]
				r = rr[r.length...r.length+i].concat rr[i...r.length]
				i = (i + d + s++)%r.length
		r

	hash: ->
		v = @parse_codes()
		v = v.concat [17, 31, 73, 47, 23]
		r = @exec v, 64

		den = for i in [0...16]
			d = 0
			for c in r[i*16...(i+1)*16]
				d^=c
			d

		den.map((a)->"0#{a.toString 16}"[-2..]).join ''

NUM = {}
MAP = {}
for i in [0..15]
	v = 0
	h = i.toString 16
	b = "000#{i.toString 2}"[-4..]
	MAP[h]=b
	for c in b when c is '1'
		++v
	NUM[h] = v





class Solver
	constructor: ( @input )->
		@hs = for i in [0..127]
			h = (new KnotHash "#{@input}-#{i}").hash()
			_log.clear.darkGray i, h
			h
		_log.clear ''
		@create_map()
		return

	create_map: ->
		@map = for h, y in @hs
			r=[]
			for c in h
				for b in MAP[c]
					r.push +b
			r
		return

	get: (x,y)=>
		@map[y]?[x]

	count: ->
		num = 0
		for h, i in @hs
			for c in h
				num += NUM[c]
		num

	count_groups: ->
		@create_map()
		#@log()
		num = 0
		walker = new MapWalker @get
		for r, y in @map
			for d, x in r when d
				++num
				walker.walk x, y, (x,y)=>
					@map[y][x]=0
					return
		num

	log: ->
		for r, y in @map
			_log.darkGray (for d, x in r
				'.#'[d]
			).join ''
		return


test.solve1 = ->
	s = new Solver 'flqrgnkx'
	expect 8108, s.count()
	return

test.solve2 = ->
	s = new Solver 'flqrgnkx'
	expect 1242, s.count_groups()
	return

main = ->
	s = new Solver 'xlqgujun'
	_log.yellow '1:', s.count()
	_log.yellow '2:', s.count_groups()
	return

do ->
	try
		test()
		main()

	catch e
		_log.red e
	return
