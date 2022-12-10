add = table.insert
string.getC = (str, pos) -> string.sub(str, pos, pos)
string.split = (inputstr) -> [str for str in string.gmatch(inputstr, "([^%s]+)")]
contains = (tab1, el) -> return true for thing in *tab1 when thing == el

class File
	new: (path, size) => @path, @size = path, size

class FileSystem
	new: => @currentPath, @contents = "", {}
	addFile: (file) => add @contents, file unless contains @contents, file
	chdir: (path) =>
		if path == ".."
			for i=#@currentPath-1, 1, -1
				if @currentPath\getC(i) == "/"
					@currentPath = @currentPath\sub 1, i
					break
		elseif path == "/" @currentPath = "/"
		else @currentPath = @currentPath..path.."/"
	getFolders: =>
		folders = {}
		for file in *@contents
			fpath = file.path
			for i=1, #fpath
				if fpath\getC(i) == "/"
					dir = fpath\sub(1, i)
					add folders, dir unless contains(folders, dir)
		folders

eval = (fs, cmd) ->
	args = cmd\split!
	if args[1] == "$" fs\chdir args[3] if args[2] == "cd"
	elseif args[1] != "dir"
		cp = fs.currentPath
		filePath = cp..args[2]
		fs\addFile File(filePath, args[1])

getDirSizes = (fs) ->
	dirs = {}
	for dir in *fs\getFolders!
		dirSize, len = 0, #dir
		for file in *fs.contents
			dirSize += file.size if file.path\sub(1, len) == dir
		dirs[dir] = dirSize
	dirs
		
solution_a = (fs) ->
	s, dir = 0, getDirSizes fs
	for d in *fs\getFolders!
		s += dir[d] if dir[d] <= 100000
	s

solution_b = (fs) ->
	dirSizes = getDirSizes fs
	capacity, goal, total = 70000000, 30000000, dirSizes["/"]
	freeSpace = capacity - total
	necessary = goal - freeSpace
	smallest = total
	for dir in *fs\getFolders!
		if (dirSizes[dir] < smallest) and (dirSizes[dir] >= necessary)
			smallest = dirSizes[dir]
	smallest

fs = FileSystem!
eval(fs, line) for line in io.lines("7.data")
print solution_a fs
print solution_b fs
