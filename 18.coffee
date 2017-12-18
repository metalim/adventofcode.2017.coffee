{_log,_print,assert} = require './util'
ansi = require('ansicolor').nice

input = '''
set i 31
set a 1
mul p 17
jgz p p
mul a 2
add i -1
jgz i -2
add a -1
set i 127
set p 680
mul p 8505
mod p a
mul p 129749
add p 12345
mod p a
set b p
mod b 10000
snd b
add i -1
jgz i -9
jgz a 3
rcv b
jgz b -1
set f 0
set i 126
rcv a
rcv b
set p a
mul p -1
add p b
jgz p 4
snd a
set a b
jgz 1 3
snd b
set f 1
add i -1
jgz i -11
snd a
jgz f -16
jgz a -19
'''

test1 = '''
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

test2 = '''
snd 1
snd 2
snd p
rcv a
rcv b
rcv c
rcv d
'''

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

verify = ( ex, inp )->
	s = new Solver inp[0]
	for ev, i in ex
		if ev is v=s["solve#{i+1}"] inp[1..]...
			_log.cyan v
		else
			_log.red v, '!=', ex
	return

do ->
	try
		verify [4], [test1]

		s = new Solver test2
		_log.cyan s.solve2()

		s = new Solver input
		_log.yellow s.solve1()
		_log.yellow s.solve2()

	catch e
		_log.red e
	return
