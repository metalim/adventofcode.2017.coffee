{_log,_print,assert} = require './util'
ansi = require('ansicolor').nice

input = '''
'''

class Solver
	constructor: ( @d )->
	solve: ( rep, find=rep )->
		#_log.darkGray 'find', find, 'after', rep, 'steps by', @d
		b = [0]
		p = 0
		for i in [1..rep]
			p = (p+@d)%b.length + 1
			b.splice p, 0, i
			_log.darkGray i, p, (if ~ii=b.indexOf find then b[1+ii] else 'undefined') unless i%10000
		_log.clear ''
		#_log b.join ','
		b[1+b.indexOf find]

	solve_0: ( rep )->
		#_log.darkGray 'find', find, 'after', rep, 'steps by', @d
		p = 0
		len = 1
		v = undefined
		for i in [1..rep]
			p = (p+@d)%len + 1
			++len
			if p is 1
				v = i
			_log.clear.darkGray i, p, v unless i%10000000
		_log.clear ''
		v

test = ( ex, inp )->
	s = new Solver inp[0]
	if ex is v=s.solve inp[1..]...
		_log.cyan v
	else
		_log.red v, '!=', ex
	return

do ->
	try
		test 638, [3,2017,2017]

		s = new Solver 3
		_log.green s.solve 5, 0
		_log.green s.solve_0 5

		s = new Solver 344
		_log.yellow s.solve 2017,2017
		_log.green s.solve 2017,0
		_log.green s.solve_0 2017
		_log.yellow s.solve_0 50000000

	catch e
		_log.red e
	return
