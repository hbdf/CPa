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

START: { 
  printf("#include <stdio.h>\n");
  printf("#ifndef principal\n");
  printf("#define principal main\n");
  printf("#define leia scanf\n");
  printf("#define escreva printf\n");
  printf("#endif\n"); 
} INC DEC1 { printf("%s", $3.str.c_str()); };
INC: IMPORTAR STRING { preprocImportar(); } SEMI INC ;
INC: { $$.str = ""; } ;
DEC1: DEC DEC0 { $$.str = $1.str + "\n" + $2.str; };
DEC0: DEC1 { $$.str = $1.str; } ;
DEC0: { $$.str = ""; } ;
DEC: CONST_DEC { $$.str = $1.str; } ;
DEC: ID_DEC { $$.str = $1.str; } ;
DEC: STRUCT_DEC { $$.str = $1.str; } ;
DEC: ENUM_DEC { $$.str = $1.str; } ;

// Print constants
CONST_DEC: CONSTANTE TYPE ID EXPR SEMI { $$.str = "const " + $2.str + " " + $3.str + " = " + $4.str + ";"; } ;

// ID
ID_DEC: TYPE ARRAY_TYPE ID ID_SUFIX { $$.str = $1.str + " " + $3.str + $2.str + $4.str; } ;
ID_SUFIX: FUNC_DEC { $$.str = $1.str; } ;
ID_SUFIX: VAR_DEC { $$.str = $1.str; } ;

// Func
FUNC_DEC: LPAREN PARAMS RPAREN FUNC_END { $$.str = "(" + $2.str + ")" + $4.str; } ;
FUNC_END: SEMI { $$.str = ";"; };
FUNC_END: BLOCK { $$.str = $1.str; };

// Var
VAR_DEC: ID_INIT VAR_DEC1 { $$.str = $1.str + $2.str; };
VAR_DEC1: SEMI { $$.str = ";"; } ;
VAR_DEC1: COMMA ID VAR_DEC { $$.str = ", " + $2.str + $3.str; } ;

ID_INIT: ATTR INIT_VALUE { $$.str = " = " + $2.str; } ;
ID_INIT: { $$.str = ""; } ;
INIT_VALUE: EXPR { $$.str = $1.str; } ;
INIT_VALUE: ARRAY_LIT { $$.str = $1.str; } ;

// Print struct dec
STRUCT_DEC: ESTRUTURA ID LBRACE VAR_DECS RBRACE { $$.str = "struct " + $2.str + " {\n" + $4.str + "}; typedef struct " + $2.str + " " + $2.str + ";\n"; };

VAR_DECS: ID_DEC VAR_DECS { $$.str = $1.str + "\n" + $2.str; } ;
VAR_DECS: { $$.str = ""; } ;

// Print enum
ENUM_DEC: ENUM ID LBRACE IDS1 RBRACE { $$.str = "enum " + $2.str + "{\n" + $4.str + "\n}; typedef enum " + $2.str + " " + $2.str + ";\n"; } ;

// ID list
IDS1: ID IDS0 { $$.str = $1.str + $2.str; } ;
IDS0: COMMA IDS1 { $$.str = ", " + $2.str; } ;
IDS0: { $$.str = ""; } ;

// Parameters
PARAMS: PARAM1 { $$.str = $1.str; };
PARAMS: { $$.str = ""; } ;
PARAM1: TYPE ID PARAM0 { $$.str = $1.str + " " + $2.str + $3.str; } ;
PARAM0: COMMA PARAM1 { $$.str = ", " + $2.str; } ;
PARAM0: { $$.str = ""; } ;

// Print type ID
TYPE: ID { $$.str = $1.str; } ;
// Print primitive type
TYPE: TIPO_PRIMITIVO { $$.str = $1.str; } ;
// Pointer type
TYPE: STAR TYPE { $$.str = $2.str + "*"; } ;
// Array type
ARRAY_TYPE: LBRACKET EXPR RBRACKET ARRAY_TYPE { $$.str = "[" + $2.str + "]" + $4.str; } ;
ARRAY_TYPE: { $$.str = ""; } ;

// Block
BLOCK: LBRACE STMTS RBRACE { $$.str = "{\n" + $2.str + "\n}\n"; } ;
STMTS: STMT STMTS { $$.str = $1.str + "\n" + $2.str; } ;
STMTS: { $$.str = ""; } ;

// Statement
STMT: VAR ID_DEC { $$.str = $2.str; } ;
STMT: IF { $$.str = $1.str; } ;
STMT: SWITCH_CASE { $$.str = $1.str; } ;
STMT: FOR { $$.str = $1.str; } ;
STMT: WHILE { $$.str = $1.str; } ;
STMT: DO_WHILE { $$.str = $1.str; } ;
STMT: BLOCK { $$.str = $1.str; } ;

// Expr call
STMT: EXPR SEMI { $$.str = $1.str + ";"; } ;

// Return call
STMT: RETURN { $$.str = $1.str; } ;

// Break call
STMT: PARAR SEMI { $$.str = "break;"; } ;

// Continue call
STMT: CONTINUAR SEMI { $$.str = "continue;"; } ;

// Goto call
STMT: IRPARA ID SEMI { $$.str = "goto label" + $2.str + ";"; } ;

// Label define
STMT: LABEL { $$.str = "label" + $1.str; } ;

// Return
RETURN: RETORNAR RETURN_EXPR SEMI { $$.str = "return" + $2.str + ";"; } ;
RETURN_EXPR: EXPR { $$.str = " " + $1.str; } ;
RETURN_EXPR: { $$.str = ""; } ;

// If condition
IF: {
  scopeStack.push_back(getLabel());
} SE LPAREN EXPR RPAREN STMT ELSE { 
  $$.str = "if (!(" + $4.str + ")) goto else" + scopeStack.back() + ";\n";
  $$.str += $6.str + "\n";
  $$.str += "goto endif" + scopeStack.back() + ";\n";
  $$.str += "else" + scopeStack.back() + ":;\n";
  $$.str += $7.str + "\n";
  $$.str += "endif" + scopeStack.back() + ":;\n";
  scopeStack.pop_back();
} ;

// Else
ELSE: SENAO STMT { $$.str = $2.str; } ;
ELSE: { $$.str = ""; } ;

// While
WHILE: {
  scopeStack.push_back(getLabel());
} ENQUANTO LPAREN EXPR RPAREN STMT { 
  $$.str = "start" + scopeStack.back() + ":\n";
  $$.str += "if (!(" + $4.str + ")) goto end" + scopeStack.back() + ";\n";
  $$.str += $6.str + "\n";
  $$.str += "goto start" + scopeStack.back() + ";\n";
  $$.str += "end" + scopeStack.back() + ":;\n";
  scopeStack.pop_back();
} ;

// Do while
DO_WHILE: {
  scopeStack.push_back(getLabel());
} FAZER STMT ENQUANTO LPAREN EXPR RPAREN SEMI { 
  $$.str = "start" + scopeStack.back() + ":\n";
  $$.str += $3.str + "\n";
  $$.str += "if (" + $6.str + ") goto start" + scopeStack.back() + ";\n";
  $$.str += "goto start" + scopeStack.back() + ";\n";
  scopeStack.pop_back();
} ;

// For loop
FOR: PARA ID DE LPAREN EXPR RPAREN { inherit.push_back($2.str); } FOR_EXPR { 
  $$.str = "{\nint " + $2.str + " = " + $5.str + ";\n";
  $$.str += $8.str + "\n}\n"; 
  inherit.pop_back();
} ;
FOR_EXPR: FOR_ASC { $$.str = $1.str; };
FOR_EXPR: FOR_DESC { $$.str = $1.str; } ;

FOR_ASC: {
  scopeStack.push_back(getLabel());
} ASC LPAREN EXPR RPAREN STMT {
  $$.str = "start" + scopeStack.back() + ":\n";
  $$.str += "if (!(" + inherit.back() + " < " + $4.str + ")) goto end" + scopeStack.back() + ";\n";
  $$.str += $6.str;
  $$.str += inherit.back() + "++;\n";
  $$.str += "goto start" + scopeStack.back() + ";\n";
  $$.str += "end" + scopeStack.back() + ":;\n";
  scopeStack.pop_back();
};
FOR_DESC: {
  scopeStack.push_back(getLabel());
} DESC LPAREN EXPR RPAREN STMT {
  $$.str = "start" + scopeStack.back() + ":\n";
  $$.str += "if (!(" + inherit.back() + " > " + $4.str + ")) goto end" + scopeStack.back() + ";\n";
  $$.str += $6.str;
  $$.str += inherit.back() + "--;\n";
  $$.str += "goto start" + scopeStack.back() + ";\n";
  $$.str += "end" + scopeStack.back() + ":;\n";
  scopeStack.pop_back();
};

// Switch-case
SWITCH_CASE: ESCOLHA LPAREN EXPR RPAREN LBRACE CASE1 RBRACE {
  $$.str = "switch (" + $3.str + ") {\n" + $6.str + "}";
} ;
CASE1: CASE CASE0 { $$.str = $1.str + "\n" + $2.str; } ;
CASE0: CASE1 { $$.str = $1.str; } ;
CASE0: { $$.str = ""; } ;
CASE: CASO EXPR COLON STMTS {
  $$.str = "case " + $2.str + ":\n" + $4.str;
} ;
CASE: CC COLON STMTS { 
  $$.str = "default:\n" + $3.str;
} ;

// Expression
EXPR: ATTR_RULE TERNARY { $$.str = $1.str + $2.str; };

// Ternary op
TERNARY: QUESTION EXPR COLON EXPR { $$.str = " ? " + $2.str + " : " + $4.str; } ;
TERNARY: { $$.str = ""; } ;

// Attr op
ATTR_RULE: LOGOR_CHAIN {inherit.push_back($1.str);} ATTR_TAIL {inherit.pop_back(); $$.str = $1.str + $3.str;};
ATTR_TAIL: ATTR_OP LOGOR_CHAIN {
  if ($1.attr_op == 1) {
    $$.str = " = " + inherit.back() + " || " + $2.str;
  } else if ($1.attr_op == 2) {
    $$.str = " = " + inherit.back() + " && " + $2.str;
  } else {
    $$.str = $1.str + $2.str;
  }
} ;
ATTR_TAIL: { $$.str = ""; } ;

LOGOR_CHAIN: LOGAND_CHAIN LOGOR_TAIL { $$.str = $1.str + $2.str; } ;
LOGOR_TAIL: LOGOR_OP LOGOR_CHAIN { $$.str = $1.str + $2.str; } ;
LOGOR_TAIL: { $$.str = ""; } ;
LOGAND_CHAIN: BITOR_CHAIN LOGAND_TAIL { $$.str = $1.str + $2.str; } ;
LOGAND_TAIL: LOGAND_OP LOGAND_CHAIN { $$.str = $1.str + $2.str; } ;
LOGAND_TAIL: { $$.str = ""; } ;
BITOR_CHAIN: BITAND_CHAIN BITOR_TAIL { $$.str = $1.str + $2.str; } ;
BITOR_TAIL: BITOR_OP BITOR_CHAIN { $$.str = $1.str + $2.str; } ;
BITOR_TAIL: { $$.str = ""; } ;
BITAND_CHAIN: REL BITAND_TAIL { $$.str = $1.str + $2.str; } ;
BITAND_TAIL: BITAND_OP BITAND_CHAIN { $$.str = $1.str + $2.str; } ;
BITAND_TAIL: { $$.str = ""; } ;
REL: SHIFT_CHAIN REL_TAIL { $$.str = $1.str + $2.str; } ;
REL_TAIL: REL_OP SHIFT_CHAIN { $$.str = $1.str + $2.str; } ;
REL_TAIL: { $$.str = ""; } ;
SHIFT_CHAIN: ADD_CHAIN SHIFT_TAIL { $$.str = $1.str + $2.str; } ;
SHIFT_TAIL: SHIFT_OP SHIFT_CHAIN { $$.str = $1.str + $2.str; } ;
SHIFT_TAIL: { $$.str = ""; } ;
ADD_CHAIN: MUL_CHAIN ADD_TAIL { $$.str = $1.str + $2.str; } ;
ADD_TAIL: ADD_OP ADD_CHAIN { $$.str = $1.str + $2.str; } ;
ADD_TAIL: { $$.str = ""; } ;
MUL_CHAIN: UN_CHAIN MUL_TAIL { $$.str = $1.str + $2.str; } ;
MUL_TAIL: MUL_OP MUL_CHAIN { $$.str = $1.str + $2.str; } ;
MUL_TAIL: { $$.str = ""; } ;
UN_CHAIN: UN_OP UN_CHAIN { $$.str = $1.str + $2.str; } ;
UN_CHAIN: EXPR_LEAF { $$.str = $1.str; } ;

// Leaf
EXPR_LEAF: PRE_OP EXPR_LEAF { $$.str = $1.str + $2.str; } ;
EXPR_LEAF: VAR_CALL { $$.str = $1.str; } ;
EXPR_LEAF: EXPR_LIT { $$.str = $1.str; } ;
EXPR_LEAF: LPAREN EXPR RPAREN { $$.str = "(" + $2.str + ")"; } ;
VAR_CALL: VAR_LEAF CALL { $$.str = $1.str + $2.str; } ;
CALL: LPAREN ARGS RPAREN { $$.str = "(" + $2.str + ")"; } ;
CALL: POS_OP { $$.str = $1.str; };
CALL: { $$.str = ""; } ;

// Args
ARGS1: EXPR ARGS0 { $$.str = $1.str + $2.str; } ;
ARGS0: COMMA ARGS { $$.str = ", " + $2.str; } ;
ARGS0: { $$.str = ""; } ;
ARGS: ARGS1 { $$.str = $1.str; };
ARGS: { $$.str = ""; } ;

// Literals
EXPR_LIT: INTEIRO { $$.str = $1.str; } ;
EXPR_LIT: REAL { $$.str = $1.str; } ;
EXPR_LIT: REALD { $$.str = $1.str; } ;
EXPR_LIT: STRING { $$.str = $1.str; } ;
EXPR_LIT: CARACTERE { $$.str = $1.str; } ;

// Array
ARRAY_LIT: LBRACE ARGS1 RBRACE { $$.str = "{" + $2.str + "}"; } ;
VAR_LEAF: ID VAR_MODS { $$.str = $1.str + $2.str; } ;

// Var field
VAR_MODS: DOT ID VAR_MODS { $$.str = "." + $2.str + $3.str; };
VAR_MODS: LBRACKET EXPR RBRACKET VAR_MODS { $$.str = "[" + $2.str + "]" + $4.str; };
VAR_MODS: { $$.str = ""; };

// Attr OP
ATTR_OP: ATTR { $$.str = " = "; $$.attr_op = 0; } ;
ATTR_OP: ATTRADD { $$.str = " += "; $$.attr_op = 0; } ;
ATTR_OP: ATTRSUB { $$.str = " -= "; $$.attr_op = 0; } ;
ATTR_OP: ATTRMUL { $$.str = " *= "; $$.attr_op = 0; } ;
ATTR_OP: ATTRDIV { $$.str = " /= "; $$.attr_op = 0; } ;
ATTR_OP: ATTRMOD { $$.str = " %= "; $$.attr_op = 0; } ;
ATTR_OP: ATTRBITOR { $$.str = " |= "; $$.attr_op = 0; } ;
ATTR_OP: ATTRBITAND { $$.str = " &= "; $$.attr_op = 0; } ;
ATTR_OP: ATTRSHIFTL { $$.str = " <<= "; $$.attr_op = 0; } ;
ATTR_OP: ATTRSHIFTR { $$.str = " >>= "; $$.attr_op = 0; } ;

// Custom attr op
ATTR_OP: ATTROR { $$.attr_op = 1; } ;
ATTR_OP: ATTRAND { $$.attr_op = 2; } ;

// Un-op
PRE_OP: STAR {$$.str = "*";} ;
PRE_OP: AMPERSEND {$$.str = " &";} ;
PRE_OP: PLUS2 {$$.str = " ++";} ;
PRE_OP: MINUS2 {$$.str = " --";} ;
POS_OP: PLUS2 {$$.str = "++ ";} ;
POS_OP: MINUS2 {$$.str = "-- ";} ;

// Bin-op
MUL_OP: STAR { $$.str = " * "; } ;
MUL_OP: DIV { $$.str = " / "; } ;
MUL_OP: MOD { $$.str = " % "; } ;
UN_OP: NEG { $$.str = " ! "; } ;
UN_OP: MINUS {$$.str = " - "; } ;
UN_OP: PLUS {$$.str = " + "; } ;
ADD_OP: PLUS {$$.str = " + "; } ;
ADD_OP: MINUS {$$.str = " - "; } ;
SHIFT_OP: SHIFTL {$$.str = " << "; } ;
SHIFT_OP: SHIFTR {$$.str = " >> "; } ;
REL_OP: EQQ {$$.str = " == "; } ;
REL_OP: NEQ {$$.str = " != "; } ;
REL_OP: GT {$$.str = " > "; } ;
REL_OP: LT {$$.str = " < "; } ;
REL_OP: GEQ { $$.str = " >= "; } ;
REL_OP: LEQ { $$.str = " <= " ; } ;
BITAND_OP: AMPERSEND { $$.str = " & "; } ;
BITOR_OP: PIPE {$$.str = " | "; } ;
LOGAND_OP: AND {$$.str = " && "; } ;
LOGOR_OP: OR { $$.str = " || "; } ;

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