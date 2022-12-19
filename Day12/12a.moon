string.getC = (str, pos) -> str\sub(pos, pos)

class Tile
    new: (char, pos) =>
        @elevation = string.byte char
        @pos = pos
        @parent, @explored = nil, false

class Maze
    new: (lines) =>
        @grid, @source, @finish = {}, nil, nil
        for y, line in ipairs lines
            l = {}
            for i=1, #line
                c = line\getC i
                c, @source = "a", {y, i} if c == "S"
                c, @finish = "z", {y, i} if c == "E"
                table.insert l, Tile(c, {y, i})
            table.insert @grid, l

    getTile: (pos) =>
        y, x = unpack pos
        if y >= 1 and y <= #@grid
            if x >= 1 and x <= #@grid[1]
                return @grid[y][x]
        return nil

    getAdjacent: (tile) =>
        pos = tile.pos
        adj = {}
        table.insert adj, @getTile {pos[1], pos[2]+1}
        table.insert adj, @getTile {pos[1], pos[2]-1}
        table.insert adj, @getTile {pos[1]+1, pos[2]}
        table.insert adj, @getTile {pos[1]-1, pos[2]}
        adj = [a for a in *adj when a]
        [a for a in *adj when a.elevation - tile.elevation <= 1]
        
    getClosest: (tiles) => math.min unpack [tile.distance for tile in *tiles] 

bfs = (maze, start) ->
    q = {}
    start.explored = true
    table.insert q, start
    while #q > 0
        v = table.remove q, 1
        if v == maze\getTile maze.finish
            return v
        for neighbor in *(maze\getAdjacent v)
            if not neighbor.explored
                neighbor.explored = true
                neighbor.parent = v
                table.insert q, neighbor

maze = Maze [line for line in io.lines "12.data"]

u = bfs maze, maze\getTile maze.source
s = {}
while u != maze\getTile maze.source
    table.insert s, u
    u = u.parent
    
print #s