%{
#include <ctype.h>
#include <stdio.h>
#include <vector>

extern int yylex(void);
extern int yyerror(const char* s);
%}

%code requires {
    #include "expr.h"
}

%union {
    int num;
    char* id;
    Expr expr;
}

%token T_NEWLINE
%token T_LPAR T_RPAR
%token T_LBRACK
%token T_RBRACK
%token T_SEMICOLON
%token T_COMMA
%token T_COLON
%token T_PLUS
%token T_ASSIGN
%token T_MINUS
%token T_BANG
%token T_MULT
%token T_SLASH
%token T_LT
%token T_GT
%token T_EQ
%token T_NEQ
%token T_LET
%token T_FN
%token T_RETURN
%token T_IF
%token T_ELSE
%token T_TRUE
%token T_FALSE
%token T_INT
%token T_BOOL
%token T_UNIT
%token T_ARROW
%token <num> T_NUMBER
%token <id> T_ID

%type <expr> return_stmt
%type <expr> expr
%type <expr> term
%type <expr> factor

%start stmts

%%

stmts :
  | stmt T_SEMICOLON stmts {}
  | stmt {}
  ;

stmt : return_stmt {}
     ;

return_stmt : T_RETURN expr { $$ = $2; }
            ;

expr : expr T_PLUS term {}
     | term { $$ = $1; }
     ;

term : term T_MULT factor {}
     | factor { $$ = $1; }
     ;

factor : T_NUMBER { $$ = mk_int($1); }
       | T_ID { $$ = mk_ident($1); }
       ;

%%

int yyerror(const char* s) {
    printf("Error: %s\n", s);
    return 0;
}
