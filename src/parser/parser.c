#include "parser.h"
#include <stdio.h>

enum token tok;

void advance() {
	tok = getToken();
}

void eat(enum token t) {
	if (tok == t)
		advance();
	else 
		syntax_error();
}

void syntax_error() {
	printf("[ERRO SINTÁTICO] linha: %d, coluna: %d", line, column);
	exit(-1);
}

void start(void) {
	advance();
	inc();
	dec1();
}

int main() {
	start();
}