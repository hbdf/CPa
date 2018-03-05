%{
/*
 * CPa lexer
 */
%}

/* Caracteres especiais OK */
STAR			[\*]
PLUS2 			[++]
PLUS 			[+]
MINUS2 			[−−]
MINUS 			[−]
AMPERSEND 		[&]
AMPERSEND2 		[&&]
BITOR 			[|]
OR 				[||]
DIV 			[/]
ATTR 			[=]
ATTRADD 		[+=]
ATTRSUB 		[−=]
ATTRMUL 		[∗=]
ATTRDIV 		[/=]
ATTRSHIFTL 		[>>=]
ATTRSHIFTR 		[<<=]
ATTRBITOR 		[|=]
ATTROR 			[||=]
ATTRAMPERSEND 	[&=]
ATTRAMPERSEND2 	[&&=]
EQQ 			[==]
NEQ 			[!=]
LEQ 			[<=]
GEQ 			[<=]
NEG 			[!]
LT 				[<]
GT 				[>]
SHIFTL 			[<<]
SHIFTR 			[>>]
/* Pontuação OK */
SEMI 			[;]
COLON 			[:]
DOT 			[.]
COMMA 			[,]
LPAREN 			[(]
RPAREN 			[)]
LBRACKET 		[[]
RBRACKET 		[]]
LBRACE 			[{]
RBRACE 			[}]
QUESTION 		[?]
/* Tipos Primitivos OK */
TIPO_PRIMITIVO  int|real|duplo|caractere
/* Palavras Reservadas OK */
IMPORTAR 		importar
CONSTANTE 		constante
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
BLOCKCOMMENT	\/ \∗ ([^∗] | \∗ + [^∗/ ])* \∗ + \/		/*Ignore block comments*/;
ID				(_*{LETTER}|{LETTER})({LETTER}|{DIGIT}|_)*
DIGIT			[0-9]
LETTER			[a-zA-Z]
%%

[\t \n ]+			/* Ignorar caracteres de espaçamento */
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
{STAR} {
	printf("STAR ");
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
{AMPERSEND2} {
	printf("AMPERSEND2 ");
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
{ATTRAMPERSEND2} {
	printf("ATTRAMPERSEND2 ");
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
{DIGIT}+ {
	printf("NUM(%d) ", atoi(yytext));
}
%%

int main() {
	yylex();
}