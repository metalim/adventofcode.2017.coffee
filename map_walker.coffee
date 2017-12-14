class MapWalker
	constructor: (@get)->

	@Neighbors:[[1,0],[0,1],[-1,0],[0,-1]]

	walk: (x,y,visit)->
		next=[[x,y]]
		while next.length
			cur = next
			next = []
			for [cx,cy] in cur
				for [dx,dy] in MapWalker.Neighbors
					x=cx+dx
					y=cy+dy
					if @get x,y
						if out = visit x,y
							return out
						next.push [x,y]
		return

module.exports = MapWalker
