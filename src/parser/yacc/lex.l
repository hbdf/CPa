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
TIPO_INT		int
TIPO_REAL		real
TIPO_DUPLO		reald
TIPO_CHAR		caractere
TIPO_VAZIO		vazio
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
	yylval.str = strdup(yytext);
	return STRING;
}
{CARACTERE} {
	yylval.str = strdup(yytext);
	return CARACTERE;
}
{INTEIRO} {
	yylval.str = strdup(yytext);
	return INTEIRO;
}
{REAL} {
	yylval.str = strdup(yytext);
	return REAL;
}
{REALD} {
	yylval.str = strdup(yytext);
	return REALD;
}
{STAR} {
	yylval.str = strdup("STAR");
	return STAR;
}
{TIPO_INT} {
	yylval.str = strdup("int");
	return TIPO_PRIMITIVO;
}
{TIPO_REAL} {
	yylval.str = strdup("float");
	return TIPO_PRIMITIVO;
}
{TIPO_DUPLO} {
	yylval.str = strdup("double");
	return TIPO_PRIMITIVO;
}
{TIPO_CHAR} {
	yylval.str = strdup("char");
	return TIPO_PRIMITIVO;
}
{TIPO_VAZIO} {
	yylval.str = strdup("void");
	return TIPO_PRIMITIVO;
}
{TIPO_PRIMITIVO} {
	yylval.str = strdup(yytext);
	return TIPO_PRIMITIVO;
}
{IMPORTAR} {
	yylval.str = strdup("IMPORTAR");
	return IMPORTAR;
}
{VAR} {
	yylval.str = strdup("VAR");
	return VAR;
}
{CONSTANTE} {
	yylval.str = strdup("CONSTANTE");
	return CONSTANTE;
}
{PARAR} {
	yylval.str = strdup("PARAR");
	return PARAR;
}
{CONTINUAR} {
	yylval.str = strdup("CONTINUAR");
	return CONTINUAR;
}
{RETORNAR} {
	yylval.str = strdup("RETORNAR");
	return RETORNAR;
}
{IRPARA} {
	yylval.str = strdup("IRPARA");
	return IRPARA;
}
{SE} {
	yylval.str = strdup("SE");
	return SE;
}
{CC} {
	yylval.str = strdup("CC");
	return CC;
}
{SENAO} {
	yylval.str = strdup("SENAO");
	return SENAO;
}
{ESCOLHA} {
	yylval.str = strdup("ESCOLHA");
	return ESCOLHA;
}
{CASO} {
	yylval.str = strdup("CASO");
	return CASO;
}
{PARA} {
	yylval.str = strdup("PARA");
	return PARA;
}
{DE} {
	yylval.str = strdup("DE");
	return DE;
}
{ASC} {
	yylval.str = strdup("ASC");
	return ASC;
}
{DESC} {
	yylval.str = strdup("DESC");
	return DESC;
}
{ENQUANTO} {
	yylval.str = strdup("ENQUANTO");
	return ENQUANTO;
}
{FAZER} {
	yylval.str = strdup("FAZER");
	return FAZER;
}
{SEMI} {
	yylval.str = strdup("SEMI");
	return SEMI;
}
{COLON} {
	yylval.str = strdup("COLON");
	return COLON;
}
{DOT} {
	yylval.str = strdup("DOT");
	return DOT;
}
{COMMA} {
	yylval.str = strdup("COMMA");
	return COMMA;
}
{LPAREN} {
	yylval.str = strdup("LPAREN");
	return LPAREN;
}
{RPAREN} {
	yylval.str = strdup("RPAREN");
	return RPAREN;
}
{LBRACKET} {
	yylval.str = strdup("LBRACKET");
	return LBRACKET;
}
{RBRACKET} {
	yylval.str = strdup("RBRACKET");
	return RBRACKET;
}
{LBRACE} {
	yylval.str = strdup("LBRACE");
	return LBRACE;
}
{RBRACE} {
	yylval.str = strdup("RBRACE");
	return RBRACE;
}
{QUESTION} {
	yylval.str = strdup("QUESTION");
	return QUESTION;
}
{PLUS2} {
	yylval.str = strdup("PLUS2");
	return PLUS2;
}
{PLUS} {
	yylval.str = strdup("PLUS");
	return PLUS;
}
{MINUS2} {
	yylval.str = strdup("MINUS2");
	return MINUS2;
}
{MINUS} {
	yylval.str = strdup("MINUS");
	return MINUS;
}
{AMPERSEND} {
	yylval.str = strdup("AMPERSEND");
	return AMPERSEND;
}
{AND} {
	yylval.str = strdup("AND");
	return AND;
}
{PIPE} {
	yylval.str = strdup("PIPE");
	return PIPE;
}
{OR} {
	yylval.str = strdup("OR");
	return OR;
}
{DIV} {
	yylval.str = strdup("DIV");
	return DIV;
}
{MOD} {
	yylval.str = strdup("MOD");
	return MOD;
}
{ATTR} {
	yylval.str = strdup("ATTR");
	return ATTR;
}
{ATTRADD} {
	yylval.str = strdup("ATTRADD");
	return ATTRADD;
}
{ATTRSUB} {
	yylval.str = strdup("ATTRSUB");
	return ATTRSUB;
}
{ATTRMUL} {
	yylval.str = strdup("ATTRMUL");
	return ATTRMUL;
}
{ATTRDIV} {
	yylval.str = strdup("ATTRDIV");
	return ATTRDIV;
}
{ATTRMOD} {
	yylval.str = strdup("ATTRMOD");
	return ATTRMOD;
}
{ATTRSHIFTL} {
	yylval.str = strdup("ATTRSHIFTL");
	return ATTRSHIFTL;
}
{ATTRSHIFTR} {
	yylval.str = strdup("ATTRSHIFTR");
	return ATTRSHIFTR;
}
{ATTRBITOR} {
	yylval.str = strdup("ATTRBITOR");
	return ATTRBITOR;
}
{ATTROR} {
	yylval.str = strdup("ATTROR");
	return ATTROR;
}
{ATTRBITAND} {
	yylval.str = strdup("ATTRBITAND");
	return ATTRBITAND;
}
{ATTRAND} {
	yylval.str = strdup("ATTRAND");
	return ATTRAND;
}
{EQQ} {
	yylval.str = strdup("EQQ");
	return EQQ;
}
{NEQ} {
	yylval.str = strdup("NEQ");
	return NEQ;
}
{LEQ} {
	yylval.str = strdup("LEQ");
	return LEQ;
}
{GEQ} {
	yylval.str = strdup("GEQ");
	return GEQ;
}
{NEG} {
	yylval.str = strdup("NEG");
	return NEG;
}
{LT} {
	yylval.str = strdup("LT");
	return LT;
}
{GT} {
	yylval.str = strdup("GT");
	return GT;
}
{SHIFTL} {
	yylval.str = strdup("SHIFTL");
	return SHIFTL;
}
{SHIFTR} {
	yylval.str = strdup("SHIFTR");
	return SHIFTR;
}
{ESTRUTURA} {
	yylval.str = strdup("ESTRUTURA");
	return ESTRUTURA;
}
{ENUM} {
	yylval.str = strdup("ENUM");
	return ENUM;
}
{LABEL} {
	yylval.str = strdup(yytext);
	return LABEL;
}
{ID} {
	yylval.str = strdup(yytext);
	return ID;
}
. {
	error();
}
%%