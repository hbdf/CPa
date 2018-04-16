#ifndef __PARSER__
#define __PARSER__

#include "../token.h"

void exit(int c);

extern int line;
extern int column;
extern char* lexem;

extern enum token getToken(void);
extern enum token tok;

#endif
