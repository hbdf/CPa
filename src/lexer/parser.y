%{

#include <stdio.h>
#include <ctype.h>
#include <alloca.h>
#include <math.h>
#include <stdlib.h>
#include <stddef.h>
#include <ctype.h>
char *progname;

%}

%token STRING CHAR INTEIRO REAL REALD TIPO_PRIMITIVO ID
%token ENUM ESTRUTURA IMPORTAR CONSTANTE PARAR CONTINUAR RETORNAR IRPARA SE CC SENAO ESCOLHA CASO PARA DE ASC DESC FAZER 
%token SEMI COLON DOT COMMA LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE 
%token QUESTION PLUS2 PLUS MINUS2 MINUS AMPERSEND AND BITOR OR STAR DIV EQQ NEQ LEQ GEQ NEG LT GT SHIFTL SHIFTR
%token ATTR ATTRADD ATTRSUB ATTRMUL ATTRDIV ATTRSHIFTL ATTRSHIFTR ATTRBITOR ATTROR ATTRAMPERSEND ATTRAND 

%%

list:   /* nothing */
        ;

%%

int main(int argc, char* argv[]) {
  progname = argv[0];
  //strcpy(format,"%g\n");
  //yyparse();
}
 
yyerror(char* s) {
  warning(s, ( char * )0 );
  yyparse();
}
 
warning(char* s, char *t) {
  //fprintf(stderr ,"%s: %s\n" , progname , s );
  if (t)
    fprintf( stderr , " %s\n" , t );
}