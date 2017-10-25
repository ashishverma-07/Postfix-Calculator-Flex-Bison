%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "calc2.tab.h"

%}

digit		[0-9]
integer		{digit}+
real		({digit}+[.]{digit}*)|({digit}*[.]{digit}+)
exp		({integer}|{real})[eE]{integer}
exp2		({integer}|{real})[eE][+-]{integer}
exp3		[+-]({integer}|{real})[eE][+-]{integer}
integer2	[+-]({integer}|{real})

%%

[ \t]	; // ignore all whitespace
[0-9]+\.[0-9]+ 	{yylval.float_val = atof(yytext); return T_FLOAT;}
[0-9]+		{yylval.int_val = atoi(yytext); return T_INT;}
\n		{return T_NEWLINE;}
"+"		{return T_PLUS;}
"-"		{return T_MINUS;}
"*"		{return T_MULTIPLY;}
"/"		{return T_DIVIDE;}
"("		{return T_LEFT;}
")"		{return T_RIGHT;}
{exp}		{yylval.float_val = atof(yytext); return T_FLOAT;}
{exp2}		{yylval.float_val = atof(yytext); return T_FLOAT;}
{exp3}		{yylval.float_val = atof(yytext); return T_FLOAT;}
{integer2}	{yylval.float_val = atof(yytext); return T_FLOAT;}
.		{fprintf(stderr, "Invalid character %s\n", yytext);}

%%
