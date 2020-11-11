%{
#include "attr.h"
#include "parse.tab.h"
#define YY_SKIP_YYWRAP
#include <stdio.h>
#include <stdlib.h>
%}

  extern YYSTYPE yylval;
  extern int yywrap() {return 1;};
  extern int isatty();

%%

T  	{ yylval.boolType.t = 1; yylval.boolType.f = 0; yylval.boolType.op_and = 0; 
	yylval.boolType.op_or = 0; yylval.boolType.op_xor = 0; return Const; }

F  	{ yylval.boolType.t = 0; yylval.boolType.f = 1; yylval.boolType.op_and = 0;
	yylval.boolType.op_or = 0; yylval.boolType.op_xor = 0; return Const; }

[ \t]	; // ignore all whitespace

.	{ return *yytext; }
%%
