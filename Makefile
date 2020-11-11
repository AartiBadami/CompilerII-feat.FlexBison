CC = gcc
CFLAGS = -g

OBJs = parse.tab.o lex.yy.o

default: gates

gates: ${OBJs}
	${CC} ${CFLAGS} ${OBJs} -o gates

lex.yy.c: scan.l parse.tab.h attr.h
	flex -i scan.l

parse.tab.c: parse.y attr.h
	bison -dv parse.y

parse.tab.h: parse.tab.c

clean:
	rm -f gates lex.yy.c *.o parse.tab.[ch] parse.output

depend:
	makedepend -I. *.c

