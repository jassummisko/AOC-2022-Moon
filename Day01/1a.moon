sum = (tab) ->
    s = 0
    s += el for el in *tab
    s

splitTab = (tab) ->
    i, t = 1, {{}}
    for el in *tab
        if el == ""
            i += 1
            t[i] = {}
        else table.insert t[i], tonumber el
    t

solution = (data) ->
    largest, elves = 0, splitTab data
    for el in *elves
        s = sum el
        largest = s if s > largest
    largest

print solution [line for line in io.lines("1.data")]