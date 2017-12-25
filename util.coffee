
#
# support for: input = require './input/123.txt'
#
if process?
	fs = require 'fs'
	require.extensions['.txt'] = ( module, filename )->
		module.exports = fs.readFileSync filename, 'utf8'
		return

#
# raw rednerer for _log.clear to print on the same line.
#
_render = (s)->
	process.stdout.cursorTo 0
	process.stdout.write s
	process.stdout.clearLine 1
	return

#
# _trace with locate.
#
exports.trace = exports._trace = _trace = require 'ololog'
.methods Object.defineProperties {},
	clear:
		enumerable: yes
		configurable: yes
		get: -> @configure render: _render

#
# _log without locate.
#
exports._log = exports.log = _log = _trace.noLocate

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

#
# re-export .test
#
Test = require '-test'
exports[k]=v for k,v of Test



#
# Deprecated: print
#
exports._print = exports.print = _log 
#
# Deprecated: classic assert. Use expect() instead.
#
exports.assert = assert = ( cond, msg... )->
	unless cond
		_trace.red '• assertion failed:', msg...
		throw new Error 'assertion failed'
	cond
