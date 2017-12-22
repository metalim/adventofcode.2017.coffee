{_log,test,expect,main} = require './util'

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
	#_log JSON.stringify banks
	return [step,visited[str],step-visited[str]]

parse = ( str )->
	str.split('\t').map (a)->+a

test.step = ->
	expect.nth(0) 5, distribute parse '0	2	7	0'
	return

test.looped = ->
	expect.nth(2) 4, distribute parse '0	2	7	0'
	return

main ->
	[step,_,looped] = distribute parse input
	_log.yellow '1:', step
	_log.yellow '2:', looped
	return
