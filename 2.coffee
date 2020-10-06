{_log,test,expect,testAndRun} = require './util'

checksum1 = ( sh )->
	sum = 0
	for s in sh.split '\n'
		min = max = null
		for n in s.split /\s+/
			min = Math.min +n, min ? +n
			max = Math.max +n, max ? +n
		sum += max - min
	sum


div = ( row )->
	for a, i in row
		for j in [0...i]
			b = row[j]
			return a/b unless a%b
			return b/a unless b%a
	throw new Error 'invalid input'
	return

checksum2 = ( sh )->
	sum = 0
	for s in sh.split '\n'
		sum += div s.split /\s+/
	sum

test.checksum = ->
	expect 18, checksum1 '''
	5 1 9 5
	7 5 3
	2 4 6 8
	'''
	return

test.checksum2 = ->
	expect 9, checksum2 '''
	5 9 2 8
	9 4 7 3
	3 8 6 5
	'''
	return

testAndRun ->
	input = require './input/2.txt'
	_log.yellow '1:', checksum1 input
	_log.yellow '2:', checksum2 input
	return
