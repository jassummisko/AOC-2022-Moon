string.getC = (str, pos) -> str\sub pos, pos
d = {
	{1, false}	--left
	{-1, false}	--right
	{1, true}	--up
	{-1, true} 	--down
}

trees = [line for line in io.lines "8.data"]
for ind, line in ipairs trees
	buffer = {}
	table.insert buffer, {tonumber(line\getC i), false} for i=1, #line
	trees[ind] = buffer

trees.checkVisible = (trees, dir) ->
	inc = dir[1]
	for i=1, #trees
		highest = -1
		min, max = 1, #trees[1]
		min, max = #trees[1], 1 if inc == -1
		for j=min, max, inc
			current = trees[i][j]
			current = trees[j][i] if dir[2]
			if current[1] > highest
				highest = current[1]
				current[2] = true

trees.measureViewDistance = (trees, x, y, dir) ->
	x, y = x, y
	height = trees[y][x][1]
	xinc, yinc = 0, 0
	xinc = dir[1] unless dir[2]
	yinc = dir[1] if dir[2]
	distance = 0
	while (x>0 and x<#trees[1]) and (y>0 and y<#trees)
		x += xinc
		y += yinc
		break if x <= 0 or x > #trees[1]
		break if y <= 0 or y > #trees
		current = trees[y][x][1]
		distance += 1
		break if current >= height
	distance

trees.checkScenic = (trees, x, y) ->
	s = 1
	s *= trees\measureViewDistance x, y, dir for dir in *d
	s

solution_a = (trees) ->
	trees\checkVisible dir for dir in *d
	s=0
	for row in *trees
		s += 1 for tree in *row when tree[2]
	s

solution_b = (trees) ->
	largest = 0
	for i=1, #trees
		for j=1, #trees[i]
			scenicScore = trees\checkScenic j, i
			largest = scenicScore if scenicScore > largest
	largest

print solution_a trees
print solution_b trees
