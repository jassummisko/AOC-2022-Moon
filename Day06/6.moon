string.getC = (pos) => self\sub(pos, pos)
input = ([line for line in io.lines("6.data")])[1]

class Signal
	new: (input, passLen) => 
		@chars, @counter, @passLen, @input = {}, 0, passLen, input
	add: (other) =>
		table.insert @chars, other
		if #@chars > @passLen then table.remove @chars, 1
		@counter += 1
	init: => @add(@input\getC i) for i=1, @passLen
	match: =>
		lookup = {}
		for i in *@chars
			if lookup[i] return true
			else lookup[i] = true
		return false
	seek: =>
		for c=@passLen+1, #@input
			if @match! then @add @input\getC c else break
	report: => print @counter

with Signal(input, 4) --6a
	\init!
	\seek input
	\report!
with Signal(input, 14) --6b
	\init!
	\seek input
	\report!	
