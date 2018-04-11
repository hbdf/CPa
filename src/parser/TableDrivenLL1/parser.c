#include "parser.h"
#include "enumFinal.c"
#include <stdio.h>
#include "stack.c"
#include "lltable.c"
#include "prod.c"

#define NONTERMINAL 84 // 84 nonterminal symbols in enumFinal
#define LOOKAHEAD 72
#define RULES 173

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

void apply (int* p) {
	pop(&stack);

	// checar -2

	int i = 0;
	while (prod[i] >= 0)
		push(&stack, prod[i++]);
}

void LLparser() {
	push(&stack, START);
	tok = getToken();
	int accepted = 0;

	while (accepted == 0) {
		// if the TOP is a terminal symbol
		if (top(stack) <= 71) {
			eat(top(stack));
			if (isEmpty(stack)){
				accepted = 1;
			}
			pop(&stack);
		}
		else {
			apply(LLtable[top(stack)][tok]);
		}
	}
}

int main() {
	LLparser();
}