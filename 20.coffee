{_log,test,expect,testAndRun,manhattan} = require './util'
ansi = require('ansicolor').nice

min_man = (ps,sh,ii=[0...ps.length])->
	min_p = []
	min_d = Infinity
	for i in ii
		p = ps[i]
		d = manhattan p[sh..sh+2]...
		switch
			when min_d>d
				min_d = d
				min_p = [i]
			when min_d is d
				min_p.push i
	min_p

simulate1 = (ps,num,ii=[0...ps.length])->
	for i in ii
		p = ps[i]
		for j in [0...num]
			p[3]+=p[6]
			p[4]+=p[7]
			p[5]+=p[8]

			p[0]+=p[3]
			p[1]+=p[4]
			p[2]+=p[5]
	ps

simulate2 = (ps,num)->
	for [0...num]
		for p,i in ps when p
			p[3]+=p[6]
			p[4]+=p[7]
			p[5]+=p[8]

			p[0]+=p[3]
			p[1]+=p[4]
			p[2]+=p[5]
		col={}
		for a,i in ps when a?
			for j in [i+1...ps.length] when (b=ps[j])?
				if a[0] is b[0] and a[1] is b[1] and a[2] is b[2]
					col[i]=1
					col[j]=1
		for i of col
			ps[i]=null
	ps

class Solver
	constructor: ( @input )->
	reset: ->
		@ps = for l in @input.split '\n'
			r = l.match(/(-?\d+)/g).map (v)->+v
		return

	solve1: ->
		@reset()
		simulate1 @ps,500
		ii = min_man @ps,0,ii
		ii[0]

	solve2: ->
		@reset()
		simulate2 @ps,500
		num = @ps.reduce (n,p,i)->n+ +!!p

test.solve1 = ->
	s = new Solver '''
	p=<3,0,0>, v=<2,0,0>, a=<-1,0,0>
	p=<4,0,0>, v=<0,0,0>, a=<-2,0,0>
	'''
	expect 0, s.solve1()
	return

test.solve2 = ->
	s = new Solver '''
	p=<-6,0,0>, v=<3,0,0>, a=<0,0,0>
	p=<-4,0,0>, v=<2,0,0>, a=<0,0,0>
	p=<-2,0,0>, v=<1,0,0>, a=<0,0,0>
	p=<3,0,0>, v=<-1,0,0>, a=<0,0,0>
	'''
	expect 1, s.solve2()
	return

testAndRun ->
	s = new Solver require './input/20.txt'
	_log.yellow '1: closest id', s.solve1()
	_log.yellow '2: number of active', s.solve2()
	return
