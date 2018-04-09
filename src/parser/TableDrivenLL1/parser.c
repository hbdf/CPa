#include "parser.h"
#include <stdio.h>

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

int main() {
	advance();
	start();
	eat(END);
}