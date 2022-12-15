results = {
    "A X": 3
    "A Y": 4
    "A Z": 8
    "B X": 1
    "B Y": 5
    "B Z": 9
    "C X": 2
    "C Y": 6
    "C Z": 7
}

data = [line for line in io.lines("2.data")]

sum = (tab) ->
    s = 0
    for x in *tab
        s += results[x]
    s

print sum data