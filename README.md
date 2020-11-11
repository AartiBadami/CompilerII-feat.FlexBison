This compiler reads boolean logic statements (specific grammar rules outlined below) and prints the results of the logic.  This is a compiled language so any syntax errors are caught at compile-time.  The lexical parser and tokenizer uses Flex/Bison.  

  
--Grammar Rules--  
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
  
  
--How to Run Tests--
1. cd /path/to/CompilerII/directory
2. execute the command: "./gates" or "./gates < test-cases.txt"
3. If a file is not specified, the program will read from the stdin



