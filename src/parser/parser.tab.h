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
    STRING = 258,
    CHAR = 259,
    INTEIRO = 260,
    REAL = 261,
    REALD = 262,
    TIPO_PRIMITIVO = 263,
    ID = 264,
    ENUM = 265,
    ESTRUTURA = 266,
    IMPORTAR = 267,
    CONSTANTE = 268,
    PARAR = 269,
    CONTINUAR = 270,
    RETORNAR = 271,
    IRPARA = 272,
    SE = 273,
    CC = 274,
    SENAO = 275,
    ESCOLHA = 276,
    CASO = 277,
    PARA = 278,
    DE = 279,
    ASC = 280,
    DESC = 281,
    FAZER = 282,
    SEMI = 283,
    COLON = 284,
    DOT = 285,
    COMMA = 286,
    LPAREN = 287,
    RPAREN = 288,
    LBRACKET = 289,
    RBRACKET = 290,
    LBRACE = 291,
    RBRACE = 292,
    QUESTION = 293,
    PLUS2 = 294,
    PLUS = 295,
    MINUS2 = 296,
    MINUS = 297,
    AMPERSEND = 298,
    AND = 299,
    BITOR = 300,
    OR = 301,
    STAR = 302,
    DIV = 303,
    EQQ = 304,
    NEQ = 305,
    LEQ = 306,
    GEQ = 307,
    NEG = 308,
    LT = 309,
    GT = 310,
    SHIFTL = 311,
    SHIFTR = 312,
    ATTR = 313,
    ATTRADD = 314,
    ATTRSUB = 315,
    ATTRMUL = 316,
    ATTRDIV = 317,
    ATTRSHIFTL = 318,
    ATTRSHIFTR = 319,
    ATTRBITOR = 320,
    ATTROR = 321,
    ATTRAMPERSEND = 322,
    ATTRAND = 323
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
