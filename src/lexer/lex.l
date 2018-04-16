%{

/*
 * CPa lexer
 */

#include "parser.tab.h"
#include <math.h>
int line = 1;
int columm = 1;
double yyNum;
char* yyString;

void stringToken(const char* lexem) {
	yyString = lexem;
	columm += yyleng;
}

void numToken(const char* lexem) {
	yyNum = atoi(lexem);
	columm += yyleng;
}

void error(){
	printf("[ERRO] - linha: %d, coluna: %d ", line, columm);
	columm += yyleng;
}

%}

/* Caracteres especiais OK */
STAR			"*"
PLUS2 			"++"
PLUS 			"+"
MINUS2 			"--"
MINUS 			"-"
AMPERSEND 		"&"
AND 			"&&"
BITOR 			"|"
OR 				"||"
DIV 			"/"
ATTRADD 		"+="
ATTRSUB 		"-="
ATTRMUL 		"*="
ATTRDIV 		"/="
ATTRSHIFTL 		">>="
ATTRSHIFTR 		"<<="
ATTRBITOR 		"|="
ATTROR 			"||="
ATTRAMPERSEND 	"&="
ATTRAND 		"&&="
EQQ 			"=="
NEQ 			"!="
LEQ 			"<="
GEQ 			">="
ATTR 			"="
NEG 			"!"
LT 				"<"
GT 				">"
SHIFTL 			"<<"
SHIFTR 			">>"
/* Pontuação OK */
SEMI 			";"
COLON 			":"
DOT 			"."
COMMA 			","
LPAREN 			"("
RPAREN 			")"
LBRACKET 		"["
RBRACKET 		"]"
LBRACE 			"{"
RBRACE 			"}"
QUESTION 		"?"
/* Tipos Primitivos OK */
TIPO_PRIMITIVO  int|real|duplo|caractere|vazio
/* Palavras Reservadas OK */
IMPORTAR 		importar
CONSTANTE 		const
PARAR 			parar
CONTINUAR 		continuar
RETORNAR 		retornar
IRPARA 			irpara
SE 				se
CC 				cc
SENAO 			senao
ESCOLHA 		escolha
CASO 			caso
PARA 			para
DE 				de
ASC 			asc
DESC 			desc
FAZER 			fazer
ESTRUTURA		estrutura
ENUM			enum
/* Outros */
BLOCKCOMMENT	"/*"([^*]|"*"+[^*/])*"*"+"/"
LINECOMMENT		"//"[^"\n"]*"\n"
ID				(_*{LETTER}|{LETTER})({LETTER}|{DIGIT}|_)*
LETTER			[a-zA-Z]
HEX				-?0x({DIGIT}|[A-Fa-f])+
DIGIT			[0-9]
INTEIRO			-?{DIGIT}+|{HEX}
FRAC			-?({DIGIT}*{DOT}{DIGIT}+|{DIGIT}+{DOT}{DIGIT}*)
SCINOT			e-?{DIGIT}+
REAL			({FRAC}|-?{DIGIT}+|-?{DIGIT}+{SCINOT})f
REALD			{FRAC}|{FRAC}{SCINOT}|-?{DIGIT}+{SCINOT}
CHAR			\'([^'\\]|(\\).)\'
STRING			\"([^"\\]|(\\).)*\"
%%

[\t ]+ {
	columm += yyleng;
}
[\n ]	{
	columm = 1;
	line++;
}
{BLOCKCOMMENT} {}
{LINECOMMENT} {}
{STRING} {
	stringToken(yytext); return STRING;
}
{CHAR} {
	stringToken(yytext); return CHAR;
}
{INTEIRO} {
	numToken(yytext); return INTEIRO;
}
{REAL} {
	numToken(yytext); return REAL;
}
{REALD} {
	numToken(yytext); return REALD;
}
{STAR} {
	return STAR;
}
{TIPO_PRIMITIVO} {
	stringToken(yytext); return TIPO_PRIMITIVO;
}
{IMPORTAR} {
	return IMPORTAR;
}
{CONSTANTE} {
	return CONSTANTE;
}
{PARAR} {
	return PARAR;
}
{CONTINUAR} {
	return CONTINUAR;
}
{RETORNAR} {
	return RETORNAR;
}
{IRPARA} {
	return IRPARA;
}
{SE} {
	return SE;
}
{CC} {
	return CC;
}
{SENAO} {
	return SENAO;
}
{ESCOLHA} {
	return ESCOLHA;
}
{CASO} {
	return CASO;
}
{PARA} {
	return PARA;
}
{DE} {
	return DE;
}
{ASC} {
	return ASC;
}
{DESC} {
	return DESC;
}
{FAZER} {
	return FAZER;
}
{SEMI} {
	return SEMI;
}
{COLON} {
	return COLON;
}
{DOT} {
	return DOT;
}
{COMMA} {
	return COMMA;
}
{LPAREN} {
	return LPAREN;
}
{RPAREN} {
	return RPAREN;
}
{LBRACKET} {
	return LBRACKET;
}
{RBRACKET} {
	return RBRACKET;
}
{LBRACE} {
	return LBRACE;
}
{RBRACE} {
	return RBRACE;
}
{QUESTION} {
	return QUESTION;
}
{PLUS2} {
	return PLUS2;
}
{PLUS} {
	return PLUS;
}
{MINUS2} {
	return MINUS2;
}
{MINUS} {
	return MINUS;
}
{AMPERSEND} {
	return AMPERSEND;
}
{AND} {
	return AND;
}
{BITOR} {
	return BITOR;
}
{OR} {
	return OR;
}
{DIV} {
	return DIV;
}
{ATTR} {
	return ATTR;
}
{ATTRADD} {
	return ATTRADD;
}
{ATTRSUB} {
	return ATTRSUB;
}
{ATTRMUL} {
	return ATTRMUL;
}
{ATTRDIV} {
	return ATTRDIV;
}
{ATTRSHIFTL} {
	return ATTRSHIFTL;
}
{ATTRSHIFTR} {
	return ATTRSHIFTR;
}
{ATTRBITOR} {
	return ATTRBITOR;
}
{ATTROR} {
	return ATTROR;
}
{ATTRAMPERSEND} {
	return ATTRAMPERSEND;
}
{ATTRAND} {
	return ATTRAND;
}
{EQQ} {
	return EQQ;
}
{NEQ} {
	return NEQ;
}
{LEQ} {
	return LEQ;
}
{GEQ} {
	return GEQ;
}
{NEG} {
	return NEG;
}
{LT} {
	return LT;
}
{GT} {
	return GT;
}
{SHIFTL} {
	return SHIFTL;
}
{SHIFTR} {
	return SHIFTR;
}
{ESTRUTURA} {
	return ESTRUTURA;
}
{ENUM} {
	return ENUM;
}
{ID} {
	stringToken(yytext); return ID;
}
. {
	error();
}
%%