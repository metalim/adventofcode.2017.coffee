{_log,test,expect,main} = require './util'
ansi = require('ansicolor').nice

input = '''
#.#.#.##.#.##.###.#.###.#
.#..#.....#..#######.##.#
......###..##..###..#...#
##....#.#.#....#..#..#..#
#..#....#.##.#.#..#..#.#.
..##..##.##..##...#...###
..#.#....#..####.##.##...
###...#.#...#.######...#.
..#####...###..#####.#.##
...#..#......####.##..#.#
#...##..#.#####...#.##...
..#.#.###.##.##....##.###
##.##...###....#######.#.
#.#...#.#..#.##..##..##.#
.#...###...#..#..####....
####...#...##.####..#.#..
......#.....##.#.##....##
###.......####..##.#.##..
....###.....##.##..###.#.
.##..##.#.###.###..#.###.
..#..##.######.##........
#..#.#..#.###....##.##..#
.##.#.#...######...##.##.
##..#..#..##.#.#..#..####
#######.#.######.#.....##
'''

DIR = [
	[0,-1]
	[1,0]
	[0,1]
	[-1,0]
]

class Solver
	constructor: ( @input )->

	walk: (steps, cb)->
		map = @input.split('\n').map (v)->v.split ''
		x = (map[0].length-1)/2
		y = (map.length-1)/2
		dir = 0
		for i in [0...steps]
			[map[y][x],dir] = cb map[y][x], dir
			dir %%= DIR.length
			x += DIR[dir][0]
			y += DIR[dir][1]
			map[y]?=[]
		return

	solve1: (steps)->
		infect = 0
		@walk steps, (v, dir)->
			switch v
				when '#'
					['.', dir+1]
				else
					++infect
					['#', dir-1]
		infect

	solve2: (steps)->
		infect = 0
		step = 0
		@walk steps, (v, dir)->
			++step
			_log.clear.darkGray step, infect unless step%1000000
			switch v
				when '#'
					['F', dir+1]
				when 'F'
					['.', dir+2]
				when 'W'
					++infect
					['#', dir]
				else
					['W', dir-1]
		_log.clear ''
		infect

test.solve1 = ->
	s = new Solver '..#\n#..\n...'
	expect 5, s.solve1 7
	expect 41, s.solve1 70
	expect 5587, s.solve1 10000
	return

test.solve2 = ->
	s = new Solver '..#\n#..\n...'
	expect 26, s.solve2 100
	expect 2511944, s.solve2 10000000
	return

main ->
	s = new Solver input
	_log.yellow s.solve1 10000
	_log.yellow s.solve2 10000000
	return
