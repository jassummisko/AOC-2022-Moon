string.getC = (pos) => self\sub(pos, pos)
input = ([line for line in io.lines("6.data")])[1]

class Signal
	new: (input, passLen) => @chars, @counter, @passLen, @input = {}, 0, passLen, input
	add: (other) =>
		table.insert @chars, other
		if #@chars > @passLen
			table.remove @chars, 1
		@counter += 1
	match: =>
		lookup = {}
		for i in *@chars
			if lookup[i] return true
			else lookup[i] = true
		return false
	init: =>
		@add(@input\getC i) for i=1, @passLen
	seek: =>
		for c=@passLen+1, #@input
			if @match!
				@add @input\getC c  
			else 
				break
	report: => print @counter


signal_a = with Signal(input, 4)
	\init!
	\seek(input)
	\report!

signal_b = with Signal(input, 14)
	\init!
	\seek(input)
	\report!	
