{_log,test,expect,testAndRun} = require './util'

###
65  64  63  62  61  60  59  58  57
66  37  36  35  34  33  32  31  56
67  38  17  16  15  14  13  30  55
68  39  18   5   4   3  12  29  54
69  40  19   6   1   2  11  28  53
70  41  20   7   8   9  10  27  52
71  42  21  22  23  24  25  26  51
72  43  44  45  46  47  48  49  50
73  74  75  76  77  78  79  80  81
###

get_dist = ( x, y )->
	Math.abs(x)+Math.abs y

find_dist = ( num )->
	len = Math.ceil Math.sqrt num
	len-- if len%2

	x = y = len/2
	val = (len+1)*(len+1)
	diff = val - num

	d = Math.min diff, len
	x -= d
	diff -= d

	d = Math.min diff, len
	y -= d
	diff -= d

	d = Math.min diff, len
	x += d
	diff -= d

	d = Math.min diff, len
	y += d
	diff -= d

	get_dist x, y


###
147 142 133 122  59 2391
304   5   4   2  57 2275
330  10   1   1  54 2105
351  11  23  25  26 1968
362 747 806 880 931  957
###

fill = ( map, x, y )->
	v = 0
	for ny in [y-1..y+1]
		if map[ny]?
			for nx in [x-1..x+1]
				v += map[ny][nx] ? 0
	map[y] ?= {}
	map[y][x] = v
	v

find_min_sum_above = ( num )->
	map = {0:{0:1}}
	ord = 1
	while yes
		for y in [ord-1..-ord]
			v = fill map, ord, y
			if v>num
				return v

		for x in [ord-1..-ord]
			v = fill map, x, -ord
			if v>num
				return v

		for y in [1-ord..ord]
			v = fill map, -ord, y
			if v>num
				return v

		for x in [1-ord..ord]
			v = fill map, x, ord
			if v>num
				return v

		ord++

	return

test.find_dist = ->
	expect 0, find_dist 1
	expect 3, find_dist 12
	expect 2, find_dist 23
	expect 31, find_dist 1024
	return

test.find_min_sum_above = ->
	expect 2, find_min_sum_above 1
	expect 122, find_min_sum_above 60
	expect 806, find_min_sum_above 750
	return

testAndRun ->
	input = 368078
	_log.yellow '1:', find_dist input
	_log.yellow '2:', find_min_sum_above input
	return
