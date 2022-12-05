pop = (tab) -> table.remove tab, #tab
split = (inputstr) -> [str for str in string.gmatch(inputstr, "([^%s]+)")]
string.getC = (str, pos) -> string.sub(str, pos, pos)
insert = table.insert

class Stack
    new: (boxes) => @boxes = boxes 
    lift: (n) => [pop @boxes for i=#@boxes+1-n, #@boxes] --one by one
    haul: (n) => --all at once
        t = {}
        for box in *@lift(n)
            insert t, 1, box
        t   

class Warehouse
    new: (mode) => @stacks, @mode = {}, mode
    addStack: (stack) => table.insert @stacks, stack

    move: (n, stackNum1, stackNum2) =>
        stack = switch @mode
            when "A" then @stacks[stackNum1]\lift(n)
            when "B" then @stacks[stackNum1]\haul(n)

        for box in *stack
            insert @stacks[stackNum2].boxes, box
            
    showContents: =>
        for i, stack in ipairs @stacks
            io.write i .. " "
            for box in *stack.boxes
                io.write box .. " "
            print ""
    
    showTopBoxes: =>
        for stack in *@stacks
            io.write stack.boxes[#stack.boxes]
        print ""

parseMove = (line) ->
    t = split line
    tonumber(t[2]), tonumber(t[4]), tonumber(t[6])

readStacks = (data) ->
    numberRow = 0
    numberCols = {}
    stacks = {}

    --Find number line
    for i, line in ipairs data
        if line\find "1"
            numberRow = i
            b=1
            while true
                x, y = line\find("%d", b)
                if x == nil then break
                insert numberCols, tonumber(x)
                b = y+1
            break

    --Get stack
    for i, col in ipairs numberCols
        insert stacks, {}
        for j = numberRow-1, 1, -1
            box = data[j]\getC(col)
            if box ~= " " then insert stacks[i], box 

    stacks

solution = (data, warehouse) ->
    moveLine = 1

    --Find when moves start
    for i, line in ipairs data
        if line\find "move"
            moveLine = i
            break
           
    warehouse\move parseMove data[i] for i=moveLine, #data
 
lines = [line for line in io.lines("5.data")]
warehouse_a = with Warehouse("A")
    \addStack(Stack(stack)) for stack in *(readStacks lines)
warehouse_b = with Warehouse("B")
    \addStack(Stack(stack)) for stack in *(readStacks lines)
       
solution lines, warehouse_a
solution lines, warehouse_b
warehouse_a\showTopBoxes!
warehouse_b\showTopBoxes!