{_log,_print,test,expect,main} = require './util'
ansi = require('ansicolor').nice

class Solver
	constructor: ( @input )->
		@fw = []
		for l in @input.split '\n'
			[k,v] = l.split ': '
			@fw[+k] = +v
		#_log JSON.stringify @fw
		return

	get_severity: ( st = 0 )->
		sev = 0
		for l, i in @fw when l?
			v = l-1
			y = v - Math.abs v-(st+i)%(v*2)
			if y is 0
				sev += i*l
		sev

	try: ( st = 0 )->
		for l, i in @fw when l?
			v = l-1
			y = v - Math.abs v-(st+i)%(v*2)
			if y is 0
				return no
		yes

	solve: ->
		i = 0
		while not v = @try i
			++i
		i

test.get_severity = ->
	s = new Solver '''
		0: 3
		1: 2
		4: 4
		6: 4
		'''
	expect 24, s.get_severity()
	return

test.solve = ->
	s = new Solver '''
		0: 3
		1: 2
		4: 4
		6: 4
		'''
	expect 10, s.solve()
	return

main ->
	s = new Solver require './input/13.txt'
	_log.yellow '1:', s.get_severity()
	_log.yellow '2:', s.solve()
	return

