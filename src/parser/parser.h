#ifndef __PARSER__
#define __PARSER__

#include "token.h"

enum token yylex();
void exit(int c);

extern int line;
extern int column;
extern char* lexem;

extern enum token getToken(void);
extern enum token tok;

// Dec
void inc(void);
void dec(void);
void dec0(void);
void dec1(void);
void const_dec(void);
void enum_dec(void);
void struct_dec(void);
void id_dec(void);
void id_suffix(void);
void id_init(void);
void func_dec(void);
void func_end(void);
void params(void);
void params0(void);
void params1(void);
void var_dec(void);
void var_dec1(void);
void type(void);
void array_type(void);
void basic_type(void);

// Expr
void expr(void);

// Stmt
void block(void);

void advance();
void eat(enum token t);
void syntax_error();
void start(void);

#endif
