# Schematic.jl
Lexer/Parser for an unnamed lisp dialect.

This project is rather meant explore different approaches for parsing languages in general and lisp style functional programs in particular.


## Version 1

The first version of this parser handles operators +, -, * correctly, as well as signs.
Currenly only integers are parsed (for no particular reason).
The program operates on an operator stack and a value stack, and with a buffer for reading integers char by char.

- successfully parsing one-line programs of the type (+ (* 3 2) (- 1 (+ 2 4)))
