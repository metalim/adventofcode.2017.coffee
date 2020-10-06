{_log,test,expect,testAndRun} = require './util'


clear_garbage = ( input, cb )->
	inside = no
	escape = no
	cleared = 0
	for c, i in input
		if escape
			escape = no
			continue
		if inside
			switch c
				when '!'
					escape = yes
				when '>'
					inside = no
				else
					++cleared
		else
			switch c
				when '<'
					inside = yes
				else
					cb c
	cleared

get_score = ( input )->
	res = ''
	level = 0
	score = 0
	cleared = clear_garbage input, (c)->
		res+=c
		switch c
			when '{'
				++level
			when '}'
				score += level--
		return
	[score,cleared]

test.score = ->
	expect.nth(0) 1, get_score '{}'
	expect.nth(0) 6, get_score '{{{}}}'
	expect.nth(0) 5, get_score '{{},{}}'
	expect.nth(0) 16, get_score '{{{},{},{{}}}}'
	expect.nth(0) 1, get_score '{<a>,<a>,<a>,<a>}'
	expect.nth(0) 9, get_score '{{<ab>},{<ab>},{<ab>},{<ab>}}'
	expect.nth(0) 9, get_score '{{<!!>},{<!!>},{<!!>},{<!!>}}'
	expect.nth(0) 3, get_score '{{<a!>},{<a!>},{<a!>},{<ab>}}'
	return

test.cleared = ->
	expect.nth(1) 0, get_score '<>'
	expect.nth(1) 17, get_score '<random characters>'
	expect.nth(1) 3, get_score '<<<<>'
	expect.nth(1) 2, get_score '<{!>}>'
	expect.nth(1) 0, get_score '<!!>'
	expect.nth(1) 0, get_score '<!!!>>'
	expect.nth(1) 10, get_score '<{o"i!a,<{i<a>'
	return

testAndRun ->
	[score,cleared] = get_score require './input/9.txt'
	_log.yellow '1:', score
	_log.yellow '2:', cleared
	return
