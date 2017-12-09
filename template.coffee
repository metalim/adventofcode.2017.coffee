{_log} = require './util'

input = '''
'''

f = ( )->

do ->
	try
		_log.yellow f input

	catch e
		_log.red e
