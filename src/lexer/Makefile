calc:
	@lex comp.l
	@cc lex.yy.c -o exe -ll
	@./exe < ../../samples/calculadora.cpa

comp:
	@lex comp.l
	@cc lex.yy.c -o exe -ll
	@./exe < ../../samples/${file}

interpreter:
	@lex comp.l
	@cc lex.yy.c -o exe -ll
	@./exe
	@rm exe