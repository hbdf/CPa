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
2) Instale o git;
3) Clone o repositório com o comando:
```
git clone https://github.com/hbdf/CPa.git
```
4) Por fim, use o comando:
```
cd CPa/src/lexer
make comp file=arquivo.cpa
```
onde "arquivo.cpa" é o nome de um dos arquivos de exemplo dentro da pasta "samples". Isso deverá imprimir os tokens dentro do arquivo dado.

## Referências

* Contagem de linhas retirada de: ftp://ftp.gnu.org/old-gnu/Manuals/flex-2.5.4/html_mono/flex.html
* Regex dos comentários de blocos retirada de: https://stackoverflow.com/questions/13569827/
complete-comments-regex-for-lex
* Regex de strings e caracters retiradas de: https://stackoverflow.com/questions/2039795/regular-
expression-for-a-literal-in-flex-lex
