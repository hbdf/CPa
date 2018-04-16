#include "parser.h"
#include "enumFinal.c"
#include <stdio.h>
#include "stack.c"
#include "lltable.c"
#include "prod.c"

StackNode *stack = 0;
enum token tok;

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
	pop(&stack);
	if (p == -2) {
		syntax_error(0);
	}
	if (p >= 0) {
		int* prod = productions[p];
		int i = 0;
		while (prod[i] >= 0) {
			printf("push %d %d\n", prod[i], BASIC_TYPE);
			push(&stack, prod[i]);
			i++;
		}
	}
}

void LLparser() {
	push(&stack, START);
	advance();
	int accepted = 0;
	while (accepted == 0 && !isEmpty(stack)) {
		// if the TOP is a terminal symbol
		//printf("%d\n", top(stack));
		if (top(stack) < TERMINAL) {
			printf("TERMINAL");
			eat(top(stack));
			printf("TERMINAL2");
			if (isEmpty(stack)){
				accepted = 1;
			}
			pop(&stack);
		}
		else {
			int nonterminal = top(stack) - 71;
			int terminal = (tok - 1) % TERMINAL;
			printf("%d %d %d\n", nonterminal, terminal, LLtable[nonterminal][terminal]);
			apply(LLtable[nonterminal][terminal]);
		}
	}
}

int main() {
	LLparser();
}