#include "parser.h"


void block(void) {
	eat(LBRACE);
	stmts();
	eat(RBRACE);
}

void stmts(void) {
	switch(tok) {
		case LBRACE:
		case SE:
		case ENQUANTO:
		case FAZER:
		case PARA:
		case ESCOLHA:
		case RETORNAR:
		case PARAR:
		case CONTINUAR:
		case LABEL:
		case IRPARA:
		case VAR:
		// Expr
 		case NEG:
 		case MINUS:
 		case PLUS:
 		case LPAREN:
 		case STAR:
 		case AMPERSEND:
 		case PLUS2:
 		case MINUS2:
 		case ID:
 		case INTEIRO:
 		case REAL:
 		case STRING:
 		case CHAR:
			stmt();
			stmts();
	}
}

void stmt(void) {
	switch(tok) {
		case LBRACE:
			block();
			break;
		case SE:
			if_stmt();
			break;
		case ENQUANTO:
			while_stmt();
			break;
		case FAZER:
			do_while();
			break;
		case PARA:
			for_stmt();
			break;
		case ESCOLHA:
			switch_case();
			break;
		case RETORNAR:
			return_stmt();
			break;
		case PARAR:
			eat(PARAR);
			eat(SEMI);
			break;
		case CONTINUAR:
			eat(CONTINUAR);
			eat(SEMI);
			break;
		case LABEL:
			eat(LABEL);
			break;
		case IRPARA:
			eat(IRPARA);
			eat(ID);
			eat(SEMI);
			break;
		case VAR:
			eat(VAR);
			id_dec();
			break; 
		// Expr
		default:
			expr();
			eat(SEMI);
	}
}

void if_stmt(void) {
	eat(SE);
	eat(LPAREN);
	expr();
	eat(RPAREN);
	stmt();
	else_stmt();
}

void else_stmt(void) {
	switch(tok) {
		case SENAO:
			eat(SENAO);
			stmt();
			break;
	}
}

void while_stmt(void) {
	eat(ENQUANTO);
	eat(LPAREN);
	expr();
	eat(RPAREN);
	stmt();
}

void do_while(void) {
	eat(FAZER);
	stmt();
	eat(ENQUANTO);
	eat(LPAREN);
	expr();
	eat(RPAREN);
	eat(SEMI);
}

void for_stmt(void) {
	eat(PARA);
	eat(ID);
	eat(DE);
	eat(LPAREN);
	expr();
	eat(RPAREN);
	for_expr();
}

void for_expr(void) {
	if (tok == ASC)
		eat(ASC);
	else if (tok == DESC)
		eat(DESC);
	else
		syntax_error("Espera-se 'asc' ou 'desc'.");
	eat(LPAREN);
	expr();
	eat(RPAREN);
}

void switch_case(void) {
	eat(ESCOLHA);
	eat(LPAREN);
	expr();
	eat(RPAREN);
	eat(LBRACE);
	case1();
	eat(RBRACE);
}

void case1(void) {
	case_stmt();
	case0();
}

void case0(void) {
	switch(tok) {
		case CASO:
		case CC:
			case1();
	}
}

void case_stmt(void) {
	switch(tok) {
		case CASO:
			eat(CASO);
			expr();
			eat(COLON);
			stmts();
			break;
		case CC:
			eat(CC);
			expr();
			eat(COLON);
			stmts();
			break;
		default:
			syntax_error("Espera-se 'caso' ou 'cc'.");
	}
}

void return_stmt(void) {
	eat(RETORNAR);
	if (tok == SEMI) {
		eat(SEMI);
	} else {
		expr();
		eat(SEMI);
	}
}