%option noyywrap
%{
/*****************声明和选项设置  begin*****************/
#include <stdio.h>
#include <stdlib.h>

#include "syntax_tree.h"
#include "syntax_analyzer.h"

int lines=1;
int pos_start=1;
int pos_end=1;

void pass_node(char *text){
     yylval.node = new_syntax_tree_node(text);
}

/*****************声明和选项设置  end*****************/

%}

digit   [0-9]
ID   [a-zA-Z]+
INTEGER   {digit}+

%%
 /* to do for students */
 /* two cases for you, pass_node will send flex's token to bison */
\n 	{lines++;pos_start=1; pos_end = 1;}
[ \t\r]+ {pos_end++;} 
\/\*\/*([^\/]*[^\/\*]\/[\/]*)*[^\/]*\*\/ {}
\+ {pos_start = pos_end; pos_end += 1;pass_node(yytext); return ADD;}
\-  {pos_start = pos_end; pos_end += 1;pass_node(yytext); return SUB;}
\*  {pos_start = pos_end; pos_end += 1;pass_node(yytext); return MUL;}
\/	{pos_start = pos_end; pos_end += 1;pass_node(yytext); return FAC;}
\<	{pos_start = pos_end; pos_end += 1;pass_node(yytext); return LT;}
\<= {pos_start = pos_end; pos_end += 2;pass_node(yytext); return LE;}
\>	{pos_start = pos_end; pos_end += 1;pass_node(yytext); return GT;}
\>=	{pos_start = pos_end; pos_end += 2;pass_node(yytext); return GE;}
\== {pos_start = pos_end; pos_end += 2;pass_node(yytext); return EQ;}
\!= {pos_start = pos_end; pos_end += 2;pass_node(yytext); return NE;}
\= 	{pos_start = pos_end; pos_end += 1;pass_node(yytext); return EQ1;}
\;	{pos_start = pos_end; pos_end += 1;pass_node(yytext); return FH;}
\,	{pos_start = pos_end; pos_end += 1;pass_node(yytext); return DH;}
\(  {pos_start = pos_end; pos_end += 1;pass_node(yytext); return LSK;}
\)  {pos_start = pos_end; pos_end += 1;pass_node(yytext); return RSK;}
\[  {pos_start = pos_end; pos_end += 1;pass_node(yytext); return LMK;}
\]	{pos_start = pos_end; pos_end += 1;pass_node(yytext); return RMK;}
\{	{pos_start = pos_end; pos_end += 1;pass_node(yytext); return LBK;}
\}	{pos_start = pos_end; pos_end += 1;pass_node(yytext); return RBK;}
if {pos_start = pos_end;pos_end += 2;pass_node(yytext); return IF;}
else {pos_start = pos_end;pos_end += 4;pass_node(yytext); return ELSE;}
int {pos_start = pos_end;pos_end +=3;pass_node(yytext); return INT;}
return {pos_start = pos_end; pos_end += 6;pass_node(yytext); return RETURN;}
void {pos_start = pos_end; pos_end += 4; pass_node(yytext); return VOID;}
while {pos_start = pos_end; pos_end += 5; pass_node(yytext); return WHILE;}
float {pos_start = pos_end; pos_end += 5; pass_node(yytext); return FLOAT_TYPE;}
{ID} {pos_start = pos_end; pos_end += yyleng; pass_node(yytext); return id;}
{INTEGER} {pos_start = pos_end; pos_end += yyleng; pass_node(yytext); return int_num;}
[0-9]*\.[0-9]+ {pos_start = pos_end; pos_end += yyleng;pass_node(yytext); return float_num;}
[0-9]+\.        {pos_start = pos_end; pos_end += yyleng;pass_node(yytext); return float_num;}
. { pos_start = pos_end; pos_end++; return ERROR; }
 /****请在此补全所有flex的模式与动作  end******/
%%
