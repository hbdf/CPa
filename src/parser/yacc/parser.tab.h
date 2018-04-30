/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IMPORTAR = 258,
    STRING = 259,
    SEMI = 260,
    CONSTANTE = 261,
    ID = 262,
    LPAREN = 263,
    RPAREN = 264,
    COMMA = 265,
    ATTR = 266,
    ESTRUTURA = 267,
    LBRACE = 268,
    RBRACE = 269,
    ENUM = 270,
    TIPO_PRIMITIVO = 271,
    STAR = 272,
    LBRACKET = 273,
    RBRACKET = 274,
    VAR = 275,
    PARAR = 276,
    CONTINUAR = 277,
    IRPARA = 278,
    LABEL = 279,
    RETORNAR = 280,
    SE = 281,
    SENAO = 282,
    ENQUANTO = 283,
    FAZER = 284,
    PARA = 285,
    DE = 286,
    ASC = 287,
    DESC = 288,
    ESCOLHA = 289,
    CASO = 290,
    COLON = 291,
    CC = 292,
    QUESTION = 293,
    INTEIRO = 294,
    REAL = 295,
    REALD = 296,
    CARACTERE = 297,
    DOT = 298,
    ATTRADD = 299,
    ATTRSUB = 300,
    ATTRMUL = 301,
    ATTRDIV = 302,
    ATTRMOD = 303,
    ATTRBITOR = 304,
    ATTROR = 305,
    ATTRBITAND = 306,
    ATTRAND = 307,
    ATTRSHIFTL = 308,
    ATTRSHIFTR = 309,
    AMPERSEND = 310,
    PLUS2 = 311,
    MINUS2 = 312,
    DIV = 313,
    MOD = 314,
    NEG = 315,
    MINUS = 316,
    PLUS = 317,
    SHIFTL = 318,
    SHIFTR = 319,
    EQQ = 320,
    NEQ = 321,
    GT = 322,
    LT = 323,
    GEQ = 324,
    LEQ = 325,
    PIPE = 326,
    AND = 327,
    OR = 328
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
