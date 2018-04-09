PROGRAM       = cpa
 
OBJS          = expr.o dec.o parser.o stmt.o ../lex.yy.o
 
SRCS          = expr.c dec.c parser.c stmt.c ../lex.yy.c

CC            = gcc 
 
all:            lex $(PROGRAM)
 
*.c.o:			$(SRCS)
				$(CC) -c $*.c -o $@ -O

lex:			../lex.l
				flex --outfile=../lex.yy.c ../lex.l
 
cpa:			$(OBJS)
				$(CC) $(OBJS)  -o $@ -lfl -lm
 
clean:;			rm -f $(OBJS) core *~ \#* *.o $(PROGRAM) \
				y.* lex.yy.* parser.tab.*