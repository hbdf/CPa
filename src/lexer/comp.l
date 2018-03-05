%{
/*
 * CPa lexer
 */
%}

DIGIT			[0-9]
LETTER			[a-zA-Z]
ID				LETTER+(LETTER|DIGIT|\_ )*
									/*Ignore whitespaces*/;
LINECOMMENT		\// ([^\n ])*\n						/*Ignore line comments*/;
BLOCKCOMMENT	\/ \∗ ([^∗] | \∗ + [^∗/ ])* \∗ + \/		/*Ignore block comments*/;
%%

[\t \n ]+	

{DIGIT}+	{
				printf("DIGIT(%d)", atoi(yytext));
			}

%%

int main() {
	yylex();
}