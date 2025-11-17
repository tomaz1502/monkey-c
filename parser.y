%{
#include <ctype.h>
#include <stdio.h>

extern int yylex(void);
extern int yyerror(const char* s);
%}

%union {
    int num;
    char* id;
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

%start stmt

%%

stmts :
  | stmt T_SEMICOLON stmts {}
  | ;

stmt :
  | let_stmt {}
  | return_stmt {}

return_stmt :
  | T_RETURN expr {}

let_stmt :
  | T_LET T_ID T_ASSIGN expr

expr:



loop : | loop line ;

line : expr T_NEWLINE { printf("%d\n", $1); }
     ;
expr : expr T_PLUS term { $$ = $1 + $3; }
     | term
     ;
term : term T_MULT factor { $$ = $1 * $3;  }
     | factor
     ;
factor : T_LPAR expr T_RPAR { $$ = $2; }
     | T_NUMBER
     ;

%%

int yyerror(const char* s) {
    printf("Error: %s\n", s);
}
