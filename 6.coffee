_log = require 'ololog'

input = '''
10	3	15	10	5	15	5	15	9	2	5	8	5	2	3	6
'''

distribute = ( banks )->
	visited = {}
	step = 0
	while not visited[str = banks.join ',']
		visited[str] = step++

		# find max
		max = banks[0]
		j = 0
		for b, i in banks when max < b
			max = b
			j = i

		# distrib
		banks[j]=0
		while max--
			j = (j+1)%banks.length
			++banks[j]
	_log JSON.stringify banks
	return [step,visited[str],step-visited[str]]

try
	_log JSON.stringify banks = input.split('\t').map (a)->+a
	_log distribute banks

catch e
	_log.red e
