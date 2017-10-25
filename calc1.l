%{
#include <string.h>
#define st_size 200
static int a= -1;
static int iv = 0;
static float st [st_size];
static void push (float i) {
	iv = 0;
    if (++a<st_size)
        st[a]= i;
    else 
        {printf ("error: Stack Overflow\n");}
}
static float pop (void) {
    if (a>=0)
        return st[a--];
    else {
        printf ("error: Stack Underflow\n");}
}
int val;
%}
digit 		[0-9]
integer 	{digit}+
real 		({digit}+[.]{digit}*)|({digit}*[.]{digit}+)
exp 		({integer}|{real})[eE]{integer}
exp2 		({integer}|{real})[eE][+-]{integer}
exp3 		[+-]({integer}|{real})[eE][+-]{integer}
integer2 	[+-]({integer}|{real})

%%
({integer}|{integer2}|{real}|{exp}|{exp2}|{exp3})       {push (atof(yytext));} 
"+"                     			  	{push (pop() + pop());}
"*"                      				{push (pop() * pop());}
"-"                      				{float fpu= pop(); push (pop() - fpu);}
"/"                      				{float fpo= pop(); push (pop() / fpo);}
[\n]	                				{if(iv==0) {printf("Result: "); printf("%g\n",pop());}}
[ \t]                   				;

[^-0-9+*/.;eE \t\n]+     {ECHO; 	iv=1; fprintf (stderr,"Invalid Character - ");} 
%%

int main (void) {a= -1; yylex(); return 0;}
int yywrap (void) {return 1;}
