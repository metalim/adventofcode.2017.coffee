{_log,_trace,assert} = require './util'
ansi = require('ansicolor').nice

input = '94,84,0,79,2,27,81,1,123,93,218,23,103,255,254,243'

parse = ( input )->
	input.split(',').map (a)->+a

diff = ( a, b = [] )->
	out = for c, i in a
		if c is b[i]
			String(c)
		else
			String(c).red
	out.join ','

exec = ( v, rounds = 1 )->
	r=[0..255]
	s=0
	i=0
	last = undefined
	for [0...rounds]
		for d in v
			if 0
				_log.darkGray "\n#{i} #{d} #{s}".cyan, if r.join(',') is last?.join ','
					'no change'
				else
					diff r, last
			last = r[..]
			rr = r.concat r
			u = rr[i...i+d].reverse()
			rr = rr[...i].concat u.concat rr[i+d..]
			r = rr[r.length...r.length+i].concat rr[i...r.length]
			i = (i + d + s++)%r.length
	r

parse_codes = ( input )->
	input.split('').map (c)->c.charCodeAt()

hash1 = (str)->
	v = parse str
	_log.darkGray v.join ','
	r = exec v
	r[0]*r[1]

hash2 = (str)->
	v = parse_codes str
	v = v.concat [17, 31, 73, 47, 23]
	_log.darkGray v.join ','
	r = exec v, 64

	den = for i in [0...16]
		d = 0
		for c in r[i*16...(i+1)*16]
			d^=c
		d

	den.map((a)->"0#{a.toString 16}"[-2..]).join ''

do ->
	try
		_log.yellow hash1 input

		_log.cyan h = hash2 ''
		assert h is 'a2582a3a0e66e6e86e3812dcb672a272'
		_log.cyan h = hash2 'AoC 2017'
		assert h is '33efeb34ea91902bb2f59c9920caa6cd'
		_log.cyan h = hash2 '1,2,3'
		assert h is '3efbe78a8d82f29979031a4aa0b16a9d'
		_log.cyan h = hash2 '1,2,4'
		assert h is '63960835bcdc130f0b66d7ff4f6a5a8e'
		_log.yellow hash2 input

		
	catch e
		_trace.red e
	return
