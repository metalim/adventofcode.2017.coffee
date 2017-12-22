{_log,_print,test,expect,main} = require './util'
ansi = require('ansicolor').nice


DIR =
	n:[0,1,-1]
	s:[0,-1,1]
	nw:[-1,1,0]
	se:[1,-1,0]
	ne:[1,0,-1]
	sw:[-1,0,1]

class Solver
	constructor: ( @input )->
		@path = @input.split ','
		@walk()
		return

	walk: ->
		@p = [0,0,0]
		@max = 0
		for s in @path
			unless (d=DIR[s])?
				throw new Error 'invalid direction', p
			@p[0]+=d[0]
			@p[1]+=d[1]
			@p[2]+=d[2]
			@max = Math.max @max, @p.map(Math.abs)...
		#_log.darkGray @p, @max
		return

	distance: ->
		Math.max @p.map(Math.abs)...

test.distance = ->
	expect 3, (new Solver 'ne,ne,ne').distance()
	expect 0, (new Solver 'ne,ne,sw,sw').distance()
	expect 2, (new Solver 'ne,ne,s,s').distance()
	expect 3, (new Solver 'se,sw,se,sw,sw').distance()
	return

test.negative_distance = ->
	expect 3, (new Solver 'ne,ne,n').distance()
	return

main ->
	s = new Solver require './input/11.txt'
	_log.yellow '1:', s.distance()
	_log.yellow '2:', s.max
	return