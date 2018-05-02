%{

#include <alloca.h>
#include <math.h>
#include <stdlib.h>
#include <stddef.h>
#include <ctype.h>

int yylex(void);
int yyerror(char* s);
int tabs = 0;

void printt () {
  int i;

  for (i = 0; i < tabs; i++) {
    printf("    ");
  }
}

void eraset () {
  printf("\b\b\b\b");
}

%}

%token IMPORTAR 	STRING 	SEMI 	CONSTANTE 	ID 	LPAREN 	RPAREN 	COMMA 	ATTR 	ESTRUTURA 	LBRACE 	RBRACE 	ENUM 	TIPO_PRIMITIVO 	STAR 	LBRACKET 	RBRACKET 	VAR 	PARAR 	CONTINUAR 	IRPARA 	LABEL 	RETORNAR 	SE 	SENAO 	ENQUANTO 	FAZER 	PARA 	DE 	ASC 	DESC 	ESCOLHA 	CASO 	COLON 	CC 	QUESTION 	INTEIRO 	REAL 	REALD 	CARACTERE 	DOT 	ATTRADD 	ATTRSUB 	ATTRMUL 	ATTRDIV 	ATTRMOD 	ATTRBITOR 	ATTROR 	ATTRBITAND 	ATTRAND 	ATTRSHIFTL 	ATTRSHIFTR 	AMPERSEND 	PLUS2 	MINUS2 	DIV 	MOD 	NEG 	MINUS 	PLUS 	SHIFTL 	SHIFTR 	EQQ 	NEQ 	GT 	LT 	GEQ 	LEQ 	PIPE 	AND 	OR

%token-table

%%

START: INC DEC1 ;
INC: IMPORTAR STRING SEMI {printf("%s %s %s\n", $1, $2, $3);} INC ;
INC:  ;
DEC1: DEC DEC0 ;
DEC0: DEC1 ;
DEC0:  ;
DEC: CONST_DEC ;
DEC: ID_DEC ;
DEC: STRUCT_DEC ;
DEC: ENUM_DEC ;
CONST_DEC: CONSTANTE {printf("%s ", $1);} TYPE ID {printf("%s ", $4);} EXPR SEMI {printf("%s\n", $7);};
ID_DEC: TYPE ARRAY_TYPE ID {printf("%s ", $3);} ID_SUFIX ;
ID_SUFIX: FUNC_DEC ;
ID_SUFIX: VAR_DEC ;
FUNC_DEC: LPAREN {printf("%s ", $1);} PARAMS RPAREN {printf("%s ", $4);} FUNC_END ;
FUNC_END: SEMI {printf("%s ", $1);} ;
FUNC_END: BLOCK ;
VAR_DEC: ID_INIT VAR_DEC1 ;
VAR_DEC1: SEMI {printf("%s\n", $1); printt();} ;
VAR_DEC1: COMMA ID {printf("%s %s ", $1, $2);} VAR_DEC ;
ID_INIT: ATTR {printf("%s ", $1);} EXPR ;
ID_INIT:  ;
STRUCT_DEC: ESTRUTURA ID LBRACE {tabs++; printf("%s %s %s\n", $1, $2, $3); printt();} VAR_DECS RBRACE {tabs--; eraset(); printf("%s\n", $6);};
VAR_DECS: ID_DEC VAR_DECS ;
VAR_DECS:  ;
ENUM_DEC: ENUM ID LBRACE {tabs++; printf("%s %s %s\n", $1, $2, $3); printt();} IDS1 RBRACE {tabs--; eraset(); printf("\n%s\n", $6);};
IDS1: ID {printf("%s ", $1);} IDS0 ;
IDS0: COMMA {printf("%s ", $1);} IDS1 ;
IDS0:  ;
PARAMS: PARAM1 ;
PARAMS:  ;
PARAM1: TYPE ID {printf("%s ", $2);} PARAM0 ;
PARAM0: COMMA {printf("%s ", $1);} PARAM1 ;
PARAM0:  ;
TYPE: ID {printf("%s ", $1);} ;
TYPE: TIPO_PRIMITIVO {printf("%s ", $1);} ;
TYPE: STAR {printf("%s ", $1);} TYPE ;
ARRAY_TYPE: LBRACKET {printf("%s ", $1);} EXPR RBRACKET {printf("%s ", $3);} ARRAY_TYPE ;
ARRAY_TYPE:  ;
BLOCK: LBRACE {tabs++; printf("%s\n", $1); printt();} STMTS RBRACE {tabs--; eraset(); printf("%s\n", $4); printt();} ;
STMTS: STMT STMTS ;
STMTS:  ;
STMT: VAR {printf("%s ", $1);} ID_DEC ;
STMT: IF ;
STMT: SWITCH_CASE ;
STMT: FOR ;
STMT: WHILE ;
STMT: DO_WHILE ;
STMT: BLOCK ;
STMT: EXPR SEMI {printf("%s\n", $2); printt();} ;
STMT: RETURN ;
STMT: PARAR SEMI {printf("%s %s\n", $1, $2); printt();} ;
STMT: CONTINUAR SEMI {printf("%s %s\n", $1, $2); printt();} ;
STMT: IRPARA ID SEMI {printf("%s %s %s\n", $1, $2, $3); printt();} ;
STMT: LABEL {printf("%s\n", $1); printt();} ;
RETURN: RETORNAR {printf("%s ", $1);} RETURN_EXPR SEMI {printf("%s\n", $4); printt();} ;
RETURN_EXPR: EXPR ;
RETURN_EXPR:  ;
IF: SE LPAREN {printf("%s %s ", $1, $2);} EXPR RPAREN {printf("%s ", $5);} STMT ELSE ;
ELSE: SENAO {printf("%s ", $1);} STMT ;
ELSE:  ;
WHILE: ENQUANTO LPAREN {printf("%s %s ", $1, $2);} EXPR RPAREN {printf("%s ", $5);} STMT ;
DO_WHILE: FAZER {printf("%s ", $1);} STMT ENQUANTO LPAREN {printf("%s %s ", $4, $5);} EXPR RPAREN SEMI {printf("%s %s\n", $8, $9); printt();} ;
FOR: PARA ID DE LPAREN {printf("%s %s %s %s ", $1, $2, $3, $4);} EXPR RPAREN {printf("%s ", $7);} FOR_EXPR ;
FOR_EXPR: FOR_ASC ;
FOR_EXPR: FOR_DESC ;
FOR_ASC: ASC LPAREN {printf("%s %s ", $1, $2);} EXPR RPAREN {printf("%s ", $5);} STMT ;
FOR_DESC: DESC LPAREN {printf("%s %s ", $1, $2);} EXPR RPAREN {printf("%s ", $5);} STMT ;
SWITCH_CASE: ESCOLHA LPAREN {printf("%s %s ", $1, $2);} EXPR RPAREN {printf("%s ", $5);} LBRACE {tabs += 2; printf("%s\n", $7); printt();} CASE1 RBRACE {tabs -= 2; eraset(); eraset(); printf("%s\n", $10); printt();} ;
CASE1: CASE CASE0 ;
CASE0: CASE1 ;
CASE0:  ;
CASE: CASO {tabs--; eraset(); printf("%s ", $1);} EXPR COLON {printf("%s\n", $4); tabs++; printt();} STMTS ;
CASE: CC COLON {tabs--; eraset(); printf("%s %s\n", $1, $2); tabs++; printt();} STMTS ;
EXPR: ATTR_RULE TERNARY ;
TERNARY: QUESTION {printf("%s ", $1);} EXPR COLON {printf("%s ", $4);} EXPR ;
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
EXPR_LEAF: LPAREN {printf("%s ", $1);} EXPR RPAREN {printf("%s ", $4);} ;
VAR_CALL: VAR_LEAF CALL ;
CALL: LPAREN {printf("%s ", $1);} ARGS RPAREN {printf("%s ", $4);} ;
CALL: POS_OP ;
CALL:  ;
ARGS1: EXPR ARGS0 ;
ARGS0: COMMA {printf("%s ", $1);} ARGS ;
ARGS0:  ;
ARGS: ARGS1 ;
ARGS:  ;
EXPR_LIT: INTEIRO {printf("%s ", $1);} ;
EXPR_LIT: REAL {printf("%s ", $1);} ;
EXPR_LIT: REALD {printf("%s ", $1);} ;
EXPR_LIT: STRING {printf("%s ", $1);} ;
EXPR_LIT: CARACTERE {printf("%s ", $1);} ;
EXPR_LIT: ARRAY_LIT ;
ARRAY_LIT: LBRACE {printf("%s ", $1);} ARGS1 RBRACE {printf("%s ", $4);} ;
VAR_LEAF: ID {printf("%s ", $1);} VAR_MODS ;
VAR_MODS: DOT ID {printf("%s %s ", $1, $2);} VAR_MODS ;
VAR_MODS: LBRACKET {printf("%s ", $1);} EXPR RBRACKET {printf("%s ", $4);} VAR_MODS ;
VAR_MODS:  ;
ATTR_OP: ATTR {printf("%s ", $1);} ;
ATTR_OP: ATTRADD {printf("%s ", $1);} ;
ATTR_OP: ATTRSUB {printf("%s ", $1);} ;
ATTR_OP: ATTRMUL {printf("%s ", $1);} ;
ATTR_OP: ATTRDIV {printf("%s ", $1);} ;
ATTR_OP: ATTRMOD {printf("%s ", $1);} ;
ATTR_OP: ATTRBITOR {printf("%s ", $1);} ;
ATTR_OP: ATTROR {printf("%s ", $1);} ;
ATTR_OP: ATTRBITAND {printf("%s ", $1);} ;
ATTR_OP: ATTRAND {printf("%s ", $1);} ;
ATTR_OP: ATTRSHIFTL {printf("%s ", $1);} ;
ATTR_OP: ATTRSHIFTR {printf("%s ", $1);} ;
PRE_OP: STAR {printf("%s ", $1);} ;
PRE_OP: AMPERSEND {printf("%s ", $1);} ;
PRE_OP: PLUS2 {printf("%s ", $1);} ;
PRE_OP: MINUS2 {printf("%s ", $1);} ;
POS_OP: PLUS2 {printf("%s ", $1);} ;
POS_OP: MINUS2 {printf("%s ", $1);} ;
MUL_OP: STAR {printf("%s ", $1);} ;
MUL_OP: DIV {printf("%s ", $1);} ;
MUL_OP: MOD {printf("%s ", $1);} ;
UN_OP: NEG {printf("%s ", $1);} ;
UN_OP: MINUS {printf("%s ", $1);} ;
UN_OP: PLUS {printf("%s ", $1);} ;
ADD_OP: PLUS {printf("%s ", $1);} ;
ADD_OP: MINUS {printf("%s ", $1);} ;
SHIFT_OP: SHIFTL {printf("%s ", $1);} ;
SHIFT_OP: SHIFTR {printf("%s ", $1);} ;
REL_OP: EQQ {printf("%s ", $1);} ;
REL_OP: NEQ {printf("%s ", $1);} ;
REL_OP: GT {printf("%s ", $1);} ;
REL_OP: LT {printf("%s ", $1);} ;
REL_OP: GEQ {printf("%s ", $1);} ;
REL_OP: LEQ {printf("%s ", $1);} ;
BITAND_OP: AMPERSEND {printf("%s ", $1);} ;
BITOR_OP: PIPE {printf("%s ", $1);} ;
LOGAND_OP: AND {printf("%s ", $1);} ;
LOGOR_OP: OR {printf("%s ", $1);} ;

%%

#include <stdio.h>
#include <ctype.h>

char *progname;
extern int line;
extern int column;
extern char* yytext;

int success = 1;

int warning(char* s, char *t) {
  fprintf(stderr, "%s in %s, line %d, column %d: unexpected %s\n", s, progname, line, column, yytext);
  if (t)
    fprintf( stderr , " %s\n" , t );
}

int yyerror(char* s) {
  if (yytext != 0 && yytext[0] != '\0') {
  	warning(s, ( char * )0 );
  	int t = yylex();
  	while (t != 0 && t != SEMI)
  		t = yylex();
  	yyparse();
  }
  success = 0;
}

int yywrap() {
  return 1;
}

int main(int argc, char* argv[]) {
  progname = argv[0];
  yyparse();
  if (success)
  	printf("Entrada lida com sucesso.\n");
  return 1;
}