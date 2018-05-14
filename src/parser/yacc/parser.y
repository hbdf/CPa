%{

#include <alloca.h>
#include <math.h>
#include <stdlib.h>
#include <stddef.h>
#include <ctype.h>
#include <stdio.h>

int yylex(void);
int yyerror(char* s);
void preprocImportar();

%}

%define api.value.type {char*}

%token IMPORTAR 	STRING 	SEMI 	CONSTANTE 	ID 	LPAREN 	RPAREN 	COMMA 	ATTR 	ESTRUTURA 	LBRACE 	RBRACE 	ENUM 	TIPO_PRIMITIVO 	STAR 	LBRACKET 	RBRACKET 	VAR 	PARAR 	CONTINUAR 	IRPARA 	LABEL 	RETORNAR 	SE 	SENAO 	ENQUANTO 	FAZER 	PARA 	DE 	ASC 	DESC 	ESCOLHA 	CASO 	COLON 	CC 	QUESTION 	INTEIRO 	REAL 	REALD 	CARACTERE 	DOT 	ATTRADD 	ATTRSUB 	ATTRMUL 	ATTRDIV 	ATTRMOD 	ATTRBITOR 	ATTROR 	ATTRBITAND 	ATTRAND 	ATTRSHIFTL 	ATTRSHIFTR 	AMPERSEND 	PLUS2 	MINUS2 	DIV 	MOD 	NEG 	MINUS 	PLUS 	SHIFTL 	SHIFTR 	EQQ 	NEQ 	GT 	LT 	GEQ 	LEQ 	PIPE 	AND 	OR

%token-table

%%

START: INC DEC1 ;
INC: IMPORTAR STRING { preprocImportar(); } SEMI INC ;
INC:  ;
DEC1: DEC DEC0 ;
DEC0: DEC1 ;
DEC0:  ;
DEC: CONST_DEC ;
DEC: ID_DEC ;
DEC: STRUCT_DEC ;
DEC: ENUM_DEC ;

// Print constants
CONST_DEC: CONSTANTE { printf("const "); } TYPE ID { printf("%s ", $4); } EXPR SEMI {printf(";\n"); };

// Print array ID
ID_DEC: TYPE ARRAY_TYPE ID { printf("%s ", $3); } ID_SUFIX ;

ID_SUFIX: FUNC_DEC ;
ID_SUFIX: VAR_DEC ;
FUNC_DEC: LPAREN { printf("("); } PARAMS RPAREN { printf(")"); } FUNC_END ;
FUNC_END: SEMI ;
FUNC_END: BLOCK ;
VAR_DEC: ID_INIT VAR_DEC1 ;

// Print var semi
VAR_DEC1: SEMI { printf(";\n"); } ;

// Print var ID
VAR_DEC1: COMMA ID {printf(", %s ", $2); } VAR_DEC ;

ID_INIT: ATTR EXPR ;
ID_INIT: ;

// Print struct dec
STRUCT_DEC: ESTRUTURA ID LBRACE {printf("struct %s {\n", $2); } VAR_DECS RBRACE { printf("}\n"); };

VAR_DECS: ID_DEC VAR_DECS ;
VAR_DECS:  ;

// Print enum
ENUM_DEC: ENUM ID LBRACE { printf("enum %s {\n", $2); } IDS1 RBRACE { printf("\n}\n"); };

// Print ID list
IDS1: ID { printf("%s ", $1); } IDS0 ;
IDS0: COMMA { printf(", "); } IDS1 ;

IDS0:  ;
PARAMS: PARAM1 ;
PARAMS:  ;
PARAM1: TYPE ID PARAM0 ;
PARAM0: COMMA PARAM1 ;
PARAM0:  ;

// Print type ID
TYPE: ID { printf("%s ", $1); } ;
// Print primitive type
TYPE: TIPO_PRIMITIVO { printf("%s ", $1); } ;
// Pointer type
TYPE: STAR TYPE { printf("* "); };
// Array type
ARRAY_TYPE: LBRACKET { printf("["); } EXPR RBRACKET { printf("]"); } ARRAY_TYPE ;
ARRAY_TYPE:  ;

// Block
BLOCK: LBRACE { printf("{\n"); } STMTS RBRACE { printf("}\n"); } ;

STMTS: STMT STMTS ;
STMTS:  ;
STMT: VAR ID_DEC ;
STMT: IF ;
STMT: SWITCH_CASE ;
STMT: FOR ;
STMT: WHILE ;
STMT: DO_WHILE ;
STMT: BLOCK ;

// Expr call
STMT: EXPR SEMI { printf(";\n"); } ;

// Return call
STMT: RETURN ;

// 
STMT: PARAR SEMI {printf("%s %s\n", $1, $2); } ;
STMT: CONTINUAR SEMI {printf("%s %s\n", $1, $2); } ;
STMT: IRPARA ID SEMI {printf("%s %s %s\n", $1, $2, $3); } ;
STMT: LABEL {printf("%s\n", $1); } ;


RETURN: RETORNAR {printf("%s ", $1);} RETURN_EXPR SEMI {printf("%s\n", $4); } ;
RETURN_EXPR: EXPR ;
RETURN_EXPR:  ;
IF: SE LPAREN {printf("%s %s ", $1, $2);} EXPR RPAREN {printf("%s ", $5);} STMT ELSE ;
ELSE: SENAO {printf("%s ", $1);} STMT ;
ELSE:  ;
WHILE: ENQUANTO LPAREN {printf("%s %s ", $1, $2);} EXPR RPAREN {printf("%s ", $5);} STMT ;
DO_WHILE: FAZER {printf("%s ", $1);} STMT ENQUANTO LPAREN {printf("%s %s ", $4, $5);} EXPR RPAREN SEMI {printf("%s %s\n", $8, $9); } ;
FOR: PARA ID DE LPAREN {printf("%s %s %s %s ", $1, $2, $3, $4);} EXPR RPAREN {printf("%s ", $7);} FOR_EXPR ;
FOR_EXPR: FOR_ASC ;
FOR_EXPR: FOR_DESC ;
FOR_ASC: ASC LPAREN {printf("%s %s ", $1, $2);} EXPR RPAREN {printf("%s ", $5);} STMT ;
FOR_DESC: DESC LPAREN {printf("%s %s ", $1, $2);} EXPR RPAREN {printf("%s ", $5);} STMT ;
SWITCH_CASE: ESCOLHA LPAREN {printf("%s %s ", $1, $2);} EXPR RPAREN {printf("%s ", $5);} LBRACE { printf("%s\n", $7); } CASE1 RBRACE { printf("%s\n", $10); } ;
CASE1: CASE CASE0 ;
CASE0: CASE1 ;
CASE0:  ;
CASE: CASO {printf("%s ", $1);} EXPR COLON {printf("%s\n", $4); } STMTS ;
CASE: CC COLON { printf("%s %s\n", $1, $2); } STMTS ;
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
char* currentFile;
extern int line;
extern int column;
extern char* yytext;

int success = 1;
int warning(char* s, char *t) {
  fprintf(stderr, "%s in %s, line %d, column %d: unexpected %s\n", s, currentFile, line, column, yytext);
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

void preprocImportar () {
  //printf("--%s--\n", yytext);
  currentFile = yytext;
  char command [100] = "./cpa < ../../../samples/";
  strcat(command, yytext);
  system(command);

}

int main(int argc, char* argv[]) {
  progname = argv[0];
  yyparse();
  if (success)
  	printf("Entrada lida com sucesso.\n");
  return 1;
}