#include <stdio.h>
#ifndef principal
#define principal main
#define leia scanf
#define escreva printf
#endif
struct pessoa {
char* nome;
int teste;
}; typedef struct pessoa pessoa;

enum bool{
true, false
}; typedef enum bool bool;

#include <stdio.h>
#ifndef principal
#define principal main
#define leia scanf
#define escreva printf
#endif
const int constante = 30;
int var_global1;
int var_global2 = 10, var_global3;
int ler_numero(){
int x;
leia("%d",  &x);
return x;

}

int principal(){
int a = 10;
int b;
float c = 5.0f;
double d = 10;
bool funciona = true;
if (!(a == 10)) goto elselabel0;
{
int e = 0;
startlabel1:
if (!(e < 20)) goto endlabel1;
e += 2;
goto startlabel1;
endlabel1:;

startlabel2:
{

}

if (true == false) goto startlabel2;
goto startlabel2;

escreva("%d\n", e);

}

goto endiflabel0;
elselabel0:;
if (!(funciona == true)) goto elselabel3;
{
{
int cont = 10;
label4:
if (!(cont < 20)) goto endlabel4;
{
escreva("teste %d\n", cont);

}
cont++;
goto label4;
endlabel4:;

}

{
int cont = 10;
label5:
if (!(cont < 20)) goto endlabel5;
{
escreva("teste\n");
{
int cont = 20;
label6:
if (!(cont > 0)) goto endlabel6;
escreva("teste\n");cont--;
goto label6;
endlabel6:;

}


}
cont++;
goto label5;
endlabel5:;

}


}

goto endiflabel3;
elselabel3:;
if (!(ler_numero() > 0 ? funciona == false : ler_numero())) goto elselabel7;
{
return 42;

}

goto endiflabel7;
elselabel7:;
{
escreva("bla\n");

}

endiflabel7:;

endiflabel3:;

endiflabel0:;

switch (a) {
case 1:
break;

case 10:
leia("%d",  &a);

case 4:

default:
escreva("eh nois");

}
char* texto = "Texto" == "texto" ? "Sim" : "Nao";
char t = texto[1];
int i = c == '1' ? 1 : c == '2' ? 2 : 3;
int j = c != '1' ? c == '2' ? 2 : 3 : 1;
int bla = constante * a == 1 || (35 == 3 && 10 < 15 && (15 >= 20 || 10 == 10));

}

int fun(){
int x = 10, k = 10;
int* b =  &x;
int arr[4] = {1, 2, 3, 4};
int* bla =  &x + *b + k++ ;
int* ble =  &x +  ++*b +  --k;
int y, a, c, d, e, f;
int boolean = 1;
y %= 3;
a += 1;
b -= 1;
c = 1 % 0;
d /= 0;
f *= 3;
e &= 19;
e = e && boolean || boolean;
e |= boolean || boolean;
e = e || boolean || boolean;
1 << 30 << (x++ ) >> 10;
c =  ! (a > 40 && 1 * 3 <= 10 / 0);
x >>= 10;
x <<= 10;
x + 1;
pessoa arrp[10];
pessoa p;
p.teste += 2 + arrp[2].teste;
a++  + k + p.nome &&  &f;

}

pessoa func_2(float faca, int afiar, bool __R33, char* s){
amolador:
faca = afiar + 2;
goto bla;
goto amolador;
bla:
return;

}

