{_log,_print,assert} = require './util'
ansi = require('ansicolor').nice

input = '''
'''

test ='''
'''

class Solver
	constructor: ( @input )->
	solve1: ->
	solve2: ->

verify = ( ex, inp )->
	s = new Solver inp[0]
	for ev, i in ex
		if ev is v=s["solve#{i+1}"] inp[1..]...
			_log.cyan v
		else
			_log.red 'expected', ev, 'actual', v
	return

do ->
	try
		verify [4], [test]

		s = new Solver input
		_log.yellow s.solve1()

	catch e
		_log.red e
	return
