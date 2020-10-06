{_log,_print,test,expect,testAndRun} = require './util'
ansi = require('ansicolor').nice

class Solver
	constructor: ( @input )->
		@map = @input.split '\n'
		@map.shift() if @map[0][0] is '.'
		return

	solve: ->
		y = 0
		x = @map[0].indexOf '|'
		dx = 0
		dy = 1
		out = ''
		steps = 1
		loop
			x+=dx
			y+=dy
			c=@map[y][x]
			# _log x, y, c
			switch c
				when ' ', undefined, null
					#_log.darkGray 'path end', x, y, dx, dy, "'#{c}'"
					return [out, steps]
				when '|', '-'
					break # does nothing
				when '+'
					[dx,dy]=[dy,dx]
					if (@map[y+dy]?[x+dx] ? ' ') is ' '
						dx = -dx
						dy = -dy
				else
					out = out + c
			++steps
		_log.red 'this should never execute'
		return


test.solve = ->
	s = new Solver '''
	.
	    |
	    |  +--+
	    A  |  C
	F---|----E|--+
	    |  |  |  D
	    +B-+  +--+
	'''
	expect.equal ['ABCDEF',38], s.solve()
	return

testAndRun ->
	s = new Solver require './input/19.txt'
	[out,steps] = s.solve()
	_log.yellow '1:', out
	_log.yellow '2:', steps
	return

