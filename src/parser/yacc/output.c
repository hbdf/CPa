int principal (){
int x , y ;
char op ;
leia LPAREN "%i" COMMA AMPERSEND x RPAREN ;
leia LPAREN "%c" COMMA AMPERSEND op RPAREN ;
leia LPAREN "%i" COMMA AMPERSEND y RPAREN ;
ESCOLHA LPAREN op RPAREN LBRACE
CASO '+' COLON
escreva LPAREN "%i\n" COMMA x PLUS y RPAREN ;
PARAR SEMI
CASO '-' COLON
escreva LPAREN "%i\n" COMMA x MINUS y RPAREN ;
PARAR SEMI
CASO '*' COLON
escreva LPAREN "%i\n" COMMA x STAR y RPAREN ;
PARAR SEMI
CASO '/' COLON
escreva LPAREN "%i\n" COMMA x DIV y RPAREN ;
PARAR SEMI
CC COLON
escreva LPAREN "Operação inválida\n" RPAREN ;
RBRACE
}
Entrada lida com sucesso.
