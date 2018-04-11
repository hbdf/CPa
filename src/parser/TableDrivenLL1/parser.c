#include "parser.h"
#include "enumFinal.c"
#include <stdio.h>
#include "stack.c"

#define NONTERMINAL 84 // 84 nonterminal symbols in enumFinal
#define LOOKAHEAD 72
#define RULES 173

StackNode *stack = 0;
enum token tok;
int productions[RULES][20] = 
{{DEC1, INC, -1},
{INC, SEMI, STRING, IMPORTAR, -1},
{-1},
{DEC0, DEC, -1},
{DEC1, -1},
{-1},
{CONST_DEC, -1},
{ID_DEC, -1},
{STRUCT_DEC, -1},
{ENUM_DEC, -1},
{SEMI, EXPR, ID, TYPE, CONSTANTE, -1},
{ID_SUFFIX, ID, TYPE, -1},
{FUNC_DEC, -1},
{VAR_DEC, -1},
{FUNC_END, RPAREN, PARAMS, LPAREN, -1},
{SEMI, -1},
{BLOCK, -1},
{VAR_DEC1, ID_INIT, -1},
{SEMI, -1},
{VAR_DEC, ID, COMMA, -1},
{EXPR, ATTR, -1},
{-1},
{RBRACE, VAR_DECS, LBRACE, ID, ESTRUTURA, -1},
{VAR_DECS, ID_DEC, -1},
{-1},
{RBRACE, IDS1, LBRACE, ID, ENUM, -1},
{IDS0, ID, -1},
{IDS1, COMMA, -1},
{-1},
{PARAM1, -1},
{-1},
{PARAM0, ID, TYPE, -1},
{PARAM1, COMMA, -1},
{-1},
{ARRAY_TYPE, BASIC_TYPE, -1},
{RPAREN, TYPE, LPAREN, -1},
{ID, -1},
{TIPO_PRIMITIVO, -1},
{TIPO_PRIMITIVO, -1},
{TIPO_PRIMITIVO, -1},
{TIPO_PRIMITIVO, -1},
{TIPO_PRIMITIVO, -1},
{TIPO_PRIMITIVO, -1},
{TYPE, STAR, -1},
{ARRAY_TYPE, RBRACKET, EXPR, LBRACKET, -1},
{-1},
{RBRACE, STMTS, LBRACE, -1},
{STMTS, STMT, -1},
{-1},
{DEC, -1},
{IF, -1},
{SWITCH_CASE, -1},
{FOR, -1},
{WHILE, -1},
{DO_WHILE, -1},
{BLOCK, -1},
{SEMI, EXPR, -1},
{RETURN, -1},
{SEMI, PARAR, -1},
{SEMI, CONTINUAR, -1},
{SEMI, ID, IRPARA, -1},
{LABEL, -1},
{SEMI, RETURN_EXPR, RETORNAR, -1},
{EXPR, -1},
{-1},
{ELSE, STMT, RPAREN, EXPR, LPAREN, SE, -1},
{STMT, SENAO, -1},
{-1},
{STMT, RPAREN, EXPR, LPAREN, ENQUANTO, -1},
{SEMI, RPAREN, EXPR, LPAREN, ENQUANTO, STMT, FAZER, -1},
{FOR_EXPR, RPAREN, EXPR, LPAREN, DE, ID, PARA, -1},
{FOR_ASC, -1},
{FOR_DESC, -1},
{STMT, RPAREN, EXPR, LPAREN, ASC, -1},
{STMT, RPAREN, EXPR, LPAREN, DESC, -1},
{RBRACE, CASE1, LBRACE, RPAREN, EXPR, LPAREN, ESCOLHA, -1},
{CASE0, CASE, -1},
{CASE1, -1},
{-1},
{STMTS, COLON, EXPR, CASO, -1},
{STMTS, COLON, CC, -1},
{TERNARY, ATTR, -1},
{EXPR, COLON, EXPR, QUESTION, -1},
{-1},
{ATTR_TAIL, LOGOR_CHAIN, -1},
{LOGOR_CHAIN, ATTR_OP, -1},
{-1},
{LOGOR_TAIL, LOGAND_CHAIN, -1},
{LOGOR_CHAIN, LOGOR_OP, -1},
{-1},
{LOGAND_TAIL, BITOR_CHAIN, -1},
{LOGAND_CHAIN, LOGAND_OP, -1},
{-1},
{BITOR_TAIL, BITAND_CHAIN, -1},
{BITOR_CHAIN, BITOR_OP, -1},
{-1},
{BITAND_TAIL, REL, -1},
{BITAND_CHAIN, BITAND_OP, -1},
{-1},
{REL_TAIL, SHIFT_CHAIN, -1},
{SHIFT_CHAIN, REL_OP, -1},
{-1},
{SHIFT_TAIL, ADD_CHAIN, -1},
{SHIFT_CHAIN, SHIFT_OP, -1},
{-1},
{ADD_TAIL, MUL_CHAIN, -1},
{ADD_CHAIN, ADD_OP, -1},
{-1},
{MUL_TAIL, UN_CHAIN, -1},
{MUL_CHAIN, MUL_OP, -1},
{-1},
{UN_CHAIN, UN_OP, -1},
{EXPR_LEAF, -1},
{EXPR_LEAF, PRE_OP, -1},
{VAR_CALL, -1},
{EXPR_LIT, -1},
{RPAREN, EXPR, LPAREN, -1},
{CALL, VAR, -1},
{RPAREN, ARGS, LPAREN, -1},
{POS_OP, -1},
{-1},
{ARGS0, EXPR, -1},
{ARGS, COMMA, -1},
{-1},
{ARGS1, -1},
{-1},
{INTEIRO, -1},
{REAL, -1},
{STRING, -1},
{CHAR, -1},
{ARRAY_LIT, -1},
{RBRACE, ARGS1, LBRACE, -1},
{VAR_MODS, ID, -1},
{VAR_MODS, ID, DOT, -1},
{VAR_MODS, RBRACKET, EXPR, LBRACKET, -1},
{-1},
{ATTR, -1},
{ATTRADD, -1},
{ATTRSUB, -1},
{ATTRMUL, -1},
{ATTRDIV, -1},
{ATTRBITOR, -1},
{ATTROR, -1},
{ATTRBITAND, -1},
{ATTRAND, -1},
{ATTRSHIFTL, -1},
{ATTRSHIFTR, -1},
{STAR, -1},
{AMPERSEND, -1},
{PLUS2, -1},
{MINUS2, -1},
{PLUS2, -1},
{MINUS2, -1},
{STAR, -1},
{DIV, -1},
{MOD, -1},
{NEG, -1},
{MINUS, -1},
{PLUS, -1},
{PLUS, -1},
{MINUS, -1},
{SHIFTL, -1},
{SHIFTR, -1},
{EQQ, -1},
{NEQ, -1},
{GT, -1},
{LT, -1},
{GEQ, -1},
{LEQ, -1},
{AMPERSEND, -1},
{PIPE, -1},
{AND, -1},
{OR, -1}};

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