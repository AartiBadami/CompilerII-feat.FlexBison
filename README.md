Aarti S. Badami
NetID: asb243
RUID #172003903

TO RUN :

1. cd /path/to/question/2
2. execute the command: "./gates" or "./gates < test-cases.txt"
3. If a file is not specified, the program will read from the stdin

- When using the original grammar in question 2 in flex/bison, the parse.y throws a "shift/reduce conflicts" warning.  This gramar is also ambiguous, demonstrated by the following example, which has two ways of being parsed:

input: E || E && E.

parse #1: Expr || Expr && Expr. > Expr && Expr. > Expr. > Program
parse #2: Expr || Expr && Expr. > Expr || Expr. > Expr. > Program


- In order to fix this ambiguity, the grammar is rewritten as follows:

Program ::= Expr0.

Expr0 ::= Expr0 Expr1
	| ~ Expr0
	| (Expr0)
	| Const

Expr1 ::= || Expr0
	| Expr2

Expr2 ::= ^ Expr0
	| Expr3

Expr3 ::= && Expr0

Const ::= T | F
