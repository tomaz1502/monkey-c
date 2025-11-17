.PHONY: clean

main: parser.tab.o lex.yy.o main.c
	gcc main.c -o parser parser.tab.o lex.yy.o

parser.tab.o: parser.tab.h parser.tab.c
	gcc -c parser.tab.c

lex.yy.o: lex.yy.c parser.tab.o
	gcc -c lex.yy.c

lex.yy.c: lex.l
	flex lex.l

parser.tab.h parser.tab.c: parser.y
	bison parser.y -d

clean:
	rm -f lex.yy.c lex.yy.o parser.tab.c parser.tab.o parser.tab.h parser
