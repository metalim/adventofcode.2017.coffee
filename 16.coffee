{_log,_print,test,expect,main} = require './util'
ansi = require('ansicolor').nice

class Solver
	constructor: ( @input )->
		@prog = for l in @input.split ','
			k = l[0]
			[a,b]=l[1..].split '/'
			a = +a unless isNaN +a
			b = +b unless isNaN +b
			[k,a,b]
		#_log @input, @prog
		return

	solve: (rep = 1, len = 16)->
		#_log len, rep
		s = 'abcdefghijklmnop'[...len].split ''
		step = 0
		visited = {}
		visited[s.join ''] = step
		while ++step<=rep
			_log.clear.darkGray step, s.join '' unless step%1000
			for l in @prog
				switch l[0]
					when 's'
						s = s[-l[1]..].concat s[...-l[1]]
					when 'x'
						[s[l[1]],s[l[2]]] = [s[l[2]],s[l[1]]]
					when 'p'
						a = s.indexOf l[1]
						b = s.indexOf l[2]
						[s[a],s[b]] = [s[b],s[a]]
					else
						_log.red 'invalid instruction', l
			ss = s.join ''
			if visited[ss]?
				_log.clear ''
				_log.darkGray 'repeated', ss.green, 'at', step, visited[ss]
				d = step - visited[ss]
				step = rep - (rep-step)%d
				visited = {}
				_log.darkGray 'skip to', step
			else
				visited[ss] = step
		_log.clear ''
		s.join ''

test.solve1 = ->
	s = new Solver 's1,x3/4,pe/b'
	expect 'baedc', s.solve 1, 5
	return

test.solve2 = ->
	s = new Solver 's1,x3/4,pe/b'
	expect 'ceadb', s.solve 2, 5
	return

main ->
	s = new Solver require './input/16.txt'
	_log.yellow '1:', s.solve()
	_log.yellow '2:', s.solve 1000000000
	_log.yellow 'verify:', s.solve 10
	return
