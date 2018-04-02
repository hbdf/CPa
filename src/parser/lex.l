%{

/*
 * CPa lexer
 */

#include "token.h"
#include <math.h>
#define YYSTYPE char*
int line = 1;
int column = 1;
char* lexem;

void error() {
	printf("[ERRO] - linha: %d, coluna: %d ", line, column);
	column += yyleng;
}

enum token getToken(void) {
	return yylex();
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
PIPE 			"|"
OR 				"||"
DIV 			"/"
MOD				"%"
ATTRADD 		"+="
ATTRSUB 		"-="
ATTRMUL 		"*="
ATTRDIV 		"/="
ATTRMOD 		"%="
ATTRSHIFTL 		">>="
ATTRSHIFTR 		"<<="
ATTRBITOR 		"|="
ATTROR 			"||="
ATTRBITAND	 	"&="
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
ENQUANTO		enquanto
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
	column += yyleng;
	lexem = yytext;
}
[\n ]	{
	column = 1;
	line++;
}
{BLOCKCOMMENT} {}
{LINECOMMENT} {}
{STRING} {
	return STRING;
}
{CHAR} {
	return CHAR;
}
{INTEIRO} {
	return INTEIRO;
}
{REAL} {
	return REAL;
}
{REALD} {
	return REALD;
}
{STAR} {
	return STAR;
}
{TIPO_PRIMITIVO} {
	return TIPO_PRIMITIVO;
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
{ENQUANTO} {
	return ENQUANTO;
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
{PIPE} {
	return PIPE;
}
{OR} {
	return OR;
}
{DIV} {
	return DIV;
}
{MOD} {
	return MOD;
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
{ATTRMOD} {
	return ATTRMOD;
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
{ATTRBITAND} {
	return ATTRBITAND;
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
	return ID;
}
. {
	error();
}
%%