#include <stdio.h>
#ifndef principal
#define principal main
#define leia scanf
#define escreva printf
#endif
int principal(){
int x, y;
char op;
escreva("Escolha a operação (+, -, *, /):\n");
leia("%c",  &op);
escreva("Escolha os dois operandos:\n");
leia("%d",  &x);
leia("%d",  &y);
switch (op) {
case '+':
escreva("%i\n", x + y);
break;

case '-':
escreva("%i\n", x - y);
break;

case '*':
escreva("%i\n", x * y);
break;

case '/':
escreva("%i\n", x / y);
break;

default:
escreva("Operação inválida\n");

}

}

