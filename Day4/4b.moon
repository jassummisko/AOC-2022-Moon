split = (inputstr, sep) -> [str for str in string.gmatch(inputstr, "([^"..sep.."]+)")]

parseLine = (line) ->
    r = -> split(line, ",") --Just felt like making the whole code purely functional for fun
    {[tonumber el for el in *split(r![1], "-")], [tonumber el for el in *split(r![2], "-")]}

overlaps = (r) -> not (r[1][2] < r[2][1] or r[2][2] < r[1][1])
solution = (data) -> #[x for x in *data when overlaps(parseLine(x))]

print solution [line for line in io.lines("4.data")]