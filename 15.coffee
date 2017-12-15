{_log,_print,assert} = require './util'
ansi = require('ansicolor').nice

input = '''
'''

class Solver
	constructor: ( @a, @b )->
	solve1: ->
		num = 0
		a = @a
		b = @b
		for i in [0...40000000]
			a=a*16807 % 2147483647
			b=b*48271 % 2147483647
			if (a&0xffff) is (b&0xffff)
				++num
				#_log.cyan i, a, b, num
		num

	solve2: ->
		num = 0
		a = @a
		b = @b
		for i in [0...5000000]
			loop
				a=a*16807 % 2147483647
				if a%4 is 0
					break
			loop
				b=b*48271 % 2147483647
				if b%8 is 0
					break
			if (a&0xffff) is (b&0xffff)
				++num
				#_log.cyan i, @a, @b, num
		num


test = ( ex1, ex2, inp )->
	s = new Solver inp...

	if ex1 is v=s.solve1()
		_log.cyan v
	else
		_log.red v, '!=', ex1

	if ex2 is v=s.solve2()
		_log.cyan v
	else
		_log.red v, '!=', ex2
	return

do ->
	try
		test 588, 309, [65, 8921]

		s = new Solver 277, 349
		_log.yellow s.solve1()
		_log.yellow s.solve2()

	catch e
		_log.red e
	return
