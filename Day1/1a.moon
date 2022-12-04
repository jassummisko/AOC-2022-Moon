readLines = (fileName) ->
    l = {}
    lines = io.lines fileName
    for line in lines
        table.insert(l, line)
    return l

sum = (tab) ->
    s = 0
    for el in *tab
        i += el
    s

splitTab = (tab) ->
    t = {{}}
    i = 1
    for el in *tab
        if el == ""
            i += 1
            t[i] = {}
        else
            table.insert(t[i], tonumber(el))
    t

solution = ->
    input = readLines "1.data"
    raindeers = splitTab input
    largest = 0

    for r in *raindeers
        s = sum r
        if s > largest
            largest = s

    largest

print solution!