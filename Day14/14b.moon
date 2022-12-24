insert = table.insert
string.split = (inputstr, sep="%s") -> [str for str in string.gmatch(inputstr, "([^#{sep}]+)")]
sign = (num) -> if num>0 then return 1 elseif num<0 return -1 else 0

data = [line for line in io.lines "14.data"]

TILES = {
    air: "."
    stone: "#"
    sand: "o"
}

class Reservoir
    new: (x, y) =>
        @grid = {}
        for j=1, y+2
            insert @grid, {}
            if j == y+2 insert @grid[#@grid], TILES.stone for i=1, x+2
            else insert @grid[#@grid], TILES.air for i=1, x+2
    
    line: (p1, p2) =>
        x1, y1 = unpack p1
        x2, y2 = unpack p2
        while not (x1==x2 and y1==y2) 
            @grid[y1][x1] = TILES.stone
            x1 += sign x2-x1
            y1 += sign y2-y1
        @grid[y1][x1] = TILES.stone

    connectDots: (points) => @line points[i-1], points[i] for i=2, #points
        
    nextStep: (p) =>
        x, y = unpack p
        return {x,y+1}   if @grid[y+1][x]   == TILES.air
        return {x-1,y+1} if @grid[y+1][x-1] == TILES.air
        return {x+1,y+1} if @grid[y+1][x+1] == TILES.air
        return "WIN" if y == 0

    drop: (p) =>
        while @nextStep(p)
            p = @nextStep(p)
            break if p == "WIN"
        if p != "WIN"
            @grid[p[2]][p[1]] = TILES.sand
            return true
        false
        
getPointsFromLine = (line) ->
    splitLine = line\split "->"
    pointsBuff = [point\split "%," for point in *splitLine]
    [{(tonumber point[1]), (tonumber point[2])} for point in *pointsBuff]

reduceToOne = (tab using nil) ->   --returns {values reduced to 1 as min; min x value; min y value;}
    data = {k, v for k, v in ipairs tab}

    points = do
        buff = {}
        for line in *data
            for point in *line
                insert buff, point
        buff

    allX = [point[1] for point in *points]
    allY = [point[2] for point in *points]
    minX = math.min unpack allX
    maxX = (math.max unpack allX) - minX + 1
    maxY = math.max unpack allY
    point[1] -= minX-2-maxY for point in *points
    data, maxX, maxY, (500-minX+2+maxY)
    
reduced, maxX, maxY, pourPoint = reduceToOne [getPointsFromLine line for line in *data]
reservoir = with Reservoir (maxY*3), maxY
    \connectDots line for line in *reduced
print do
    f = 0
    while reservoir\drop {pourPoint, 0}
        f += 1
    f+1