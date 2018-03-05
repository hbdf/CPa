%{
/*
 * CPa lexer
 */
%}

DIGIT			[0-9]
LETTER			[a-zA-Z]
ID				LETTER+(LETTER|DIGIT|\_ )*

WHITESPACE 		[\t ]+									/*Ignore whitespaces*/;
LINECOMMENT		\/([^\n ])*\n							/*Ignore line comments*/;
BLOCKCOMMENT	\/ \∗ ([^∗] | \∗ + [^∗/ ])* \∗ + \/		/*Ignore block comments*/;
%%

{DIGIT}+	{
				printf("%s (%d)", yytext, atoi(yytext));
			}

%%