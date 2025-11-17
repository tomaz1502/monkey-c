%{
#include <string.h>
#include "parser.tab.h"
%}

DIGIT  [0-9]
NUMBER \-?{DIGIT}+
ID [a-zA-Z][a-zA-Z0-9_]*

%%

{NUMBER} { yylval.num = atoi(yytext); return T_NUMBER; }
"("      { return T_LPAR; }
")"      { return T_RPAR; }
"{"      { return T_LBRACK; }
"}"      { return T_RBRACK; }
";"      { return T_SEMICOLON; }
","      { return T_COMMA; }
":"      { return T_COLON; }
"+"      { return T_PLUS; }
"="      { return T_ASSIGN; }
"-"      { return T_MINUS; }
"!"      { return T_BANG; }
"*"      { return T_MULT; }
"/"      { return T_SLASH; }
"<"      { return T_LT; }
">"      { return T_GT; }
"=="     { return T_EQ; }
"!="     { return T_NEQ; }
"let"    {  return T_LET; }
"fn"     { return T_FN; }
"return" { return T_RETURN; }
"if"     { return T_IF; }
"else"   { return T_ELSE; }
"true"   { return T_TRUE; }
"false"  { return T_FALSE; }
"int"    { return T_INT; }
"bool"   { return T_BOOL; }
"unit"   { return T_UNIT; }
"->"     { return T_ARROW; }
"\n"     { return T_NEWLINE; }
[ \t] {}
{ID} {
    if(strlen(yytext) >= 32) {
        perror("Identifier too long");
    } else {
        yylval.id = (char*) malloc(sizeof(char) * 32);
        strcpy(yylval.id, yytext);
        printf("T_ID(%s)\n", yylval.id);
        return T_ID;
    }
}
%%

int yywrap() { return 0; }
