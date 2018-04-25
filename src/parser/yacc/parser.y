%{

#include <alloca.h>
#include <math.h>
#include <stdlib.h>
#include <stddef.h>
#include <ctype.h>

int yylex(void);
int yyerror(char* s);

%}

%token IMPORTAR 	STRING 	SEMI 	CONSTANTE 	ID 	LPAREN 	RPAREN 	COMMA 	ATTR 	ESTRUTURA 	LBRACE 	RBRACE 	ENUM 	TIPO_PRIMITIVO 	STAR 	LBRACKET 	RBRACKET 	VAR 	PARAR 	CONTINUAR 	IRPARA 	LABEL 	RETORNAR 	SE 	SENAO 	ENQUANTO 	FAZER 	PARA 	DE 	ASC 	DESC 	ESCOLHA 	CASO 	COLON 	CC 	QUESTION 	INTEIRO 	REAL 	REALD 	CARACTERE 	DOT 	ATTRADD 	ATTRSUB 	ATTRMUL 	ATTRDIV 	ATTRMOD 	ATTRBITOR 	ATTROR 	ATTRBITAND 	ATTRAND 	ATTRSHIFTL 	ATTRSHIFTR 	AMPERSEND 	PLUS2 	MINUS2 	DIV 	MOD 	NEG 	MINUS 	PLUS 	SHIFTL 	SHIFTR 	EQQ 	NEQ 	GT 	LT 	GEQ 	LEQ 	PIPE 	AND 	OR

%%

START: INC DEC1 ;
INC: IMPORTAR STRING SEMI INC ;
INC:  ;
DEC1: DEC DEC0 ;
DEC0: DEC1 ;
DEC0:  ;
DEC: CONST_DEC ;
DEC: ID_DEC ;
DEC: STRUCT_DEC ;
DEC: ENUM_DEC ;
CONST_DEC: CONSTANTE TYPE ID EXPR SEMI ;
ID_DEC: TYPE ARRAY_TYPE ID ID_SUFIX ;
ID_SUFIX: FUNC_DEC ;
ID_SUFIX: VAR_DEC ;
FUNC_DEC: LPAREN PARAMS RPAREN FUNC_END ;
FUNC_END: SEMI ;
FUNC_END: BLOCK ;
VAR_DEC: ID_INIT VAR_DEC1 ;
VAR_DEC1: SEMI ;
VAR_DEC1: COMMA ID VAR_DEC ;
ID_INIT: ATTR EXPR ;
ID_INIT:  ;
STRUCT_DEC: ESTRUTURA ID LBRACE VAR_DECS RBRACE ;
VAR_DECS: ID_DEC VAR_DECS ;
VAR_DECS:  ;
ENUM_DEC: ENUM ID LBRACE IDS1 RBRACE ;
IDS1: ID IDS0 ;
IDS0: COMMA IDS1 ;
IDS0:  ;
PARAMS: PARAM1 ;
PARAMS:  ;
PARAM1: TYPE ID PARAM0 ;
PARAM0: COMMA PARAM1 ;
PARAM0:  ;
TYPE: ID ;
TYPE: TIPO_PRIMITIVO ;
TYPE: STAR TYPE ;
ARRAY_TYPE: LBRACKET EXPR RBRACKET ARRAY_TYPE ;
ARRAY_TYPE:  ;
BLOCK: LBRACE STMTS RBRACE ;
STMTS: STMT STMTS ;
STMTS:  ;
STMT: VAR ID_DEC ;
STMT: IF ;
STMT: SWITCH_CASE ;
STMT: FOR ;
STMT: WHILE ;
STMT: DO_WHILE ;
STMT: BLOCK ;
STMT: EXPR SEMI ;
STMT: RETURN ;
STMT: PARAR SEMI ;
STMT: CONTINUAR SEMI ;
STMT: IRPARA ID SEMI ;
STMT: LABEL ;
RETURN: RETORNAR RETURN_EXPR SEMI ;
RETURN_EXPR: EXPR ;
RETURN_EXPR:  ;
IF: SE LPAREN EXPR RPAREN STMT ELSE ;
ELSE: SENAO STMT ;
ELSE:  ;
WHILE: ENQUANTO LPAREN EXPR RPAREN STMT ;
DO_WHILE: FAZER STMT ENQUANTO LPAREN EXPR RPAREN SEMI ;
FOR: PARA ID DE LPAREN EXPR RPAREN FOR_EXPR ;
FOR_EXPR: FOR_ASC ;
FOR_EXPR: FOR_DESC ;
FOR_ASC: ASC LPAREN EXPR RPAREN STMT ;
FOR_DESC: DESC LPAREN EXPR RPAREN STMT ;
SWITCH_CASE: ESCOLHA LPAREN EXPR RPAREN LBRACE CASE1 RBRACE ;
CASE1: CASE CASE0 ;
CASE0: CASE1 ;
CASE0:  ;
CASE: CASO EXPR COLON STMTS ;
CASE: CC COLON STMTS ;
EXPR: ATTR_RULE TERNARY ;
TERNARY: QUESTION EXPR COLON EXPR ;
TERNARY:  ;
ATTR_RULE: LOGOR_CHAIN ATTR_TAIL ;
ATTR_TAIL: ATTR_OP LOGOR_CHAIN ;
ATTR_TAIL:  ;
LOGOR_CHAIN: LOGAND_CHAIN LOGOR_TAIL ;
LOGOR_TAIL: LOGOR_OP LOGOR_CHAIN ;
LOGOR_TAIL:  ;
LOGAND_CHAIN: BITOR_CHAIN LOGAND_TAIL ;
LOGAND_TAIL: LOGAND_OP LOGAND_CHAIN ;
LOGAND_TAIL:  ;
BITOR_CHAIN: BITAND_CHAIN BITOR_TAIL ;
BITOR_TAIL: BITOR_OP BITOR_CHAIN ;
BITOR_TAIL:  ;
BITAND_CHAIN: REL BITAND_TAIL ;
BITAND_TAIL: BITAND_OP BITAND_CHAIN ;
BITAND_TAIL:  ;
REL: SHIFT_CHAIN REL_TAIL ;
REL_TAIL: REL_OP SHIFT_CHAIN ;
REL_TAIL:  ;
SHIFT_CHAIN: ADD_CHAIN SHIFT_TAIL ;
SHIFT_TAIL: SHIFT_OP SHIFT_CHAIN ;
SHIFT_TAIL:  ;
ADD_CHAIN: MUL_CHAIN ADD_TAIL ;
ADD_TAIL: ADD_OP ADD_CHAIN ;
ADD_TAIL:  ;
MUL_CHAIN: UN_CHAIN MUL_TAIL ;
MUL_TAIL: MUL_OP MUL_CHAIN ;
MUL_TAIL:  ;
UN_CHAIN: UN_OP UN_CHAIN ;
UN_CHAIN: EXPR_LEAF ;
EXPR_LEAF: PRE_OP EXPR_LEAF ;
EXPR_LEAF: VAR_CALL ;
EXPR_LEAF: EXPR_LIT ;
EXPR_LEAF: LPAREN EXPR RPAREN ;
VAR_CALL: VAR_LEAF CALL ;
CALL: LPAREN ARGS RPAREN ;
CALL: POS_OP ;
CALL:  ;
ARGS1: EXPR ARGS0 ;
ARGS0: COMMA ARGS ;
ARGS0:  ;
ARGS: ARGS1 ;
ARGS:  ;
EXPR_LIT: INTEIRO ;
EXPR_LIT: REAL ;
EXPR_LIT: REALD ;
EXPR_LIT: STRING ;
EXPR_LIT: CARACTERE ;
EXPR_LIT: ARRAY_LIT ;
ARRAY_LIT: LBRACE ARGS1 RBRACE ;
VAR_LEAF: ID VAR_MODS ;
VAR_MODS: DOT ID VAR_MODS ;
VAR_MODS: LBRACKET EXPR RBRACKET VAR_MODS ;
VAR_MODS:  ;
ATTR_OP: ATTR ;
ATTR_OP: ATTRADD ;
ATTR_OP: ATTRSUB ;
ATTR_OP: ATTRMUL ;
ATTR_OP: ATTRDIV ;
ATTR_OP: ATTRMOD ;
ATTR_OP: ATTRBITOR ;
ATTR_OP: ATTROR ;
ATTR_OP: ATTRBITAND ;
ATTR_OP: ATTRAND ;
ATTR_OP: ATTRSHIFTL ;
ATTR_OP: ATTRSHIFTR ;
PRE_OP: STAR ;
PRE_OP: AMPERSEND ;
PRE_OP: PLUS2 ;
PRE_OP: MINUS2 ;
POS_OP: PLUS2 ;
POS_OP: MINUS2 ;
MUL_OP: STAR ;
MUL_OP: DIV ;
MUL_OP: MOD ;
UN_OP: NEG ;
UN_OP: MINUS ;
UN_OP: PLUS ;
ADD_OP: PLUS ;
ADD_OP: MINUS ;
SHIFT_OP: SHIFTL ;
SHIFT_OP: SHIFTR ;
REL_OP: EQQ ;
REL_OP: NEQ ;
REL_OP: GT ;
REL_OP: LT ;
REL_OP: GEQ ;
REL_OP: LEQ ;
BITAND_OP: AMPERSEND ;
BITOR_OP: PIPE ;
LOGAND_OP: AND ;
LOGOR_OP: OR ;

%%

#include <stdio.h>
#include <ctype.h>

char *progname;
extern int line;
extern int column;
extern char* lexem;

extern enum token getToken(void);
extern enum token tok;

int warning(char* s, char *t) {
  fprintf(stderr, "%s in %s, line %d, column %d: unexpected %s\n", s, progname, line, column, lexem);
  if (t)
    fprintf( stderr , " %s\n" , t );
}

int yyerror(char* s) {
  warning(s, ( char * )0 );
  yyparse();
}

int yywrap() {
  return(1);
}

int main(int argc, char* argv[]) {
  progname = argv[0];
  //strcpy(format,"%g\n");
  yyparse();
}
