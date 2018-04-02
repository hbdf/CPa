YFLAGS        = -d
 
PROGRAM       = cpa
 
OBJS          = parser.tab.o lex.yy.o
 
SRCS          = parser.tab.c lex.yy.c
 
CC            = gcc 
 
all:            $(PROGRAM)
 
.c.o:			$(SRCS)
				$(CC) -c $*.c -o $@ -O
 
parser.tab.c:	parser.y
				bison $(YFLAGS) parser.y
 
lex.yy.c:		lex.l
				flex lex.l
 
cpa:			$(OBJS)
				$(CC) $(OBJS)  -o $@ -lfl -lm
 
clean:;			rm -f $(OBJS) core *~ \#* *.o $(PROGRAM) \
				y.* lex.yy.* parser.tab.*