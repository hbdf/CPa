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
void start(void);
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
void var_decs(void);
void type(void);
void array_type(void);
void basic_type(void);

// Expr
void expr(void);

// Stmt
void block(void);
void stmts(void);
void stmt(void);
void if_stmt(void);
void else_stmt(void);
void while_stmt(void);
void do_while(void);
void for_stmt(void);
void for_expr(void);
void switch_case(void);
void case1(void);
void case0(void);
void case_stmt(void);
void return_stmt(void);

void advance();
void eat(enum token t);
void syntax_error();
void start(void);

#endif
