sum = (tab) ->
    s = 0
    for el in *tab
        s += el
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

solution = (data) ->
    elves = splitTab data
    largest = 0

    for el in *elves
        s = sum el
        if s > largest
            largest = s

    largest

print solution [line for line in io.lines("1.data")]