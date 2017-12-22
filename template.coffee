{_log,_print,assert,expect,test} = require './util'
ansi = require('ansicolor').nice

input = '''
'''

class Solver
	constructor: ( @input )->
	solve1: (v)->
		v+1
	solve2: (v)->
		v+2

main = ->
	s = new Solver input
	_log.yellow s.solve1 1
	return

test.solve1 = ->
	s = new Solver ''
	expect 2, s.solve1 1
	return

test.solve2 = ->
	s = new Solver ''
	expect 3, s.solve2 1
	return

do ->
	try
		test()
		main()
	catch e
		_log.red e
	return
