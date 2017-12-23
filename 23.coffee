{_log,test,expect,main} = require './util'
ansi = require('ansicolor').nice

get = (st, a)->
	if typeof a is 'number'
		a
	else
		st[a] ? 0

class Solver
	constructor: ( @input )->
		@pr = for l in @input.split '\n' when l isnt '' and l[0] isnt '#'
			l.split(/\s+/,4).map (a)->if isNaN +a then a else +a
		return

	solve1: ->
		i = 0
		st = mul:0
		while 0<=i<@pr.length
			[c,a,b] = @pr[i]
			switch c
				when 'set'
					st[a] = get st, b
				when 'sub'
					st[a] = get(st,a) - get st,b
				when 'mul'
					++st.mul
					st[a] = get(st,a) * get st,b
				when 'jnz'
					i += -1 + get st,b if 0 isnt get st,a
				else
					_log.red 'unknown instruction', c
			++i
		_log.clear ''
		st

	solve2: -> # will take forever
		i = 0
		muls = 0
		st = a:1
		step = 0
		while 0<=i<@pr.length
			++step
			[c,a,b] = @pr[i]

			#_log.darkGray step, JSON.stringify(st),c,a,(b ? '') #unless step%10000000
			switch c
				when 'set'
					st[a] = get st, b
				when 'sub'
					st[a] = get(st,a) - get st,b
				when 'mul'
					++muls
					st[a] = get(st,a) * get st,b
				when 'jnz'
					i += -1 + get st,b if 0 isnt get st,a
				else
					_log.red 'unknown instruction', c
			++i
		_log.clear ''
		muls

	solve2n1: (a=0)-> # converted from asm
		b=c=d=e=f=g=h = 0
		b = 65
		c = b
		if a
			b = b * 100 + 100000
			c = b + 17000
		loop
			f = 1
			d = 2
			loop
				e = 2
				loop
					if d*e is b
						f = 0
					++e
					if e is b
						break
				++d
				if d is b
					break
			if f is 0
				++h
			if b is c
				break
			b += 17
		{a,b,c,d,e,f,g,h}

	solve2n2: (a=0)-> # optimized, count non-primes
		b=c=d=e=f=g=h = 0
		if a
			b = 106500
			c = 123500
		else
			b = c = 65
		for b in [b..c] by 17

			is_prime_brute = ( b )-> # unoptimized, bruteforce
				for d in [2...b]
					for e in [2...b]
						if d*e is b
							return no
				yes

			is_prime = ( b )-> # optimized
				for d in [2..Math.ceil Math.sqrt b] when b%d is 0
					return no
				yes

			unless is_prime b
				#_log.clear.darkGray b, h
				++h
		_log.clear ''
		{a,b,c,d,e,f,g,h}

test.translated = ->
	s = new Solver require './input/23.txt'
	s1 = s.solve1()
	s21 = s.solve2n1()
	expect s1.b, s21.b
	expect s1.h, s21.h
	return

test.optimized = ->
	s = new Solver require './input/23.txt'
	s1 = s.solve1()
	s22 = s.solve2n2()
	expect s1.h, s22.h
	return

main ->
	s = new Solver require './input/23.txt'
	_log.yellow '1:', s.solve1().mul
	_log.yellow '2:', s.solve2n2(1).h
	return
