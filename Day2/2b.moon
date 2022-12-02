--A = Rock
--B = Paper
--C = Scissors
--X = Rock
--Y = Paper
--Z = Scissors
--
--Win = 6
--Draw = 3
--Loss = 0
--Rock = 1
--Paper = 2
--Scissors = 3

results = {
    "AX": 0+3
    "AY": 3+1
    "AZ": 6+2
    "BX": 0+1
    "BY": 3+2
    "BZ": 6+3
    "CX": 0+2
    "CY": 3+3
    "CZ": 6+1
}

data = {}
for x in io.lines("2.data")
    buff = {
        x\sub(1, 1)
        x\sub(3, 3)   
    }
    table.insert data, buff

processTurn = (turn) ->
    a = turn[1]
    b = turn[2]
    sum = results[a..b]
    sum

sum = (tab) ->
    s = 0
    for x in *tab
        s += processTurn x
    s

print sum data