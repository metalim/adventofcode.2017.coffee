{_log,_print,assert} = require './util'
ansi = require('ansicolor').nice

input = '''
'''

class Solver
	constructor: ( @input )->
	solve: ->

test = ( ex, inp )->
	s = new Solver inp
	if ex is v=s.solve()
		_log.cyan v
	else
		_log.red v, '!=', ex
	return

do ->
	try
		test 0, ''

		s = new Solver input
		_log.yellow s.solve()

	catch e
		_log.red e
	return
