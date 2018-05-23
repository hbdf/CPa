%{

/*
 * CPa lexer
 */

#include <math.h>
#include <string>

#include "parser.tab.h"

using namespace std;
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
	yylval.str = string(yytext);
	return STRING;
}
{CARACTERE} {
	yylval.str = string(yytext);
	return CARACTERE;
}
{INTEIRO} {
	yylval.str = string(yytext);
	return INTEIRO;
}
{REAL} {
	yylval.str = string(yytext);
	return REAL;
}
{REALD} {
	yylval.str = string(yytext);
	return REALD;
}
{STAR} {
	yylval.str = "STAR";
	return STAR;
}
{TIPO_INT} {
	yylval.str = "int";
	return TIPO_PRIMITIVO;
}
{TIPO_REAL} {
	yylval.str = "float";
	return TIPO_PRIMITIVO;
}
{TIPO_DUPLO} {
	yylval.str = "double";
	return TIPO_PRIMITIVO;
}
{TIPO_CHAR} {
	yylval.str = "char";
	return TIPO_PRIMITIVO;
}
{TIPO_VAZIO} {
	yylval.str = "void";
	return TIPO_PRIMITIVO;
}
{TIPO_PRIMITIVO} {
	yylval.str = string(yytext);
	return TIPO_PRIMITIVO;
}
{IMPORTAR} {
	yylval.str = "IMPORTAR";
	return IMPORTAR;
}
{VAR} {
	yylval.str = "VAR";
	return VAR;
}
{CONSTANTE} {
	yylval.str = "CONSTANTE";
	return CONSTANTE;
}
{PARAR} {
	yylval.str = "PARAR";
	return PARAR;
}
{CONTINUAR} {
	yylval.str = "CONTINUAR";
	return CONTINUAR;
}
{RETORNAR} {
	yylval.str = "RETORNAR";
	return RETORNAR;
}
{IRPARA} {
	yylval.str = "IRPARA";
	return IRPARA;
}
{SE} {
	yylval.str = "SE";
	return SE;
}
{CC} {
	yylval.str = "CC";
	return CC;
}
{SENAO} {
	yylval.str = "SENAO";
	return SENAO;
}
{ESCOLHA} {
	yylval.str = "ESCOLHA";
	return ESCOLHA;
}
{CASO} {
	yylval.str = "CASO";
	return CASO;
}
{PARA} {
	yylval.str = "PARA";
	return PARA;
}
{DE} {
	yylval.str = "DE";
	return DE;
}
{ASC} {
	yylval.str = "ASC";
	return ASC;
}
{DESC} {
	yylval.str = "DESC";
	return DESC;
}
{ENQUANTO} {
	yylval.str = "ENQUANTO";
	return ENQUANTO;
}
{FAZER} {
	yylval.str = "FAZER";
	return FAZER;
}
{SEMI} {
	yylval.str = "SEMI";
	return SEMI;
}
{COLON} {
	yylval.str = "COLON";
	return COLON;
}
{DOT} {
	yylval.str = "DOT";
	return DOT;
}
{COMMA} {
	yylval.str = "COMMA";
	return COMMA;
}
{LPAREN} {
	yylval.str = "LPAREN";
	return LPAREN;
}
{RPAREN} {
	yylval.str = "RPAREN";
	return RPAREN;
}
{LBRACKET} {
	yylval.str = "LBRACKET";
	return LBRACKET;
}
{RBRACKET} {
	yylval.str = "RBRACKET";
	return RBRACKET;
}
{LBRACE} {
	yylval.str = "LBRACE";
	return LBRACE;
}
{RBRACE} {
	yylval.str = "RBRACE";
	return RBRACE;
}
{QUESTION} {
	yylval.str = "QUESTION";
	return QUESTION;
}
{PLUS2} {
	yylval.str = "PLUS2";
	return PLUS2;
}
{PLUS} {
	yylval.str = "PLUS";
	return PLUS;
}
{MINUS2} {
	yylval.str = "MINUS2";
	return MINUS2;
}
{MINUS} {
	yylval.str = "MINUS";
	return MINUS;
}
{AMPERSEND} {
	yylval.str = "AMPERSEND";
	return AMPERSEND;
}
{AND} {
	yylval.str = "AND";
	return AND;
}
{PIPE} {
	yylval.str = "PIPE";
	return PIPE;
}
{OR} {
	yylval.str = "OR";
	return OR;
}
{DIV} {
	yylval.str = "DIV";
	return DIV;
}
{MOD} {
	yylval.str = "MOD";
	return MOD;
}
{ATTR} {
	yylval.str = "ATTR";
	return ATTR;
}
{ATTRADD} {
	yylval.str = "ATTRADD";
	return ATTRADD;
}
{ATTRSUB} {
	yylval.str = "ATTRSUB";
	return ATTRSUB;
}
{ATTRMUL} {
	yylval.str = "ATTRMUL";
	return ATTRMUL;
}
{ATTRDIV} {
	yylval.str = "ATTRDIV";
	return ATTRDIV;
}
{ATTRMOD} {
	yylval.str = "ATTRMOD";
	return ATTRMOD;
}
{ATTRSHIFTL} {
	yylval.str = "ATTRSHIFTL";
	return ATTRSHIFTL;
}
{ATTRSHIFTR} {
	yylval.str = "ATTRSHIFTR";
	return ATTRSHIFTR;
}
{ATTRBITOR} {
	yylval.str = "ATTRBITOR";
	return ATTRBITOR;
}
{ATTROR} {
	yylval.str = "ATTROR";
	return ATTROR;
}
{ATTRBITAND} {
	yylval.str = "ATTRBITAND";
	return ATTRBITAND;
}
{ATTRAND} {
	yylval.str = "ATTRAND";
	return ATTRAND;
}
{EQQ} {
	yylval.str = "EQQ";
	return EQQ;
}
{NEQ} {
	yylval.str = "NEQ";
	return NEQ;
}
{LEQ} {
	yylval.str = "LEQ";
	return LEQ;
}
{GEQ} {
	yylval.str = "GEQ";
	return GEQ;
}
{NEG} {
	yylval.str = "NEG";
	return NEG;
}
{LT} {
	yylval.str = "LT";
	return LT;
}
{GT} {
	yylval.str = "GT";
	return GT;
}
{SHIFTL} {
	yylval.str = "SHIFTL";
	return SHIFTL;
}
{SHIFTR} {
	yylval.str = "SHIFTR";
	return SHIFTR;
}
{ESTRUTURA} {
	yylval.str = "ESTRUTURA";
	return ESTRUTURA;
}
{ENUM} {
	yylval.str = "ENUM";
	return ENUM;
}
{LABEL} {
	yylval.str = string(yytext);
	return LABEL;
}
{ID} {
	yylval.str = string(yytext);
	return ID;
}
. {
	error();
}
%%