%{

#include <alloca.h>
#include <math.h>
#include <stdlib.h>
#include <stddef.h>
#include <ctype.h>
#include <stdio.h>
#include <string>
#include <vector>
#include <bits/stdc++.h>
using namespace std;

int yylex(void);
int yyerror(char* s);
void preprocImportar();
string getLabel();

deque<string> inherit;
vector<string> scopeStack;
int labelCount = 0;

%}

%define api.value.type {struct {
  std::string str;
  int attr_op;
}}

%token IMPORTAR 	STRING 	SEMI 	CONSTANTE 	ID 	LPAREN 	RPAREN 	COMMA 	ATTR 	ESTRUTURA 	LBRACE 	RBRACE 	ENUM 	TIPO_PRIMITIVO 	STAR 	LBRACKET 	RBRACKET 	VAR 	PARAR 	CONTINUAR 	IRPARA 	LABEL 	RETORNAR 	SE 	SENAO 	ENQUANTO 	FAZER 	PARA 	DE 	ASC 	DESC 	ESCOLHA 	CASO 	COLON 	CC 	QUESTION 	INTEIRO 	REAL 	REALD 	CARACTERE 	DOT 	ATTRADD 	ATTRSUB 	ATTRMUL 	ATTRDIV 	ATTRMOD 	ATTRBITOR 	ATTROR 	ATTRBITAND 	ATTRAND 	ATTRSHIFTL 	ATTRSHIFTR 	AMPERSEND 	PLUS2 	MINUS2 	DIV 	MOD 	NEG 	MINUS 	PLUS 	SHIFTL 	SHIFTR 	EQQ 	NEQ 	GT 	LT 	GEQ 	LEQ 	PIPE 	AND 	OR

%token-table

%%

START: { printf("#define leia printf \n#define escreva scanf \n"); } INC DEC1 ;
INC: IMPORTAR STRING { preprocImportar(); } SEMI INC ;
INC:  ;
DEC1: DEC DEC0 ;
DEC0: DEC1 ;
DEC0: ;
DEC: CONST_DEC ;
DEC: ID_DEC ;
DEC: STRUCT_DEC ;
DEC: ENUM_DEC ;

// Print constants
CONST_DEC: CONSTANTE { printf("const "); } TYPE ID { printf("%s = ", $4.str.c_str()); } EXPR SEMI {printf(";\n"); };

// Print array ID
ID_DEC: TYPE ARRAY_TYPE ID { printf("%s ", $3.str.c_str()); } ID_SUFIX ;

ID_SUFIX: FUNC_DEC ;
ID_SUFIX: VAR_DEC ;
FUNC_DEC: LPAREN { printf("("); } PARAMS RPAREN { printf(")"); } FUNC_END ;
FUNC_END: SEMI ;
FUNC_END: BLOCK ;
VAR_DEC: ID_INIT VAR_DEC1 ;

// Print var semi
VAR_DEC1: SEMI { printf(";\n"); } ;

// Print var ID
VAR_DEC1: COMMA ID { printf(", %s ", $2.str.c_str()); } VAR_DEC ;

ID_INIT: ATTR { printf("= "); } INIT_VALUE ;
ID_INIT: ;
INIT_VALUE: EXPR ;
INIT_VALUE: ARRAY_LIT ;

// Print struct dec
STRUCT_DEC: ESTRUTURA ID LBRACE {printf("struct %s {\n", $2.str.c_str()); } VAR_DECS RBRACE { printf("}\n"); };

VAR_DECS: ID_DEC VAR_DECS ;
VAR_DECS:  ;

// Print enum
ENUM_DEC: ENUM ID LBRACE { printf("enum %s {\n", $2.str.c_str()); } IDS1 RBRACE { printf("\n}\n"); };

// Print ID list
IDS1: ID { printf("%s ", $1.str.c_str()); } IDS0 ;
IDS0: COMMA { printf(", "); } IDS1 ;

IDS0:  ;
PARAMS: PARAM1 ;
PARAMS:  ;
PARAM1: TYPE ID { printf("%s ", $2.str.c_str()); } PARAM0 ;
PARAM0: COMMA { printf(","); } PARAM1 ;
PARAM0:  ;

// Print type ID
TYPE: ID { printf("%s ", $1.str.c_str()); } ;
// Print primitive type
TYPE: TIPO_PRIMITIVO { printf("%s ", $1.str.c_str()); } ;
// Pointer type
TYPE: STAR TYPE { printf("* "); };
// Array type
ARRAY_TYPE: LBRACKET { printf("["); } EXPR RBRACKET { printf("]"); } ARRAY_TYPE ;
ARRAY_TYPE: ;

// Block
BLOCK: LBRACE { printf("{\n"); } STMTS RBRACE { printf("}\n"); } ;

STMTS: STMT STMTS ;
STMTS: ;
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

// Break call
STMT: PARAR SEMI { printf("break;\n"); } ;

// Continue call
STMT: CONTINUAR SEMI {printf("continue;\n"); } ;

// Goto call
STMT: IRPARA ID SEMI {printf("goto %s ;\n", $2.str.c_str()); } ;

// Label define
STMT: LABEL { printf("%s\n", $1.str.c_str()); } ;

// Return
RETURN: RETORNAR { printf("return "); } RETURN_EXPR SEMI {printf(";\n"); } ;
RETURN_EXPR: EXPR ;
RETURN_EXPR: ;

// If condition
IF: SE LPAREN { printf("if ("); } EXPR RPAREN { printf(") "); } STMT ELSE ;

// Else
ELSE: SENAO { printf("else "); } STMT ;
ELSE: ;

// While
WHILE: ENQUANTO LPAREN { printf("while ("); } EXPR RPAREN { printf(")"); } STMT ;

// Do while
DO_WHILE: FAZER { printf("do "); } STMT ENQUANTO LPAREN { printf("while ("); } EXPR RPAREN SEMI { printf(");\n"); } ;

// For loop
FOR: PARA ID DE LPAREN {printf("%s = ", $2.str.c_str());} EXPR RPAREN {
    printf(";\n");
    inherit.push_back($2.str);
} FOR_EXPR ;
FOR_EXPR: FOR_ASC ;
FOR_EXPR: FOR_DESC ;

FOR_ASC: ASC LPAREN {
    string labelFor = getLabel();
    scopeStack.push_back(labelFor);
    printf("%s:\n", labelFor.c_str());
    printf("if(!(%s < ", inherit.back().c_str());
} EXPR RPAREN {
    printf(")){goto %s;}\n", ("End" + scopeStack.back()).c_str());
} STMT {
    printf("%s++;\n", inherit.back().c_str());
    printf("goto %s;\n", scopeStack.back().c_str());
    printf("%s:;\n", ("End" + scopeStack.back()).c_str());
    scopeStack.pop_back();
    inherit.pop_back();
};

FOR_DESC: DESC LPAREN {
    string labelFor = getLabel();
    scopeStack.push_back(labelFor);
    printf("%s:\n", labelFor.c_str());
    printf("if(!(%s > ", inherit.back().c_str());
} EXPR RPAREN {
    printf(")){goto %s;}\n", ("End" + scopeStack.back()).c_str());
} STMT {
    printf("%s--;\n", inherit.back().c_str());
    printf("goto %s;\n", scopeStack.back().c_str());
    printf("%s:;\n", ("End" + scopeStack.back()).c_str());
    scopeStack.pop_back();
    inherit.pop_back();
};

// Switch-case
SWITCH_CASE: ESCOLHA LPAREN {
  printf("%s %s ", $1.str.c_str(), $2.str.c_str());
} EXPR RPAREN {
  printf("%s ", $5.str.c_str());
} LBRACE { 
  printf("%s\n", $7.str.c_str()); 
} CASE1 RBRACE { printf("%s\n", $10.str.c_str()); } ;
CASE1: CASE CASE0 ;
CASE0: CASE1 ;
CASE0: ;
CASE: CASO {printf("%s ", $1.str.c_str());} EXPR COLON {printf("%s\n", $4.str.c_str()); } STMTS ;
CASE: CC COLON { printf("%s %s\n", $1.str.c_str(), $2.str.c_str()); } STMTS ;

// Ternary op
TERNARY: QUESTION { printf(" ? "); } EXPR COLON { printf(" : "); } EXPR ;
TERNARY: ;

EXPR: ATTR_RULE TERNARY ;

// Attr op
ATTR_RULE: LOGOR_CHAIN {inherit.push_back($1.str);} ATTR_TAIL {inherit.pop_back();};
ATTR_TAIL: ATTR_OP {
  if ($1.attr_op == 1) {
    printf(" = %s || ", inherit.back().c_str());
  } else if ($1.attr_op == 2) {
    printf(" = %s && ", inherit.back().c_str());
  }
} LOGOR_CHAIN ;
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

// Print parens
EXPR_LEAF: LPAREN { printf("("); } EXPR RPAREN { printf(")"); } ;
VAR_CALL: VAR_LEAF CALL ;
CALL: LPAREN { printf("("); } ARGS RPAREN { printf(")"); } ;
CALL: POS_OP ;
CALL: ;

// Print args
ARGS1: EXPR ARGS0 ;
ARGS0: COMMA { printf(","); } ARGS ;
ARGS0: ;
ARGS: ARGS1 ;
ARGS: ;

// Literals
EXPR_LIT: INTEIRO {printf("%s ", $1.str.c_str());} ;
EXPR_LIT: REAL {printf("%s ", $1.str.c_str());} ;
EXPR_LIT: REALD {printf("%s ", $1.str.c_str());} ;
EXPR_LIT: STRING {printf("%s ", $1.str.c_str());} ;
EXPR_LIT: CARACTERE {printf("%s ", $1.str.c_str());} ;

// Array
ARRAY_LIT: LBRACE { printf("{"); } ARGS1 RBRACE { printf("}"); } ;
VAR_LEAF: ID { printf("%s", $1.str.c_str()); } VAR_MODS ;

// Print var field
VAR_MODS: DOT ID { printf(".%s", $2.str.c_str()); } VAR_MODS ;
VAR_MODS: LBRACKET { printf("["); } EXPR RBRACKET { printf("]"); } VAR_MODS ;
VAR_MODS: ;

// Print attr OP
ATTR_OP: ATTR {printf(" = ");} ;
ATTR_OP: ATTRADD {printf(" += "); } ;
ATTR_OP: ATTRSUB {printf(" -= "); } ;
ATTR_OP: ATTRMUL {printf(" *= "); } ;
ATTR_OP: ATTRDIV {printf(" /= "); } ;
ATTR_OP: ATTRMOD {printf(" %%= "); } ;
ATTR_OP: ATTRBITOR {printf(" |= ");} ;
ATTR_OP: ATTRBITAND {printf(" &= ");} ;
ATTR_OP: ATTRSHIFTL {printf(" <<= "); } ;
ATTR_OP: ATTRSHIFTR {printf(" >>= "); } ;

// Custom attr op
ATTR_OP: ATTROR { $$.attr_op = 1; } ;
ATTR_OP: ATTRAND { $$.attr_op = 2; } ;

// Un-op
PRE_OP: STAR {printf("*");} ;
PRE_OP: AMPERSEND {printf(" &");} ;
PRE_OP: PLUS2 {printf(" ++");} ;
PRE_OP: MINUS2 {printf(" --");} ;
POS_OP: PLUS2 {printf("++ ");} ;
POS_OP: MINUS2 {printf("-- ");} ;

// Bin-op
MUL_OP: STAR {printf(" * ");} ;
MUL_OP: DIV {printf(" / ");} ;
MUL_OP: MOD {printf(" %% ");} ;
UN_OP: NEG {printf(" ! ");} ;
UN_OP: MINUS {printf(" - ");} ;
UN_OP: PLUS {printf(" + ");} ;
ADD_OP: PLUS {printf(" + ");} ;
ADD_OP: MINUS {printf(" - ");} ;
SHIFT_OP: SHIFTL {printf(" << ");} ;
SHIFT_OP: SHIFTR {printf(" >> ");} ;
REL_OP: EQQ {printf(" == ");} ;
REL_OP: NEQ {printf(" != ");} ;
REL_OP: GT {printf(" > ");} ;
REL_OP: LT {printf(" < ");} ;
REL_OP: GEQ {printf(" >= ");} ;
REL_OP: LEQ {printf(" <= ");} ;
BITAND_OP: AMPERSEND {printf(" & ");} ;
BITOR_OP: PIPE {printf(" | ");} ;
LOGAND_OP: AND {printf(" && ");} ;
LOGOR_OP: OR {printf(" || ");} ;

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

string getLabel() {
  return "label" + to_string(labelCount++);
}

int main(int argc, char* argv[]) {
  progname = argv[0];
  yyparse();
  //if (success)
  	//printf("Entrada lida com sucesso.\n");
  return 1;
}


// string formatFor(string id, string start, string end, string increment, string ascdesc, string body) {
//  string flabel = "for" + for_label_count + ":";
//  string condition = "if ("
//
//  string update_counter = id + ((ascdesc == "ASC") ? "++" : "--");
//  for_label_count++;
// }