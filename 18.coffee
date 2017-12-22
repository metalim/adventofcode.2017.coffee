{_log,test,expect,main} = require './util'
ansi = require('ansicolor').nice

get = (st, a)->
	if typeof a is 'number'
		a
	else
		st[a] ? 0

class Solver
	constructor: ( @input )->
		#_log @input
		@pr = for l in @input.split '\n'
			l.split(' ').map (a)->if isNaN +a then a else +a
		return

	#
	# get first recovered "sound freq"
	#
	solve1: ->
		i = 0
		snd = undefined
		st = {}
		while 0<=i<@pr.length
			[c,a,b] = @pr[i]
			switch c
				when 'snd'
					snd = get st, a
				when 'set'
					st[a] = get st, b
				when 'add'
					st[a] = get(st,a) + get st,b
				when 'mul'
					st[a] = get(st,a) * get st,b
				when 'mod'
					st[a] = get(st,a) % get st,b
				when 'rcv'
					if get st, a
						return snd
				when 'jgz'
					i += -1 + get st,b if 0 < get st,a
				else
					_log.red 'unknown instruction', c
			++i

		snd

	#
	# how many times did program 1 send a value
	#
	solve2: ->
		e = 0
		sst = [{p:0},{p:1}]
		l = [0,0] # lock state: 0 running, 1 locked, -1 dead
		q = [[],[]] # queue
		n = [0,0]
		i = [-1,-1]
		w = []
		step = 0
		while not l[e]
			++step
			st = sst[e]
			ne = +!e
			if w[e]?
				if q[e].length
					st[w[e]] = q[e].shift()
					w[e] = undefined
				else
					_log.red step, e,i[e],st,n,q[0].length,q[1].length,c,a
					l[e]=1
					e=ne
					continue


			++i[e]
			unless 0<=i[e]<@pr.length
				_log.red e, 'is dead'
				l[e]=-1
				e=ne
				continue

			[c,a,b] = @pr[i[e]]
			_log.darkGray step, e,i[e],JSON.stringify(st),n,q[0].length,q[1].length,c,a,(b ? '') unless ++step%10000000
			switch c
				when 'snd'
					q[ne].push get st,a
					l[ne]=0 if l[ne] is 1 #unlock
					++n[e]
				when 'set'
					st[a] = get st,b
				when 'add'
					st[a] = get(st,a) + get st,b
				when 'mul'
					st[a] = get(st,a) * get st,b
				when 'mod'
					st[a] = get(st,a) % get st,b
				when 'rcv'
					if q[e].length
						st[a] = q[e].shift()
					else
						#_log.cyan step, e,i[e],JSON.stringify(st),n,q[0].length,q[1].length,c,a
						w[e] = a
						l[e] = 1
						e = ne
						continue

				when 'jgz'
					i[e] += -1 + get st,b if 0 < get st,a
				else
					_log.red 'unknown instruction', c
		n

test.solve1 = ->
	s = new Solver '''
	set a 1
	add a 2
	mul a a
	mod a 5
	snd a
	set a 0
	rcv a
	jgz a -1
	set a 1
	jgz a -2
	'''
	expect 4, s.solve1()
	return

test.solve2 = ->
	s = new Solver '''
	snd 1
	snd 2
	snd p
	rcv a
	rcv b
	rcv c
	rcv d
	'''
	expect.equal [3,3], s.solve2()
	return

main ->
	s = new Solver require './input/18.txt'
	_log.yellow '1:', s.solve1()
	_log.yellow '2:', s.solve2()[1]
	return
