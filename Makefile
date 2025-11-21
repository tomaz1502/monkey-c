.PHONY: clean

main: parser.tab.o lex.yy.o main.c
	g++ main.c -o parser parser.tab.o lex.yy.o expr.o

parser.tab.o: parser.tab.h parser.tab.c expr.h
	g++ -c parser.tab.c

expr.o: expr.h expr.cpp
	g++ -c expr.cpp

lex.yy.o: lex.yy.c parser.tab.o
	g++ -c lex.yy.c

lex.yy.c: lex.l
	flex lex.l

parser.tab.h parser.tab.c: parser.y
	bison parser.y -d

clean:
	rm -f lex.yy.c lex.yy.o parser.tab.c parser.tab.o parser.tab.h parser
