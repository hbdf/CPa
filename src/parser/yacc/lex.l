%{

/*
 * CPa lexer
 */

#include "parser.tab.h"
#include <math.h>
#define YYSTYPE char*
int line = 1;
int column = 1;

int yylex(void);

void error() {
	printf("[ERRO LEXICO] linha: %d, coluna: %d.", line, column);
	column += yyleng;
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
VAR				var
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
CARACTERE		\'([^'\\]|(\\).)\'
STRING			\"([^"\\]|(\\).)*\"
LABEL			{ID}:
%%

[\t ]+ {
	column += yyleng;
}
[\n ]	{
	column = 1;
	line++;
}
{BLOCKCOMMENT} {}
{LINECOMMENT} {}
{STRING} {
	yylval = strdup("STRING");
	return STRING;
}
{CARACTERE} {
	yylval = strdup("CARACTERE");
	return CARACTERE;
}
{INTEIRO} {
	yylval = strdup("INTEIRO");
	return INTEIRO;
}
{REAL} {
	yylval = strdup("REAL");
	return REAL;
}
{REALD} {
	yylval = strdup("REALD");
	return REALD;
}
{STAR} {
	yylval = strdup("STAR");
	return STAR;
}
{TIPO_PRIMITIVO} {
	yylval = strdup("TIPO_PRIMITIVO");
	return TIPO_PRIMITIVO;
}
{IMPORTAR} {
	yylval = strdup("IMPORTAR");
	return IMPORTAR;
}
{VAR} {
	yylval = strdup("VAR");
	return VAR;
}
{CONSTANTE} {
	yylval = strdup("CONSTANTE");
	return CONSTANTE;
}
{PARAR} {
	yylval = strdup("PARAR");
	return PARAR;
}
{CONTINUAR} {
	yylval = strdup("CONTINUAR");
	return CONTINUAR;
}
{RETORNAR} {
	yylval = strdup("RETORNAR");
	return RETORNAR;
}
{IRPARA} {
	yylval = strdup("IRPARA");
	return IRPARA;
}
{SE} {
	yylval = strdup("SE");
	return SE;
}
{CC} {
	yylval = strdup("CC");
	return CC;
}
{SENAO} {
	yylval = strdup("SENAO");
	return SENAO;
}
{ESCOLHA} {
	yylval = strdup("ESCOLHA");
	return ESCOLHA;
}
{CASO} {
	yylval = strdup("CASO");
	return CASO;
}
{PARA} {
	yylval = strdup("PARA");
	return PARA;
}
{DE} {
	yylval = strdup("DE");
	return DE;
}
{ASC} {
	yylval = strdup("ASC");
	return ASC;
}
{DESC} {
	yylval = strdup("DESC");
	return DESC;
}
{ENQUANTO} {
	yylval = strdup("ENQUANTO");
	return ENQUANTO;
}
{FAZER} {
	yylval = strdup("FAZER");
	return FAZER;
}
{SEMI} {
	yylval = strdup("SEMI");
	return SEMI;
}
{COLON} {
	yylval = strdup("SEMI");
	return COLON;
}
{DOT} {
	yylval = strdup("DOT");
	return DOT;
}
{COMMA} {
	yylval = strdup("COMMA");
	return COMMA;
}
{LPAREN} {
	yylval = strdup("LPAREN");
	return LPAREN;
}
{RPAREN} {
	yylval = strdup("RPAREN");
	return RPAREN;
}
{LBRACKET} {
	yylval = strdup("LBRACKET");
	return LBRACKET;
}
{RBRACKET} {
	yylval = strdup("RBRACKET");
	return RBRACKET;
}
{LBRACE} {
	yylval = strdup("LBRACE");
	return LBRACE;
}
{RBRACE} {
	yylval = strdup("RBRACE");
	return RBRACE;
}
{QUESTION} {
	yylval = strdup("QUESTION");
	return QUESTION;
}
{PLUS2} {
	yylval = strdup("PLUS2");
	return PLUS2;
}
{PLUS} {
	yylval = strdup("PLUS");
	return PLUS;
}
{MINUS2} {
	yylval = strdup("MINUS2");
	return MINUS2;
}
{MINUS} {
	yylval = strdup("MINUS");
	return MINUS;
}
{AMPERSEND} {
	yylval = strdup("AMPERSEND");
	return AMPERSEND;
}
{AND} {
	yylval = strdup("AND");
	return AND;
}
{PIPE} {
	yylval = strdup("PIPE");
	return PIPE;
}
{OR} {
	yylval = strdup("OR");
	return OR;
}
{DIV} {
	yylval = strdup("DIV");
	return DIV;
}
{MOD} {
	yylval = strdup("MOD");
	return MOD;
}
{ATTR} {
	yylval = strdup("ATTR");
	return ATTR;
}
{ATTRADD} {
	yylval = strdup("ATTRADD");
	return ATTRADD;
}
{ATTRSUB} {
	yylval = strdup("ATTRSUB");
	return ATTRSUB;
}
{ATTRMUL} {
	yylval = strdup("ATTRMUL");
	return ATTRMUL;
}
{ATTRDIV} {
	yylval = strdup("ATTRDIV");
	return ATTRDIV;
}
{ATTRMOD} {
	yylval = strdup("ATTRMOD");
	return ATTRMOD;
}
{ATTRSHIFTL} {
	yylval = strdup("ATTRSHIFTL");
	return ATTRSHIFTL;
}
{ATTRSHIFTR} {
	yylval = strdup("ATTRSHIFTR");
	return ATTRSHIFTR;
}
{ATTRBITOR} {
	yylval = strdup("ATTRBITOR");
	return ATTRBITOR;
}
{ATTROR} {
	yylval = strdup("ATTROR");
	return ATTROR;
}
{ATTRBITAND} {
	yylval = strdup("ATTRBITAND");
	return ATTRBITAND;
}
{ATTRAND} {
	yylval = strdup("ATTRAND");
	return ATTRAND;
}
{EQQ} {
	yylval = strdup("EQQ");
	return EQQ;
}
{NEQ} {
	yylval = strdup("NEQ");
	return NEQ;
}
{LEQ} {
	yylval = strdup("LEQ");
	return LEQ;
}
{GEQ} {
	yylval = strdup("GEQ");
	return GEQ;
}
{NEG} {
	yylval = strdup("NEG");
	return NEG;
}
{LT} {
	yylval = strdup("LT");
	return LT;
}
{GT} {
	yylval = strdup("GT");
	return GT;
}
{SHIFTL} {
	yylval = strdup("SHIFTL");
	return SHIFTL;
}
{SHIFTR} {
	yylval = strdup("SHIFTR");
	return SHIFTR;
}
{ESTRUTURA} {
	yylval = strdup("ESTRUTURA");
	return ESTRUTURA;
}
{ENUM} {
	yylval = strdup("ENUM");
	return ENUM;
}
{LABEL} {
	yylval = strdup("LABEL");
	return LABEL;
}
{ID} {
	yylval = strdup("ID");
	return ID;
}
. {
	error();
}
%%