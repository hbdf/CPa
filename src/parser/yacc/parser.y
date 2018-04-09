%{

#include <alloca.h>
#include <math.h>
#include <stdlib.h>
#include <stddef.h>
#include <ctype.h>

%}

%token STRING CHAR INTEIRO REAL REALD TIPO_PRIMITIVO ID
%token ENUM ESTRUTURA IMPORTAR CONSTANTE PARAR CONTINUAR RETORNAR IRPARA SE CC SENAO ESCOLHA CASO PARA DE ASC DESC FAZER ENQUANTO 
%token SEMI COLON DOT COMMA LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE 
%token QUESTION PLUS2 PLUS MINUS2 MINUS AMPERSEND AND PIPE OR STAR DIV MOD EQQ NEQ LEQ GEQ NEG LT GT SHIFTL SHIFTR
%token ATTR ATTRADD ATTRSUB ATTRMUL ATTRDIV ATTRMOD ATTRSHIFTL ATTRSHIFTR ATTRBITOR ATTROR ATTRBITAND ATTRAND 

%%

list: inc dec1 ; 

inc: IMPORTAR STRING SEMI inc |  ; 

dec1: dec dec0 ; 
dec0: dec1 |  ; 
dec: const_dec | var_dec | func_dec | struct_dec | enum_dec ; 

const_dec: CONSTANTE type ID expr SEMI ; 

var_dec1: var_dec var_dec0 ; 
var_dec0: var_dec1 |  ; 
var_dec: type id_dec1 SEMI ; 

id_dec1: ID id_init id_dec0 ; 
id_dec0: COMMA id_dec1 |  ; 
id_init: ATTR expr |  ; 

struct_dec: ESTRUTURA ID LBRACE var_dec1 RBRACE ; 

enum_dec: ENUM ID LBRACE ids1 RBRACE ; 
ids1: ID ids0 ; 
ids0: COMMA ids1 |  ; 

func_dec: func_sign func_end ; 
func_end: SEMI | block ; 
func_sign: type ID LPAREN params RPAREN ; 

params: param1 |  ; 
param1: type ID param0 ; 
param0: COMMA param1 |  ; 

type: basic_type array_type | LPAREN type RPAREN ; 
basic_type: ID | TIPO_PRIMITIVO | STAR type ; 
array_type: LBRACKET expr RBRACKET array_type |  ; 

block: LBRACE stmts RBRACE ; 
stmts: stmt stmts |  ; 

stmt: dec | if | switch_case | for | while | do_while | block | expr SEMI | RETORNAR SEMI | RETORNAR expr SEMI | PARAR SEMI | CONTINUAR SEMI | IRPARA ID SEMI | ID COLON ; 

if: SE LPAREN expr RPAREN stmt else ; 
else: SENAO stmt |  ; 

while: ENQUANTO LPAREN expr RPAREN stmt ; 
do_while: FAZER stmt ENQUANTO LPAREN expr RPAREN SEMI ; 

for: PARA ID DE LPAREN expr RPAREN for_expr ; 
for_expr: for_asc | for_desc ; 
for_asc: ASC LPAREN expr RPAREN stmt ; 
for_desc: DESC LPAREN expr RPAREN stmt ; 

switch_case: ESCOLHA LPAREN expr RPAREN LBRACE case1 RBRACE ;
case1: case case0 ;
case0: case1 | ;
case: CASO expr COLON stmts | CC COLON stmts ;

expr: attr ternary ; 

ternary: QUESTION expr COLON expr |  ; 

attr: logor_chain attr_tail ; 
attr_tail: attr_op logor_chain |  ; 

logor_chain: logand_chain logor_tail ; 
logor_tail: logor_op logor_chain |  ; 

logand_chain: bitor_chain logand_tail ; 
logand_tail: logand_op logand_chain |  ; 

bitor_chain: bitand_chain bitor_tail ; 
bitor_tail: bitor_op bitor_chain |  ; 

bitand_chain: rel bitand_tail ; 
bitand_tail: bitand_op bitand_chain |  ; 

rel: shift_chain rel_tail ; 
rel_tail: rel_op shift_chain |  ; 

shift_chain: add_chain shift_tail ; 
shift_tail: shift_op shift_chain |  ; 

add_chain: mul_chain add_tail ; 
add_tail: add_op add_chain |  ; 

mul_chain: un_chain mul_tail ; 
mul_tail: mul_op mul_chain |  ; 

un_chain: un_op un_chain | expr_leaf ; 

expr_leaf: pre_op expr_leaf | var_call | expr_lit | LPAREN expr RPAREN ; 

var_call: var call  ; 
call: LPAREN args RPAREN  | pos_op |  ; 
args1: expr args0 ; 
args0: COMMA args |  ; 
args: args1 |  ; 

expr_lit: INTEIRO | REAL | STRING | CHAR | array_lit ; 
array_lit: LBRACE args1 RBRACE ; 

var: ID var_mods ; 
var_mods: DOT ID var_mods | LBRACKET expr RBRACKET var_mods |  ; 

attr_op: ATTR | ATTRADD | ATTRSUB | ATTRMUL | ATTRDIV | ATTRMOD | ATTRSHIFTL | ATTRSHIFTR | ATTRBITOR | ATTROR | ATTRBITAND | ATTRAND ; 
pre_op: STAR | AMPERSEND | PLUS2 | MINUS2 ; 
pos_op: PLUS2 | MINUS2 ; 
mul_op: STAR | DIV | MOD ; 
un_op: NEG | MINUS | PLUS ; 
add_op: PLUS | MINUS ; 
shift_op: SHIFTL | SHIFTR ; 
rel_op: EQQ | NEQ | LEQ | GEQ | LT | GT ; 
bitand_op: AMPERSEND ; 
bitor_op: PIPE ; 
logand_op: AND ; 
logor_op: OR ;

%%

#include <stdio.h>
#include <ctype.h>

char *progname;
int line = 1;
int column = 1;
char* lexem;

int warning(char* s, char *t) {
  fprintf(stderr, "%s in %s, line %d, column %d: unexpected %s\n", s, progname, line, column, lexem);
  if (t)
    fprintf( stderr , " %s\n" , t );
}

int yyerror(char* s) {
  warning(s, ( char * )0 );
  yyparse();
}

int main(int argc, char* argv[]) {
  progname = argv[0];
  //strcpy(format,"%g\n");
  yyparse();
}
