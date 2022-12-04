results = {
    "A X": 4
    "A Y": 8
    "A Z": 3
    "B X": 1
    "B Y": 5
    "B Z": 9
    "C X": 7
    "C Y": 2
    "C Z": 6
}

data = [line for line in io.lines("2.data")]

sum = (tab) ->
    s = 0
    for x in *tab
        s += results[x]
    s

print sum data