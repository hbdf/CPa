PROGRAM       = cpa
 
OBJS          = parser.o ../lex.yy.o
 
SRCS          = parser.c ../lex.yy.c

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