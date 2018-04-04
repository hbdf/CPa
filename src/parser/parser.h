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
void attr(void);
void ternary(void);
void logor_chain(void);
void attr_tail(void);
void logand_chain(void);
void logor_tail(void);
void bitor_chain(void);
void logand_tail(void);
void bitand_chain(void);
void bitor_tail(void);
void rel(void);
void bitand_tail(void);
void shift_chain(void);
void rel_tail(void);
void add_chain(void);
void shift_tail(void);
void mul_chain(void);
void add_tail(void);
void un_chain(void);
void mul_tail(void);
void un_op(void);
void expr_leaf(void);
void pre_op(void);
void var_call(void);
void expr_lit(void);
void var(void);
void call(void);
void var_mods(void);
void args(void);
void pos_op(void);
void args1(void);
void args0(void);
void array_lit(void);
void mul_op(void);
void add_op(void);

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
void syntax_error(char* err);
void start(void);

#endif
