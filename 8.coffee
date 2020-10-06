{_log,test,expect,testAndRun} = require './util'

check = ( regs, k, op, v )->
	r=regs[k]?=0
	switch op
		when '<' then r<v
		when '>' then r>v
		when '<=' then r<=v
		when '>=' then r>=v
		when '==' then r==v
		when '!=' then r!=v

modify = ( regs, k, op, v )->
	r = regs[k] ? 0
	regs[k] = switch op
		when 'inc' then r+v
		when 'dec' then r-v

r_in = /(\w+) (\w+) (-?\d+) if (\w+) ([!=<>]+) (-?\d+)/

exec = ( inp )->
	list = inp.split '\n'
	max = -Infinity
	regs = {}
	for s in list
		r = r_in.exec s
		if check regs, r[4], r[5], +r[6]
			v = modify regs, r[1], r[2], +r[3]
		max = v if max < v
	regs.max = max
	regs


get_largest = ( regs )->
	max = -Infinity
	for k, v of regs when k isnt 'max' and v > max
		max = v
	max

test.get_largest = ->
	regs = exec '''
	b inc 5 if a > 1
	a inc 1 if b < 5
	c dec -10 if a >= 1
	c inc -20 if c == 10
	'''
	expect 1, get_largest regs
	expect 10, regs.max
	return

testAndRun ->
	regs = exec require './input/8.txt'
	_log.yellow '1: max final', get_largest regs
	_log.yellow '2: max temp', regs.max
	return
