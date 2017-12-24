{_log,test,expect,main} = require './util'
ansi = require('ansicolor').nice

class Solver
	constructor: ( @input )->
		@pairs = @input.split('\n').map (v)->
			[a,b] = v.split '/'
			[a,b,+a + +b]
		#_log @pairs
		return

	permute: (rem, longest, prev='0')->
		max = 0
		max_len = 0
		#max_p = []
		for p,i in rem when prev is p[0] or prev is p[1]
			next = rem[..]
			next.splice i,1
			sum = p[2]
			sum_len = 1
			#sum_p = [p[0..1]]
			if next.length
				last = if prev is p[0] then p[1] else p[0]
				v = @permute next, longest, last
				if v[0]
					sum += v[0]
					sum_len += v[1]
					#sum_p = sum_p.concat v[2]
			if max<sum and (not longest or max_len<=sum_len)
				max=sum
				max_len=sum_len
				#max_p=sum_p
		[max,max_len] #,max_p]


	solve1: ->
		@permute @pairs

	solve2: ->
		@permute @pairs, yes

test.solve1 = ->
	s = new Solver '''
	0/2
	2/2
	2/3
	3/4
	3/5
	0/1
	10/1
	9/10
	'''
	expect.nth(0) 31, s.solve1()
	return

test.solve2 = ->
	s = new Solver '''
	0/2
	2/2
	2/3
	3/4
	3/5
	0/1
	10/1
	9/10
	'''
	expect.nth(0) 19, s.solve2()
	return

main ->
	s = new Solver require './input/24.txt'
	_log.yellow '1: [sum,length] =', s.solve1()
	_log.yellow '2: [sum,length] =', s.solve2()
	return
