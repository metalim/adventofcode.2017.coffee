{_log,test,expect,main} = require './util'

solve1 = ( s )->
	sum = 0
	for c, i in s
		if c is s[ (i+1) % s.length ]
			sum += c|0
	sum

solve2 = ( s )->
	sum = 0
	for c, i in s
		if c is s[ (i+s.length//2) % s.length ]
			sum += c|0
	sum

test.solve1 = ->
	expect 3, solve1 '1122'
	expect 4, solve1 '1111'
	expect 0, solve1 '1234'
	expect 9, solve1 '91212129'
	return

test.solve2 = ->
	expect 6, solve2 '1212'
	expect 0, solve2 '1221'
	expect 4, solve2 '123425'
	expect 12, solve2 '123123'
	expect 4, solve2 '12131415'
	return

main ->
	input = require './input/1.txt'
	_log.yellow '1:', solve1 input
	_log.yellow '2:', solve2 input
	return
