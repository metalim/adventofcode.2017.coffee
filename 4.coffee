{_log,test,expect,testAndRun} = require './util'

is_valid = ( p, sorted )->
	words = {}
	for w in p.split ' '
		w = w.split('').sort().join '' if sorted
		if words[w]?
			return no
		words[w]=yes
	yes

count_valid = ( inp, sorted )->
	valid = 0
	phrases = inp.split '\n'
	for p in phrases when is_valid p, sorted
		valid++
	valid


test.valid1 = ->
	expect yes, is_valid 'aa bb cc dd ee'
	expect no, is_valid 'aa bb cc dd aa'
	expect yes, is_valid 'aa bb cc dd aaa'
	return

test.valid2 = ->
	expect yes, is_valid 'abcde fghij', yes
	expect no, is_valid 'abcde xyz ecdab', yes
	expect yes, is_valid 'a ab abc abd abf abj', yes
	expect yes, is_valid 'iiii oiii ooii oooi oooo', yes
	expect no, is_valid 'oiii ioii iioi iiio', yes
	return

test.count_valid = ->
	expect 1, count_valid 'asdf fasd\nasdf asdf'
	expect 0, count_valid 'asdf fasd\nasdf asdf', yes
	return

testAndRun ->
	input = require './input/4.txt'
	_log.yellow '1:', count_valid input
	_log.yellow '2:', count_valid input, yes
	return
