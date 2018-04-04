#include "parser.h"

void start(void) {
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
		case END:
			break;
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
			syntax_error();
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
	var_decs();
	eat(RBRACE);	
}

void var_decs(void) {
	switch(tok) {
		case LPAREN:
		case ID:
		case TIPO_PRIMITIVO:
		case STAR:
			id_dec();
			var_decs();
	}
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
	params();
	eat(RPAREN);
	func_end();
}

void func_end(void) {
	switch(tok) {
		case SEMI:
			eat(SEMI);
			break;
		case LBRACE:
			block();
			break;
		default:
			syntax_error();
	}
}

void params(void) {
	switch(tok) {
		case LPAREN:
		case ID:
		case TIPO_PRIMITIVO:
		case STAR:
			params1();
	}
}

void params1(void) {
	type();
	eat(ID);
	params0();
}

void params0(void) {
	switch(tok) {
		case COMMA:
			eat(COMMA);
			params1();
	}
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
	}
}

void id_init(void){
	switch(tok){
		case ATTR:
			eat(ATTR);
			expr();
			break;
	}
}

void type(void) {
	switch(tok) {
		case LPAREN:
			eat(LPAREN);
			type();
			eat(RPAREN);
			break;
		case ID:
		case TIPO_PRIMITIVO:
		case STAR:
			basic_type();
			array_type();
			break;
		default:
			syntax_error();
	}
}

void basic_type(void) {
	switch(tok) {
		case ID:
			eat(ID);
			break;
		case TIPO_PRIMITIVO:
			eat(TIPO_PRIMITIVO);
			break;
		case STAR:
			eat(STAR);
			type();
			break;
		default:
			syntax_error();
	}
}

void array_type(void) {
	switch(tok) {
		case LBRACKET:
			eat(LBRACKET);
			expr();
			eat(RBRACKET);
			array_type();
			break;
	}
}