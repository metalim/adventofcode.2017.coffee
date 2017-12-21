{_log,_print,assert} = require './util'
ansi = require('ansicolor').nice

input = '''
'''

test ='''
'''

class Solver
	constructor: ( @input )->
	solve1: (v)->
		v.split('').reverse().join ''
	solve2: ->

verify = ( expect, inp, args... )->
	s = new Solver inp
	for k, ev of expect
		if ev is v=s["solve#{k}"] args...
			_log.cyan v
		else
			_log.red 'expected', ev, 'actual', v
	return

do ->
	try
		verify 1:'abc', test, 'cba'

		s = new Solver input
		_log.yellow s.solve1 'zxc'

	catch e
		_log.red e
	return
