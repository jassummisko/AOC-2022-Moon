dec = string.byte
char = string.char
flr = math.floor
string.getC = (str, pos) ->
    return str\sub(pos, pos)

inThrees = (tab) ->
    res = {}
    index = 1
    for i, el in ipairs(tab)
        if res[index] == nil
            res[index] = {}
        table.insert res[index], el
        if i % 3 == 0
            index += 1
    return res

prioScores = {}
for i=97, 122
    prioScores[char(i)] = i-96
    prioScores[char(i-32)] = i-70

tabToString = (tab) ->
    str = ""
    for el in *tab
        str ..= el
    return str

findCommon = (str1, str2) ->
    res = {}
    lookup = {}
    for i=1, #str1
        lookup[str1\getC(i)] = true
    for i=1, #str2
        c = str2\getC(i)
        if lookup[c]
            table.insert res, c
    return res

findBadge = (group) ->
    findCommon(tabToString(findCommon(group[1], group[2])), group[3])[1]

solution = (groups) ->
    s = 0
    for group in *groups
        c = findBadge(group)
        s += prioScores[c]
    s

inp = {}
for line in io.lines("3.data")
    table.insert inp, line

groups = inThrees(inp)

print solution(groups)