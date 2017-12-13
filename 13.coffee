{_log,_print,assert} = require './util'
ansi = require('ansicolor').nice

input = '''
0: 5
1: 2
2: 3
4: 4
6: 6
8: 4
10: 8
12: 6
14: 6
16: 8
18: 6
20: 9
22: 8
24: 10
26: 8
28: 8
30: 12
32: 8
34: 12
36: 10
38: 12
40: 12
42: 12
44: 12
46: 12
48: 14
50: 12
52: 14
54: 12
56: 14
58: 12
60: 14
62: 14
64: 14
66: 14
68: 14
70: 14
72: 14
76: 14
80: 18
84: 14
90: 18
92: 17
'''

class Solver
	constructor: ( @input )->
		@fw = []
		for l in @input.split '\n'
			[k,v] = l.split ': '
			@fw[+k] = +v
		_log JSON.stringify @fw
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

test = ( sev, sol, test )->
	s = new Solver test
	if sev is v=s.get_severity()
		_log.cyan v
	else
		_log.red v, sev
	if sol is v=s.solve()
		_log.cyan v
	else
		_log.red v, sol
	return

do ->
	try

		test1='''
		0: 3
		1: 2
		4: 4
		6: 4
		'''

		test 24, 10, test1

		s = new Solver input
		_log.yellow s.get_severity()
		_log.yellow s.solve()



	catch e
		_log.red e
	return
