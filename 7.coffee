{_log,test,expect,main} = require './util'

r_in = /(\w+) \((\d+)\)/

parse = ( input )->
	out = {}
	for l in input.split '\n'
		[a,b] = l.split ' -> '
		res = r_in.exec a
		out[res[1]] =
			w: +res[2]
			c: b?.split ', '
			p: undefined

	#parents
	for k, v of out when v.c?
		for c in v.c
			out[c].p = k
	out

find_root = ( spec )->
	for k, v of spec when not v.p?
		return k
	_log.red 'root not found'
	return

build_tree = ( spec, root )->
	r = spec[root]
	c = {}
	cw = 0
	if r.c?
		for key in r.c
			c[key] = build_tree spec, key
			cw += c[key].tw
	w: r.w
	tw: cw + r.w
	c: c

is_unbalanced = ( tree )->
	w = undefined
	if tree.c?
		for k, v of tree.c
			w ?= v.tw
			if w isnt v.tw
				return yes
	no

find_deepest_unbalanced = ( tree )->
	out = undefined
	while out isnt tree
		out = tree
		for k, c of tree.c when is_unbalanced c
			tree = c
			break
	out

find_fixed_weight = ( tree )->
	right = wrong = undefined
	for k, c of tree.c
		if right?
			if wrong?
				if c.tw is wrong
					[right,wrong] = [wrong,right]
					break
			else
				wrong = c.tw
		else
			right = c.tw
	#_log right, wrong
	for k, c of tree.c when c.tw is wrong
		return c.w + right - wrong
	_log.red 'oops'
	return

test.find_root = ->
	spec = parse '''
	pbga (66)
	xhth (57)
	ebii (61)
	havc (66)
	ktlj (57)
	fwft (72) -> ktlj, cntj, xhth
	qoyq (66)
	padx (45) -> pbga, havc, qoyq
	tknk (41) -> ugml, padx, fwft
	jptl (61)
	ugml (68) -> gyxo, ebii, jptl
	gyxo (61)
	cntj (57)
	'''
	expect 'tknk', find_root spec
	return

test.balance = ->
	spec = parse '''
	pbga (66)
	xhth (57)
	ebii (61)
	havc (66)
	ktlj (57)
	fwft (72) -> ktlj, cntj, xhth
	qoyq (66)
	padx (45) -> pbga, havc, qoyq
	tknk (41) -> ugml, padx, fwft
	jptl (61)
	ugml (68) -> gyxo, ebii, jptl
	gyxo (61)
	cntj (57)
	'''
	tree = build_tree spec, find_root spec
	expect yes, is_unbalanced tree
	unb = find_deepest_unbalanced tree
	expect yes, unb.c.ugml?
	expect 60, find_fixed_weight unb
	return

main ->
	spec = parse require './input/7.txt'
	_log.yellow '1:', root = find_root spec

	tree = build_tree spec, root
	unb = find_deepest_unbalanced tree
	_log.yellow '2:', find_fixed_weight unb
	return

