%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int int_val;
	float float_val;
}

%token<int_val> T_INT
%token<float_val> T_FLOAT
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT
%token T_NEWLINE
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%type<int_val> exp
%type<float_val> float_exp

%start start

%%

start: 
	   | start line
;

line: T_NEWLINE
    | float_exp T_NEWLINE { printf("Result: %g\n", $1);}
    | exp T_NEWLINE { printf("Result: %i\n", $1); } 
    
;

float_exp: T_FLOAT                 		 { $$ = $1; }
	  | float_exp float_exp T_PLUS	 	 { $$ = $1 + $2; }
	  | float_exp float_exp T_MINUS	 	 { $$ = $1 - $2; }
	  | float_exp float_exp T_MULTIPLY	 { $$ = $1 * $2; }
	  | float_exp float_exp T_DIVIDE	 { $$ = $1 / $2; }
	  | T_LEFT float_exp T_RIGHT		 { $$ = $2; }
	  | exp float_exp T_PLUS	 	 { $$ = $1 + $2; }
	  | exp float_exp T_MINUS		 { $$ = $1 - $2; }
	  | exp float_exp T_MULTIPLY		 { $$ = $1 * $2; }
	  | exp float_exp T_DIVIDE		 { $$ = $1 / $2; }
	  | float_exp exp T_PLUS	 	 { $$ = $1 + $2; }
	  | float_exp exp T_MINUS 		 { $$ = $1 - $2; }
	  | float_exp exp T_MULTIPLY		 { $$ = $1 * $2; }
	  | float_exp exp T_DIVIDE	 	 { $$ = $1 / $2; }
	  | exp exp T_DIVIDE			 { $$ = $1 / (float)$2; }


;

exp: T_INT				{ $$ = $1; }
	  | exp exp T_PLUS		{ $$ = $1 + $2; }
	  | exp exp T_MINUS		{ $$ = $1 - $2; }
	  | exp exp T_MULTIPLY		{ $$ = $1 * $2; }

	  | T_LEFT exp T_RIGHT		{ $$ = $2; }
;

%%

int main() {
	yyin = stdin;

	do { 
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	
	;
}
