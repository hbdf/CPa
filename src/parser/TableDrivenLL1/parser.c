#include "parser.h"
#include "enumFinal.c"
#include <stdio.h>
#include "stack.c"

#define NONTERMINAL 84 // 84 nonterminal symbols in enumFinal
#define LOOKAHEAD 72

StackNode *stack = 0;
enum token tok;
int** productions; // Lembrar de preencher a produçao de tras para frente
int LLtable[NONTERMINAL][LOOKAHEAD];

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
	int* prod = productions[p];
	int i = 0;
	pop(&stack);

	for (i = 0; i < LOOKAHEAD; ++i)	{
		if (prod[i] >= 0) {
			push(&stack, prod[i]);
		}
	}
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
			int p = LLtable[top(stack)][tok];
			if (p == 0) {
				syntax_error("Nenhuma produção encontrada.");
			} else {
				apply(p);
			}
		}
	}
}

int main() {
	LLparser();
}