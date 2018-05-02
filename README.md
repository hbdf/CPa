# CPa

<p align="middle">
	<img src="/imgs/logo.png" width="200">	
</p>

CPa é uma linguagem de programação fortemente inspirada em C. Além disso,
ela incorpora alguns elementos da linguagem Pascal.

Esse projeto está sendo desenvolvido como uma atividade da disciplina de 
Compiladores, ofertada para o curso de Ciência da Computação pela Universidade
Federal do Rio Grande do Norte.

## Como testar

1) Instale o LEX: http://dinosaur.compilertools.net/;
2)_ Instale o Bison: http://ftp.gnu.org/gnu/bison/;
3) Instale o git;
4) Clone o repositório com o comando:
```
git clone https://github.com/hbdf/CPa.git
```
5) Use um desses três comandos para testar cada parser:
```
cd CPa/src/parser/table
cd CPa/src/parser/recursive
cd CPa/src/parser/yacc
```
O parser "table" é o parser top-down utilizando a tabela LL1. O parser "recursive" é o parser top-down implementado com funções recursivas. O parser "yacc" é o parser bottom-up LALR implementado com o YACC.
6) Para testar o parser em um arquivo, use o comando:
```
make
./cpa < ../../../samples/ARQUIVO.cpa
```
onde ARQUIVO é o nome de um dos exemplos dentro da pasta "samples". Isso devolverá um erro caso haja um ou uma confirmação de sucesso.
7) Para testar interativamente, apenas digite:
```
make
./cpa
```
e insira a string de entrada pelo terminal.

## Referências

* Contagem de linhas retirada de: ftp://ftp.gnu.org/old-gnu/Manuals/flex-2.5.4/html_mono/flex.html
* Regex dos comentários de blocos retirada de: https://stackoverflow.com/questions/13569827/
complete-comments-regex-for-lex
* Regex de strings e caracters retiradas de: https://stackoverflow.com/questions/2039795/regular-
expression-for-a-literal-in-flex-lex
* Código da stack retirado de: https://www.geeksforgeeks.org/stack-data-structure-introduction-program/
