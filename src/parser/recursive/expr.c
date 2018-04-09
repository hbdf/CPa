#include "parser.h"

void expr(void){
	attr();
	ternary();
}

void ternary(void){
	switch(tok){
		case QUESTION:
			eat(QUESTION);
			expr();
			eat(COLON);
			expr();
			break;
		default:
			break;
	}
}

void attr(void){
	logor_chain();
	attr_tail();
}

void logor_chain(void){
	logand_chain();
	logor_tail();
}

void logand_chain(void){
	bitor_chain();
	logand_tail();
}

void bitor_chain(void){
	bitand_chain();
	bitor_tail();
}

void bitand_chain(void){
	rel();
	bitand_tail();
}

void rel(void){
	shift_chain();
	rel_tail();
}

void shift_chain(void){
	add_chain();
	shift_tail();
}

void add_chain(void){
	mul_chain();
	add_tail();
}

void mul_chain(void){
	un_chain();
	mul_tail();
}

void un_chain(void){
	switch(tok){
		case NEG:
		case MINUS:
		case PLUS:
			un_op();
			un_chain();
			break;
		case STAR:
		case AMPERSEND:
		case PLUS2:
		case MINUS2:
		case ID:
		case INTEIRO:
		case REAL:
		case STRING:
		case CHAR:
		case LPAREN:
		case LBRACE:
			expr_leaf();
			break;
		default:
			syntax_error("Expected literal or unary operator.");
			break;
	}
}

void un_op(void){
	switch(tok){
		case NEG:
			eat(NEG);
			break;
		case MINUS:
			eat(MINUS);
			break;
		case PLUS:
			eat(PLUS);
			break;
		default:
			syntax_error("Expected unary operator.");
			break;
	}
}

void expr_leaf(void){
	switch(tok){
		case STAR:
		case AMPERSEND:
		case PLUS2:
		case MINUS2:
			pre_op();
			expr_leaf();
			break;
		case ID:
			var_call();
			break;
		case INTEIRO:
		case REAL:
		case STRING:
		case CHAR:
		case LBRACE:
			expr_lit();
			break;
		case LPAREN:
			eat(LPAREN);
			expr();
			eat(RPAREN);
		default:
			syntax_error("Expected expression leaf.");
			break;
	}
}

void pre_op(void){
	switch(tok){
		case STAR:
			eat(STAR);
			break;
		case AMPERSEND:
			eat(AMPERSEND);
			break;
		case PLUS2:
			eat(PLUS2);
			break;
		case MINUS2:
			eat(MINUS2);
			break;
		default:
			syntax_error("Expected prefix operator.");
			break;
	}
}

void var_call(void){
	var();
	call();
}

void var(void){
	switch(tok){
		case ID:
			eat(ID);
			var_mods();
			break;
		default:
			syntax_error("Expected variable ID.");
			break;
	}
}

void var_mods(void){
	switch(tok){
		case DOT:
			eat(DOT);
			eat(ID);
			var_mods();
			break;
		case LBRACKET:
			eat(LBRACKET);
			expr();
			eat(RBRACKET);
			var_mods();
			break;
		default:
			break;
	}
}

void call(void){
	switch(tok){
		case LPAREN:
			eat(LPAREN);
			args();
			eat(RPAREN);
			break;
		case PLUS2:
		case MINUS2:
			pos_op();
			break;
		default:
			break;
	}
}

void args(void){
	switch(tok){
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
		case LBRACE:
			args1();
			break;
		default:
			break;
	}
}

void args1(void){
	expr();
	args0();
}

void args0(void){
	switch(tok){
		case COMMA:
			eat(COMMA);
			args();
			break;
		default:
			break;
	}
}

void pos_op(void){
	switch(tok){
		case PLUS2:
			eat(PLUS2);
			break;
		case MINUS2:
			eat(MINUS2);
			break;
		default:
			syntax_error("Expected suffix operator.");
			break;
	}
}

void expr_lit(void){
	switch(tok){
		case INTEIRO:
			eat(INTEIRO);
			break;
		case REAL:
			eat(REAL);
			break;
		case STRING:
			eat(STRING);
			break;
		case CHAR:
			eat(CHAR);
			break;
		case LBRACE:
			array_lit();
			break;
		default:
			syntax_error("Expected literal.");
			break;
	}
}

void array_lit(void){
	switch(tok){
		case LBRACKET:
			eat(LBRACKET);
			args1();
			eat(RBRACKET);
			break;
		default:
			syntax_error("Expected bracket.");
	}
}

void mul_tail(void){
	switch(tok){
		case STAR:
		case DIV:
		case MOD:
			mul_op();
			mul_chain();
			break;
		default:
			break;
	}
}

void mul_op(void){
	switch(tok){
		case STAR:
			eat(STAR);
			break;
		case DIV:
			eat(DIV);
			break;
		case MOD:
			eat(MOD);
			break;
		default:
			syntax_error("Expected multiplier operator.");
			break;
	}
}

void add_tail(void){
	switch(tok){
		case PLUS:
		case MINUS:
			add_op();
			add_chain();
			break;
		default:
			break;
	}
}

void add_op(void){
	
}

void shift_tail(void){

}

void rel_tail(void){

}

void bitand_tail(void){

}

void bitor_tail(void){

}

void logand_tail(void){

}

void logor_tail(void){

}

void attr_tail(void){

}