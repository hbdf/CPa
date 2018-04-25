YFLAGS        = -d -v
 
PROGRAM       = cpa
 
OBJS          = parser.tab.o lex.yy.o
 
SRCS          = parser.tab.c lex.yy.c
 
CC            = gcc 
 
all:            parser lex $(PROGRAM)
 
*.c.o:			$(SRCS)
				$(CC) -c $*.c -o $@ -O -lfl

lex:			lex.l
				flex --outfile=lex.yy.c lex.l

parser:			parser.y
				bison $(YFLAGS) parser.y
 
cpa:			$(OBJS)
				$(CC) $(OBJS)  -o $@ -lfl -lm
 
clean:;			rm -f $(OBJS) core *~ \#* *.o $(PROGRAM) \
				y.* lex.yy.* parser.tab.*