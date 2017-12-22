ansi = require 'ansicolor'

_render = (s)->
	process.stdout.cursorTo 0
	process.stdout.write s
	process.stdout.clearLine 1
	return

exports.trace = exports._trace = _trace = require 'ololog'
.methods Object.defineProperties {},
	clear:
		enumerable: yes
		configurable: yes
		get: -> @configure render: _render

exports._log = exports.log = _log = _trace.noLocate

_trace1 = _trace.configure locate:shift:1

exports.assert = assert = ( cond, msg... )->
	unless cond
		_trace.red '• assertion failed:', msg...
		throw new Error 'assertion failed'
	cond

exports.expect = expect = ( ex, val )->
	if val isnt ex
		_trace1.red '• expected', ex
		_trace1.red '• got', val
		throw new Error 'unexpected'
	return

expect.equal = ( ex, val )->
	expect JSON.stringify(ex), JSON.stringify val

exports.test = test = ->
	failed = 0
	ok = 0
	total = Object.keys(test).length
	cur = 0
	for k, fn of test
		++cur
		try
			fn()
			++ok
			_log "• test #{cur}/#{total}:", ansi.green k
		catch e
			_log.red e.message
			++failed
			_log "• test #{cur}/#{total}:", ansi.red "#{k} failed"
	return

#
# fast array permutation
#
exports.permute = permute = ( arr, cb )->
	permutation = arr[..]
	length = permutation.length
	c = new Array(length).fill 0
	i = 1
	result = [permutation[..]] unless cb?
	#k, p;

	while i < length
		if c[i] < i
			k = i % 2 and c[i]
			p = permutation[i]
			permutation[i] = permutation[k]
			permutation[k] = p
			++c[i]
			i = 1
			if cb?
				if result = cb permutation[..]
					return result
			else
				result.push permutation[..]
		else
			c[i] = 0
			++i
	result unless cb?

permute.n_of = n_of = ( n, arr, cb, args=[] )->
	if n<1
		return cb []
	for el, i in arr
		if n>1
			next = arr[...i].concat arr[i+1..]
			out = n_of n-1, next, cb, args.concat [el]
		else
			out = cb args.concat [el]
		if out
			return out
	return

permute.minmax_of = minmax_of = ( min, max, arr, cb )->
	for i in [min..max]
		if out = n_of i, arr, cb
			return out
	return


exports.manhattan = (v...)->
	v.reduce ((sum,a)-> sum + Math.abs a), 0


# print is deprecated
exports._print = exports.print = _log 
