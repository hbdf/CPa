#include "parser.h"
#include "enumFinal.c"
#include <stdio.h>
#include "stack.c"
#include "lltable.c"
#include "prod.c"

StackNode *stack = 0;
enum token tok = -1;

void advance() {
	tok = getToken();
}

void eat(enum token t) {
	if (tok == t)
		advance();
	else {
		printf("[ERRO SINTÁTICO] linha: %d, coluna: %d\n", line, column);
		printf("Não espera-se token %d, espera-se token %d", tok, t);
		exit(-1);
	}
}

void syntax_error(char* err) {
	printf("[ERRO SINTÁTICO] linha: %d, coluna: %d\n", line, column);
	if (err)
		printf("%s", err);
	exit(-1);
}

void apply (int p) {
	if (p == -2) {
		while (!isEmpty(stack))
			printf("%d ", pop(&stack));
		syntax_error(0);
	}
	if (p >= 0) {
		//printf("prod %d: ", p);
		int* prod = productions[p];
		int i = 0;
		while (prod[i] >= 0) {
			//printf("%d ", prod[i]);
			push(&stack, prod[i]);
			i++;
		}
		//printf("\n");
	}
}

void LLparser() {
	push(&stack, END);
	push(&stack, START);
	advance();
	while (!isEmpty(stack)) {
		int symbol = pop(&stack);
		if (symbol < TERMINAL) {
			eat(symbol);
		} else {
			int nonterminal = symbol - TERMINAL;
			int terminal = tok == 0 ? TERMINAL - 1 : tok - 1;
			//printf("%d %d %d\n", nonterminal, terminal, LLtable[nonterminal][terminal]);
			apply(LLtable[nonterminal][terminal]);
		}
	}
}

int main() {
	LLparser();
}