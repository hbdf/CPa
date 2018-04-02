#include "lex.yy.c"
#include <stdio.h>

extern int line;
extern int column;
extern char* lexem;

extern enum token getToken(void);
enum token tok;

void advance() {
	tok = getToken();
}

void eat(enum token t) {
	if (tok == t)
		advance();
	else
		error();
}

void syntax_error() {
	//advance();
	error();
	exit(-1);
}

void inc(void);
void dec1(void);
void dec(void);
void dec0(void);
void const_dec(void);
void enum_dec(void);
void struct_dec(void);
void id_dec(void);
void id_suffix(void);
void id_init(void);
void func_dec(void);
void var_dec(void);
void var_dec1(void);
void expr(void);
void type(void);

void start(void) {
	advance();
	inc();
	dec1();
}

void inc(void) {
	switch(tok) {
		case IMPORTAR:
			eat(IMPORTAR);
			eat(STRING);
			eat(SEMI);
			inc();
			break;
		default:
			break;
	}
}

void dec1(void) {
	dec();
	dec0();
}


void dec(void) {
	switch(tok){
		case CONSTANTE:
			const_dec();
			break;
		case ENUM:
			enum_dec();
			break;
		case ESTRUTURA:
			struct_dec();
			break;
		case LPAREN:
		case ID:
		case TIPO_PRIMITIVO:
		case STAR:
			id_dec();
			break;
		default:
			syntax_error();
	}
}

void dec0(void) {
	switch(tok){
		case CONSTANTE:
		case ENUM:
		case ESTRUTURA:
		case LPAREN:
		case ID:
		case TIPO_PRIMITIVO:
		case STAR:
			dec1();
			break;
		default:
			break;
	}
}

void const_dec(void){
	eat(CONSTANTE);
	type();
	eat(ID);
	expr();
	eat(SEMI);
}

void enum_dec(void){
	eat(ENUM);
	eat(ID);
	eat(LBRACE);
	//ids1();
	eat(RBRACE);
}

void struct_dec(void){
	eat(ESTRUTURA);
	eat(ID);
	eat(LBRACE);
	//var_dec1();
	eat(RBRACE);	
}

void id_dec(void){
	type();
	eat(ID);
	id_suffix();
}

void id_suffix(void){
	switch(tok) {
		case LPAREN:
			func_dec();
			break;
		case SEMI:
		case COMMA:
		case ATTR:
			var_dec();
			break;
		default:
			syntax_error();
			break;
	}
}

void func_dec(void){
	eat(LPAREN);
	//params();
	eat(RPAREN);
	//func_end();
	eat(SEMI);
}

void var_dec(void){
	id_init();
	var_dec1();
}

void var_dec1(void){
	switch(tok){
		case SEMI:
			eat(SEMI);
			break;
		case COMMA:
			eat(COMMA);
			eat(ID);
			var_dec();
			break;
		default:
			syntax_error();
			break;
	}
}

void expr(void){
	eat(INTEIRO);
}

void type(void) {
	eat(TIPO_PRIMITIVO);
}

void id_init(void){
	switch(tok){
		case ATTR:
			eat(ATTR);
			expr();
			break;
		default:
			break;
	}
}

int main() {
	start();
}