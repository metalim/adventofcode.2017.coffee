{_log,test,expect,testAndRun} = require './util'

escape1 = ( list )->
	i = 0
	num = 0
	while 0<=i<list.length
		num++
		i += list[i]++
	num

escape2 = ( list )->
	i = 0
	num = 0
	while 0<=i<list.length
		num++
		next = i + list[i]
		if list[i]>=3
			--list[i]
		else
			++list[i]
		i = next
	num

parse = ( inp )->
	inp.split('\n').map (a)->+a

test.escape1 = ->
	expect 5, escape1 parse '0\n3\n0\n1\n-3'
	return

test.escape2 = ->
	expect 10, escape2 parse '0\n3\n0\n1\n-3'
	return

testAndRun ->
	input = require './input/5.txt'
	_log.yellow '1:', escape1 parse input
	_log.yellow '2:',  escape2 parse input
	return
