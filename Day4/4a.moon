split = (inputstr, sep) -> [str for str in string.gmatch(inputstr, "([^"..sep.."]+)")]

parseLine = (line) ->
    r = -> split(line, ",") --Just felt like making the whole code purely functional for fun
    {[tonumber el for el in *split(r![1], "-")], [tonumber el for el in *split(r![2], "-")]}

fullyOverlaps = (r) -> (r[1][1] <= r[2][1] and r[1][2] >= r[2][2]) or (r[2][1] <= r[1][1] and r[2][2] >= r[1][2])
solution = (data) -> #[x for x in *data when fullyOverlaps(parseLine(x))]

print solution [line for line in io.lines("4.data")]