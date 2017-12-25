#!/usr/bin/env coffee
{_log,test,expect,main} = require './util'
ansi = require('ansicolor').nice

r_start = /Begin in state (\w+)./
r_stop = /Perform a diagnostic checksum after (\d+) steps./
r_rule = /In state (\w+):\n  If the current value is (\d):\n    - Write the value (\d).\n    - Move one slot to the (\w+).\n    - Continue with state (\w+).\n  If the current value is (\d):\n    - Write the value (\d).\n    - Move one slot to the (\w+).\n    - Continue with state (\w+)./g

class Solver
	constructor: ( @input )->
		if r = r_start.exec @input
			@start = r[1]
		if r = r_stop.exec @input
			@stop = +r[1]
		@rules = {}
		while r = r_rule.exec @input
			[_,s,_,w0,d0,s0,_,w1,d1,s1]=r
			@rules[s] =
				0:[+w0,d0,s0]
				1:[+w1,d1,s1]
		return

	checksum: (tp)->
		sum = 0
		for i in [tp.start...tp.length] when tp[i]
			++sum
		sum

	solve: ->
		tp = []
		tp.start = 0
		p = 0
		st = @start
		for step in [1..@stop]
			_log.clear.darkGray step, p unless step%1000000
			c = tp[p] ? 0
			r = @rules[st][c]
			tp[p] = r[0]
			p += {left:-1,right:1}[r[1]]
			tp.start = p if tp.start>p
			st = r[2]
		_log.clear ''
		@checksum tp


test.solve = ->
	s = new Solver require './input/25_test.txt'
	expect 3, s.solve 1
	return

main ->
	s = new Solver require './input/25.txt'
	_log.yellow '1:', s.solve 1
	return
