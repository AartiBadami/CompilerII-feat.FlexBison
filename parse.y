%{
#include <stdio.h>
#include "attr.h"
int yylex();
void yyerror(char * s);
%}

%union {
  BoolType boolType;
}

%token Const
%type<boolType> Expr3 Expr2 Expr1 Expr0 Line Const

%start Program

%%

Program : Line Program	{ }
	| Line		{ }
	;

Line : Expr0 '.' { if ($1.t) {
		     printf("T");
		   } else {
		       printf("F");
		   }
		 }
     ;

Expr0 : Expr0 Expr1	{ if ($2.op_or) {
                              // printf("t_flag_1: %d, f_flag_1: %d\n", $1.t, $1.f);
                              // printf("t_flag_2: %d, f_flag_2: %d\n", $2.t, $2.f);
                            if ($1.t) {
                              if ($2.t) {
                                $$.t = 1;
                                $$.f = 0;
                              } else {
                                $$.t = 1;
                                $$.f = 0;
                              }
                            } else {
                              if ($2.t) {
                                $$.t = 1;
                                $$.f = 0;
                              } else {
                                $$.t = 0;
                                $$.f = 1;
                              }
                            }
			  } else if ($2.op_and) {
			      // printf("t_flag_1: %d, f_flag_1: %d\n", $1.t, $1.f);
                              // printf("t_flag_2: %d, f_flag_2: %d\n", $2.t, $2.f);
                              if ($1.t) {
                                if ($2.t) {
                                  $$.t = 1;
                                  $$.f = 0;
                                } else {
                                  $$.t = 0;
                                  $$.f = 1;
                                }
                              } else {
                                  if ($2.t) {
                                    $$.t = 0;
                                    $$.f = 1;
                                  } else {
                                    $$.t = 0;
                                    $$.f = 1;
                                  }
				}
                          } else if ($2.op_xor) {
                              if ($1.t) {
                                if ($2.t) {
                                  $$.t = 0;
                                  $$.f = 1;
                                } else {
                                  $$.t = 1;
                                  $$.f = 0;
                                }
                              } else {
                                  if ($2.t) {
                                    $$.t = 1;
                                    $$.f = 0;
                                  } else {
                                    $$.t = 0;
                                    $$.f = 1;
                                  }
                              }
			  }
			  // printf("#6 AND: %d | OR: %d | XOR: %d\n", $2.op_and, $2.op_or, $2.op_xor);
			}

      | '~' Expr0	{ if ($2.t) {
                            $$.t = 0;
                            $$.f = 1;
                          } else {
                            $$.t = 1;
                            $$.f = 0;
                          }
			}

      | '(' Expr0 ')'	{ if ($2.t) {
                            $$.t = 1;
                            $$.f = 0;
                          } else {
                            $$.t = 0;
                            $$.f = 1;
                          }
			}

      | Const		{ if ($1.t) {
                            $$.t = 1;
                            $$.f = 0;
                          } else {
                            $$.t = 0;
                            $$.f = 1;
                          }
                          // printf("#const AND: %d | OR: %d | XOR: %d\n", $$.op_and, $$.op_or, $$.op_xor);
			}
      ;

Expr1 : '|''|' Expr0	{ $$.op_or = 1;
                          // printf("#5 AND: %d | OR: %d | XOR: %d\n", $$.op_and, $$.op_or, $$.op_xor);
			  if ($3.t) {
                            $$.t = 1;
                            $$.f = 0;
                          } else {
                            $$.t = 0;
                            $$.f = 1;
                          }
			}

      | Expr2		{ if ($1.op_and) {
			    $$.op_and = 1;
			  } else if ($1.op_or) {
			      $$.op_or = 1;
			  } else {
			      $$.op_xor = 1;
			  }
                          // printf("#4 AND: %d | OR: %d | XOR: %d\n", $$.op_and, $$.op_or, $$.op_xor);
			  if ($1.t) {
                            $$.t = 1;
                            $$.f = 0;
                          } else {
                            $$.t = 0;
                            $$.f = 1;
                          }
			}
      ;

Expr2 : '^' Expr0	{ $$.op_xor = 1;
                          // printf("#3 AND: %d | OR: %d | XOR: %d\n", $$.op_and, $$.op_or, $$.op_xor);
			  if ($2.t) {
                            $$.t = 1;
                            $$.f = 0;
                          } else {
                            $$.t = 0;
                            $$.f = 1;
                          }
			}

      | Expr3		{ $$.op_and = 1;
                          // printf("#2 AND: %d | OR: %d | XOR: %d\n", $$.op_and, $$.op_or, $$.op_xor);
                          // printf("f_flag @ Expr2: %d\n", $$.f);
                          // printf("t_flag @ Expr2: %d\n", $$.t);
                          if ($1.t) {
                            $$.t = 1;
                            $$.f = 0;
                          } else {
                            $$.t = 0;
                            $$.f = 1;
                          }
			}
      ;

Expr3 : '&''&' Expr0	{ $$.op_and = 1;
                          // printf("#1 AND: %d | OR: %d | XOR: %d\n", $$.op_and, $$.op_or, $$.op_xor);
			  // printf("f_flag @ Expr3: %d\n", $$.f);
                          // printf("t_flag @ Expr3: %d\n", $$.t);
			  if ($3.t) {
			    $$.t = 1;
                            $$.f = 0;
			  } else {
                            $$.t = 0;
                            $$.f = 1;
			  }
			}
      ;



%%

void yyerror(char* s) {
  fprintf(stderr, "%s\n", s);
}

int main(int argc, char* argv[]) {
  yyparse();
  return 0;
}

