%{
/*
 * CPa lexer
 */
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
TIPO_PRIMITIVO  int|real|duplo|caractere
/* Palavras Reservadas OK */
IMPORTAR 		importar
CONSTANTE 		const
PARAR 			parar
CONTINUAR 		continuar
RETORNAR 		retornar
IRPARA 			irpara
SE 				se
CC 				cc
ESCOLHA 		escolha
CASO 			caso
PARA 			para
DE 				de
ASC 			asc
DESC 			desc
FAZER 			fazer
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

[\t \n ]+			/* Ignorar caracteres de espaçamento */
{BLOCKCOMMENT} {}
{LINECOMMENT} {}
{STRING} {
	printf("STRING(%s) ", yytext);
}
{CHAR} {
	printf("CHAR(%s) ", yytext);
}
{INTEIRO} {
	printf("INTEIRO(%s) ", yytext);
}
{REAL} {
	printf("REAL(%s) ", yytext);
}
{REALD} {
	printf("REALD(%s) ", yytext);
}
{STAR} {
	printf("STAR ");
}
{TIPO_PRIMITIVO} {
	printf("TIPO(%s) ", yytext);
}
{IMPORTAR} {
	printf("IMPORTAR ");
}
{CONSTANTE} {
	printf("CONSTANTE ");
}
{PARAR} {
	printf("PARAR ");
}
{CONTINUAR} {
	printf("CONTINUAR ");
}
{RETORNAR} {
	printf("RETORNAR ");
}
{IRPARA} {
	printf("IRPARA ");
}
{SE} {
	printf("SE ");
}
{CC} {
	printf("CC ");
}
{ESCOLHA} {
	printf("ESCOLHA ");
}
{CASO} {
	printf("CASO ");
}
{PARA} {
	printf("PARA ");
}
{DE} {
	printf("DE ");
}
{ASC} {
	printf("ASC ");
}
{DESC} {
	printf("DESC ");
}
{FAZER} {
	printf("FAZER ");
}
{SEMI} {
	printf("SEMI ");
}
{COLON} {
	printf("COLON ");
}
{DOT} {
	printf("DOT ");
}
{COMMA} {
	printf("COMMA ");
}
{LPAREN} {
	printf("LPAREN ");
}
{RPAREN} {
	printf("RPAREN ");
}
{LBRACKET} {
	printf("LBRACKET ");
}
{RBRACKET} {
	printf("RBRACKET ");
}
{LBRACE} {
	printf("LBRACE ");
}
{RBRACE} {
	printf("RBRACE ");
}
{QUESTION} {
	printf("QUESTION ");
}
{PLUS2} {
	printf("PLUS2 ");
}
{PLUS} {
	printf("PLUS ");
}
{MINUS2} {
	printf("MINUS2 ");
}
{MINUS} {
	printf("MINUS ");
}
{AMPERSEND} {
	printf("AMPERSEND ");
}
{AND} {
	printf("AND ");
}
{BITOR} {
	printf("BITOR ");
}
{OR} {
	printf("OR ");
}
{DIV} {
	printf("DIV ");
}
{ATTR} {
	printf("ATTR ");
}
{ATTRADD} {
	printf("ATTRADD ");
}
{ATTRSUB} {
	printf("ATTRSUB ");
}
{ATTRMUL} {
	printf("ATTRMUL ");
}
{ATTRDIV} {
	printf("ATTRDIV ");
}
{ATTRSHIFTL} {
	printf("ATTRSHIFTL ");
}
{ATTRSHIFTR} {
	printf("ATTRSHIFTR ");
}
{ATTRBITOR} {
	printf("ATTRBITOR ");
}
{ATTROR} {
	printf("ATTROR ");
}
{ATTRAMPERSEND} {
	printf("ATTRAMPERSEND ");
}
{ATTRAND} {
	printf("ATTRAND ");
}
{EQQ} {
	printf("EQQ ");
}
{NEQ} {
	printf("NEQ ");
}
{LEQ} {
	printf("LEQ ");
}
{GEQ} {
	printf("GEQ ");
}
{NEG} {
	printf("NEG ");
}
{LT} {
	printf("LT ");
}
{GT} {
	printf("GT ");
}
{SHIFTL} {
	printf("SHIFTL ");
}
{SHIFTR} {
	printf("SHIFTR ");
}
{ID} {
	printf("ID(%s) ", yytext);
}
%%

int main() {
	yylex();
}