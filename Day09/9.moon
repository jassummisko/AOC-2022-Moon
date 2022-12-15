abs,insert = math.abs, table.insert
string.split = (str) -> [word for word in str\gmatch("([^%s]+)")]
sign = (num) -> if num>0 then return 1 elseif num<0 return -1 else 0

dirs = {
	L: {-1, 0}
	D: {0, 1}
	R: {1, 0}
	U: {0, -1}
}

class Grid
	new: => @visited, @history = 1, {}

class Head
	new: => @pos = {0, 0}
	move: (dir) => @pos = {@pos[1] + dir[1], @pos[2] + dir[2]}

class Knot
	new: (grid, chained, isTail)  =>
		@grid, @chained, @isTail = grid, chained, isTail
		@pos = {0, 0}
	distance: => {@chained.pos[1] - @pos[1], @chained.pos[2] - @pos[2]}
	move: =>
		dist = @distance!
		if abs(dist[1])>1 or abs(dist[2])>1
			@pos[1] += sign(dist[1])
			@pos[2] += sign(dist[2])
			if @isTail
				posCode = @pos[1].."-"..@pos[2]
				with @grid
					.visited += 1 unless @grid.history[posCode]
					.history[posCode] = true

solution = (data, amountOfKnots) ->
	grid, head, knots = Grid!, Head!, {}
	for i=1, amountOfKnots
		isTail = i==amountOfKnots
		t = Knot grid, head, isTail
		t = Knot grid, knots[i-1], isTail unless i==1
		insert knots, t

	for cmd in *[line\split! for line in *data]
		dir, amt = cmd[1], tonumber cmd[2]
		for i=1, amt
			tail = knots[#knots]
			head\move dirs[dir]
			knot\move! for knot in *knots

	grid.visited

data = [line for line in io.lines "9.data"]
print solution data, 1 --9a
print solution data, 9 --9b
