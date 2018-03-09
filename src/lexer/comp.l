%{
/*
 * CPa lexer
 */
%}

%{
	int line = 1;
	int columm = 1;

	void printToken(const char* tokenName){
		printf("(%s, %d, %d) ", tokenName, line, columm);
	}

	void printTokenLexem(const char* tokenName, const char* lexem){
		printf("(%s, %s, %d, %d) ", tokenName, lexem, line, columm);
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
	printTokenLexem("STRING", yytext);
}
{CHAR} {
	printTokenLexem("CHAR", yytext);
}
{INTEIRO} {
	printTokenLexem("INTEIRO", yytext);
}
{REAL} {
	printTokenLexem("REAL", yytext);
}
{REALD} {
	printTokenLexem("REALD", yytext);
}
{STAR} {
	printToken("STAR");
}
{TIPO_PRIMITIVO} {
	printTokenLexem("TIPO", yytext);
}
{IMPORTAR} {
	printToken("IMPORTAR");
}
{CONSTANTE} {
	printToken("CONSTANTE");
}
{PARAR} {
	printToken("PARAR");
}
{CONTINUAR} {
	printToken("CONTINUAR");
}
{RETORNAR} {
	printToken("RETORNAR");
}
{IRPARA} {
	printToken("IRPARA");
}
{SE} {
	printToken("SE");
}
{CC} {
	printToken("CC");
}
{ESCOLHA} {
	printToken("ESCOLHA");
}
{CASO} {
	printToken("CASO");
}
{PARA} {
	printToken("PARA");
}
{DE} {
	printToken("DE");
}
{ASC} {
	printToken("ASC");
}
{DESC} {
	printToken("DESC");
}
{FAZER} {
	printToken("FAZER");
}
{SEMI} {
	printToken("SEMI");
}
{COLON} {
	printToken("COLON");
}
{DOT} {
	printToken("DOT");
}
{COMMA} {
	printToken("COMMA");
}
{LPAREN} {
	printToken("LPAREN");
}
{RPAREN} {
	printToken("RPAREN");
}
{LBRACKET} {
	printToken("LBRACKET");
}
{RBRACKET} {
	printToken("RBRACKET");
}
{LBRACE} {
	printToken("LBRACE");
}
{RBRACE} {
	printToken("RBRACE");
}
{QUESTION} {
	printToken("QUESTION");
}
{PLUS2} {
	printToken("PLUS2");
}
{PLUS} {
	printToken("PLUS");
}
{MINUS2} {
	printToken("MINUS2");
}
{MINUS} {
	printToken("MINUS");
}
{AMPERSEND} {
	printToken("AMPERSEND");
}
{AND} {
	printToken("AND");
}
{BITOR} {
	printToken("BITOR");
}
{OR} {
	printToken("OR");
}
{DIV} {
	printToken("DIV");
}
{ATTR} {
	printToken("ATTR");
}
{ATTRADD} {
	printToken("ATTRADD");
}
{ATTRSUB} {
	printToken("ATTRSUB");
}
{ATTRMUL} {
	printToken("ATTRMUL");
}
{ATTRDIV} {
	printToken("ATTRDIV");
}
{ATTRSHIFTL} {
	printToken("ATTRSHIFTL");
}
{ATTRSHIFTR} {
	printToken("ATTRSHIFTR");
}
{ATTRBITOR} {
	printToken("ATTRBITOR");
}
{ATTROR} {
	printToken("ATTROR");
}
{ATTRAMPERSEND} {
	printToken("ATTRAMPERSEND");
}
{ATTRAND} {
	printToken("ATTRAND");
}
{EQQ} {
	printToken("EQQ");
}
{NEQ} {
	printToken("NEQ");
}
{LEQ} {
	printToken("LEQ");
}
{GEQ} {
	printToken("GEQ");
}
{NEG} {
	printToken("NEG");
}
{LT} {
	printToken("LT");
}
{GT} {
	printToken("GT");
}
{SHIFTL} {
	printToken("SHIFTL");
}
{SHIFTR} {
	printToken("SHIFTR");
}
{ESTRUTURA} {
	printToken("ESTRUTURA");
}
{ENUM} {
	printToken("ENUM");
}
{ID} {
	printTokenLexem("ID", yytext);
}
. {
	error();
}
%%

int main() {
	yylex();
	printf("\n");
}