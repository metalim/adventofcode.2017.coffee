{_log,_print,test,expect,testAndRun} = require './util'
ansi = require('ansicolor').nice


class Solver
	constructor: ( @input )->
		@rules = {}
		for l in @input.split '\n'
			[k,vs] = l.split ' <-> '
			for v in vs.split ', '
				@rules[k]?={}
				@rules[v]?={}
				@rules[k][v] = yes
				@rules[v][k] = yes
		return

	get_group: ( n )->
		next = [n]
		visited = {}
		visited[n]=yes
		while next.length
			cur = next
			next = []
			for k in cur
				for v of @rules[k] when not visited[v]
					visited[v] = yes
					next.push v
		Object.keys visited

	count_nodes_in_group: ( n )->
		@get_group(n).length

	count_groups: ->
		ks = Object.keys @rules
		count = 0
		while ks.length>0
			++count
			g = @get_group ks[0]
			ks = (k for k in ks when k not in g)
		count


test.count_nodes_in_group = ->
	s = new Solver '''
		0 <-> 2
		1 <-> 1
		2 <-> 0, 3, 4
		3 <-> 2, 4
		4 <-> 2, 3, 6
		5 <-> 6
		6 <-> 4, 5
		'''
	expect 6, s.count_nodes_in_group 0
	return

test.count_groups = ->
	s = new Solver '''
		0 <-> 2
		1 <-> 1
		2 <-> 0, 3, 4
		3 <-> 2, 4
		4 <-> 2, 3, 6
		5 <-> 6
		6 <-> 4, 5
		'''
	expect 2, s.count_groups()
	return

testAndRun ->
	s = new Solver require './input/12.txt'
	_log.yellow s.count_nodes_in_group 0
	_log.yellow s.count_groups()
	return
