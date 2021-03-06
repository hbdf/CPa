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

// ================================================================
// Leaf
// ================================================================

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

// ================================================================
// Chain
// ================================================================

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

// ================================================================
// Tails
// ================================================================

void mul_tail(void){
	switch(tok){
		case STAR:
		case DIV:
		case MOD:
			mul_op();
			mul_chain();
	}
}

void add_tail(void){
	switch(tok){
		case PLUS:
		case MINUS:
			add_op();
			add_chain();
	}
}

void shift_tail(void){
	switch(tok) {
		case SHIFTL:
		case SHIFTR:
			shift_op();
			shift_chain();
	}
}

void rel_tail(void) {
	switch(tok) {
		case EQQ:
		case NEQ:
		case LEQ:
		case GEQ:
		case NEG:
		case LT:
		case GT:
			rel_op();
			shift_chain();
	}
}

void bitand_tail(void){
	switch(tok) {
		case AMPERSEND:
			eat(AMPERSEND);
			bitand_chain();
	}
}

void bitor_tail(void){
	switch(tok) {
		case PIPE:
			eat(PIPE);
			bitor_chain();
	}
}

void logand_tail(void){
	switch(tok) {
		case AND:
			eat(AND);
			logand_chain();
	}
}

void logor_tail(void){
	switch(tok) {
		case OR:
			eat(OR);
			logor_chain();
	}
}

void attr_tail(void){
	switch(tok) {
		case ATTR:
		case ATTRADD:
		case ATTRSUB:
		case ATTRMUL:
		case ATTRDIV:
		case ATTRMOD:
		case ATTRSHIFTL:
		case ATTRSHIFTR:
		case ATTRBITOR:
		case ATTROR:
		case ATTRBITAND:
		case ATTRAND:
			eat(OR);
			logor_chain();
	}
}

// ================================================================
// Operators
// ================================================================

void attr_op(void) {
	switch(tok) {
		case ATTR:
			eat(ATTR);
			break;
		case ATTRADD:
			eat(ATTRADD);
			break;
		case ATTRSUB:
			eat(ATTRSUB);
			break;
		case ATTRMUL:
			eat(ATTRMUL);
			break;
		case ATTRDIV:
			eat(ATTRDIV);
			break;
		case ATTRMOD:
			eat(ATTRMOD);
			break;
		case ATTRSHIFTL:
			eat(ATTRSHIFTL);
			break;
		case ATTRSHIFTR:
			eat(ATTRSHIFTR);
			break;
		case ATTRBITOR:
			eat(ATTRBITOR);
			break;
		case ATTROR:
			eat(ATTROR);
			break;
		case ATTRBITAND:
			eat(ATTRBITAND);
			break;
		case ATTRAND:
			eat(ATTRAND);
			break;
		default:
			syntax_error("Espera-se operador de atribuição.");
			break;
	}
}

void rel_op(void){
	switch(tok) {
		case EQQ:
			eat(EQQ);
			break;
		case NEQ:
			eat(NEQ);
			break;
		case LEQ:
			eat(LEQ);
			break;
		case GEQ:
			eat(GEQ);
			break;
		case NEG:
			eat(NEG);
			break;
		case LT:
			eat(LT);
			break;
		case GT:
			eat(GT);
			break;
		default:
			syntax_error("Espera-se operador relacional.");
			break;
	}
}

void shift_op(void) {
	switch(tok) {
		case SHIFTL:
			eat(SHIFTL);
			break;
		case SHIFTR:
			eat(SHIFTR);
			break;
		default:
			syntax_error("Espera-se operador de deslocamento.");
			break;
	}
}

void add_op(void){
	switch(tok) {
		case PLUS:
			eat(PLUS);
			break;
		case MINUS:
			eat(MINUS);
			break;
		default:
			syntax_error("Espera-se operador aditivo.");
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
			syntax_error("Espera-se operador multiplicativo.");
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