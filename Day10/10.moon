split = (str) -> [s for s in str\gmatch "([^%s]+)"]
pop = (stack) -> table.remove stack, 1
push, unpack = table.insert, table.unpack

class CPU
	new: =>
		@xReg, @cycle, @wait, @pending = 1, -1, 0, 0
		@stack = {{"noop", nil}}
	cueNext: =>
		instruction, arg = unpack(pop @stack)
		buff = switch instruction
			when "noop" {1, 0}
			when "addx" {2, arg}
		@wait, @pending = buff[1], buff[2]
	nextCycle: =>
		@cycle += 1
		if @wait == 0
			@xReg += @pending
			@cueNext!
		@wait -= 1
		@cycle, @xReg
	parse: (line) =>
		name, arg = unpack(split line)
		push @stack, {name, arg}

class CRT
	new: (cpu) => @w, @h, @cpu = 40, 6, cpu
	getSprite: =>
		cycle, pos = @cpu.cycle%@w-1, {@cpu.xReg-1, @cpu.xReg+1}
		return "#" if pos[1] <= cycle and cycle <= pos[2]
		"."
	drawPixel: =>
		io.write @getSprite! unless @cpu.cycle == 0
		print! if @cpu.cycle%@w==0

solution = (cpu, crt, data) ->
	s = 0
	cpu\parse line for line in *data
	for i=1, 241
		cycle, regVal = cpu\nextCycle!
		s += cycle*regVal if (i-20)%40 == 1
		crt\drawPixel!
	s

cpu = CPU!
crt = CRT cpu
print solution cpu, crt, [line for line in io.lines "10.data"]
