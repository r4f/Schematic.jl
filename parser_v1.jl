function resolve(op_sym, valstack)
	if op_sym == '+'
		operator = +
	elseif op_sym == '-'
		operator = -
	elseif op_sym == '*'
		operator = *
	end
	push!(valstack, operator(pop!(valstack), pop!(valstack)))
end

function eval_math(io)
	opstack = Char[]
	valstack = Int[]
	digits = IOBuffer()
	
	while !eof(io)
		c = read(io, Char)
		if c == '\n'
			#newline always results in returning the top of the valstack
			break
		elseif c == ')'
			resolve(pop!(opstack), valstack)
		elseif (c in ['+', '-', '*'] && peek(io, Char) == ' ')
			push!(opstack, c)
		elseif (isdigit(c) || c in ['-', '+'])
			write(digits, c)
			while isdigit(peek(io, Char))
				write(digits, read(io, Char))
			end
			push!(valstack, parse(Int, String(take!(digits))))
		end
		#ignoring any '(' and whitespaces except '\n'
	end
	
	return pop!(valstack)
end

#io = IOBuffer("(+ 2 (* (+ 23 -6) (* 3 7)))\n(+ 3 23)\n") # = 359
io = open("simple_program.scm", "r");

while !eof(io)
	result = eval_math(io)
	println(result)
end
