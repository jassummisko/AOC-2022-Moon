results = {
    "A X": 0+3
    "A Y": 3+1
    "A Z": 6+2
    "B X": 0+1
    "B Y": 3+2
    "B Z": 6+3
    "C X": 0+2
    "C Y": 3+3
    "C Z": 6+1
}

data = [line for line in io.lines("2.data")]

sum = (tab) ->
    s = 0
    for x in *tab
        s += results[x]
    s

print sum data