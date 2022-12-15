char = string.char
string.getC = (str, pos) -> str\sub(pos, pos)
halve = (str) -> {str\sub(1, #str/2), str\sub(#str/2+1, #str)}

prioScores = {}
for i=97, 122
    prioScores[char(i)] = i-96
    prioScores[char(i-32)] = i-70

findCommon = (str1, str2) ->
    res = {}
    lookup = {}
    for i=1, #str1
        lookup[str1\getC(i)] = true
    for i=1, #str2
        c = str2\getC(i)
        if lookup[c]
            table.insert res, c
    res

solution = (data) ->
    s = 0
    for backpack in *data
        compartments = halve backpack
        mistake = findCommon(compartments[1], compartments[2])[1]
        s += prioScores[mistake]
    s
    
print solution [line for line in io.lines("3.data")]