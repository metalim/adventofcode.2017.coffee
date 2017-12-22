{_log,_print,test,expect} = require './util'
ansi = require('ansicolor').nice


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


test.solve1 = ->
	s = new Solver 65, 8921
	expect 588, s.solve1()
	return

test.solve2 = ->
	s = new Solver 65, 8921
	expect 309, s.solve2()
	return

main = ->
	s = new Solver 277, 349
	_log.yellow '1:', s.solve1()
	_log.yellow '2:', s.solve2()
	return

do ->
	try
		test()
		main()

	catch e
		_log.red e
	return
