%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#include "syntax_tree.h"

// external functions from lex
extern int yylex();
extern int yyparse();
extern int yyrestart();
extern FILE * yyin;

// external variables from lexical_analyzer module
extern int lines;
extern char * yytext;
extern int pos_end;
extern int pos_start;

// Global syntax tree
syntax_tree *gt;

// Error reporting
void yyerror(const char *s);

// Helper functions written for you with love
syntax_tree_node *node(const char *node_name, int children_num, ...);
%}

/* TODO: Complete this definition.
   Hint: See pass_node(), node(), and syntax_tree.h.
         Use forward declaring. */
%union {
    struct _syntax_tree_node* node;
}

/* TODO: Your tokens here. */
%token <node> ERROR
%token <node> ADD SUB MUL FAC LT LE GT GE EQ NE EQ1 FH DH LSK RSK LMK RMK LBK RBK LZS RZS IF ELSE INT 
%token <node> RETURN VOID WHILE FLOAT_TYPE id NUMBER  int_num float_num
%type <node> program declaration-list declaration var-declaration type-specifier fun-declaration
%type <node> params param-list param compound-stmt local-declarations  statement-list statement
%type <node> expression-stmt selection-stmt iteration-stmt return-stmt expression var simple-expression
%type <node> relop additive-expression addop mulop factor integer float call args arg-list term
%start program 

%%
/* TODO: Your rules here. */

/* Example:
program: declaration-list {$$ = node( "program", 1, $1); gt->root = $$;}
       ;
*/

program : declaration-list {$$ = node( "program", 1, $1); gt->root = $$;};
declaration-list : declaration-list declaration {$$ = node( "declaration-list", 2, $1 ,$2);}
     | declaration {$$ = node( "declaration-list", 1, $1);};
declaration : var-declaration {$$ = node( "declaration", 1, $1);}
     | fun-declaration {$$ = node( "declaration", 1, $1);};
var-declaration : type-specifier id FH {$$ = node( "var-declaration", 3, $1 , $2, $3);}
    | type-specifier id LMK int_num RMK FH {$$ = node( "var-declaration", 6, $1,$2,$3,$4,$5,$6);};
type-specifier : INT {$$ = node( "type-specifier", 1, $1);}
     | FLOAT_TYPE {$$ = node( "type-specifier", 1, $1);}
     | VOID {$$ = node( "type-specifier", 1, $1);};
fun-declaration : type-specifier id LSK params RSK compound-stmt {$$ = node( "fun-declaration", 6, $1,$2,$3,$4,$5,$6);};
params : param-list {$$ = node( "params", 1, $1);}
    | VOID {$$ = node( "params", 1, $1);};
param-list : param-list DH param {$$ = node( "param-list", 3, $1,$2,$3);}
    | param {$$ = node( "param-list", 1, $1);};
param : type-specifier id {$$ = node( "param", 2, $1,$2);}
    | type-specifier id LMK RMK {$$ = node( "param", 4, $1,$2,$3,$4);};
compound-stmt : LBK local-declarations statement-list RBK {$$ = node( "compound-stmt", 4, $1,$2,$3,$4);};
local-declarations : local-declarations var-declaration {$$ = node( "local-declarations", 2, $1,$2);}
    | {$$ = node( "local-declarations", 0);};
statement-list : statement-list statement {$$ = node( "statement-list", 2, $1,$2);}
    | {$$ = node( "statement-list", 0);};
statement : expression-stmt {$$ = node( "statement", 1, $1);}
    | compound-stmt {$$ = node( "statement", 1, $1);}
    | selection-stmt {$$ = node( "statement", 1, $1);}
    | iteration-stmt {$$ = node( "statement", 1, $1);}
    | return-stmt {$$ = node( "statement", 1, $1);};
expression-stmt : expression FH {$$ = node( "expression-stmt", 2, $1,$2);}
    | FH {$$ = node( "expression-stmt", 1, $1);};
selection-stmt : IF LSK expression RSK statement {$$ = node( "selection-stmt", 5, $1,$2,$3,$4,$5);}
    | IF LSK expression RSK statement ELSE statement {$$ = node( "selection-stmt", 7, $1,$2,$3,$4,$5,$6,$7);};
iteration-stmt : WHILE LSK expression RSK statement {$$ = node( "iteration-stmt", 5, $1,$2,$3,$4,$5);};
return-stmt : RETURN FH {$$ = node( "return-stmt", 2, $1,$2);}
    | RETURN expression FH {$$ = node( "return-stmt", 3, $1,$2,$3);};
expression : var EQ1 expression {$$ = node( "expression", 3, $1,$2,$3);}
    | simple-expression {$$ = node( "expression", 1, $1);};
var : id {$$ = node( "var", 1, $1);}
    | id LMK expression RMK {$$ = node( "var", 4, $1,$2,$3,$4);};
simple-expression : additive-expression relop additive-expression {$$ = node( "simple-expression", 3, $1,$2,$3);}
    | additive-expression {$$ = node( "simple-expression", 1, $1);};
relop : LE {$$ = node( "relop", 1, $1);}
    | LT {$$ = node( "relop", 1, $1);}
    | GT {$$ = node( "relop", 1, $1);}
    | GE {$$ = node( "relop", 1, $1);}
    | EQ {$$ = node( "relop", 1, $1);}
    | NE {$$ = node( "relop", 1, $1);};
additive-expression : additive-expression addop term {$$ = node( "additive-expression", 3, $1,$2,$3);}
    | term {$$ = node( "additive-expression", 1, $1);};
addop : ADD {$$ = node( "addop", 1, $1);}
    | SUB {$$ = node( "addop", 1, $1);};
term : term mulop factor {$$ = node( "term", 3, $1,$2,$3);}
    | factor {$$ = node( "term", 1, $1);};
mulop : MUL {$$ = node( "mulop", 1, $1);}
    | FAC {$$ = node( "mulop", 1, $1);};
factor : LSK expression RSK {$$ = node( "factor", 3, $1,$2,$3);}
    | var {$$ = node( "factor", 1, $1);}
    | call {$$ = node( "factor", 1, $1);}
    | integer {$$ = node( "factor", 1, $1);}
    | float {$$ = node( "factor", 1, $1);};
integer : int_num {$$ = node( "integer", 1, $1);};
float : float_num {$$ = node( "float", 1, $1);};
call : id LSK args RSK {$$ = node( "call", 4, $1,$2,$3,$4);};
args : arg-list {$$ = node( "args", 1, $1);}
    |  {$$ = node( "args", 0);}
	;
arg-list : arg-list DH expression {$$ = node( "arg-list", 3, $1,$2,$3);}
    | expression {$$ = node( "arg-list", 1, $1);};
%%

/// The error reporting function.
void yyerror(const char * s)
{
    // TO STUDENTS: This is just an example.
    // You can customize it as you like.
	extern int yylineno;	// defined and maintained in lex
	// defined and maintained in lex
	int len=strlen(yytext);
	int i;
	char buf[512]={0};
	for (i=0;i<len;++i)
	{
		sprintf(buf,"%s%c",buf,yytext[i]);
	}
	fprintf(stderr, "ERROR: %s at symbol '%s' on line %d\n", s, buf, yylineno);

}

/// Parse input from file `input_path`, and prints the parsing results
/// to stdout.  If input_path is NULL, read from stdin.
///
/// This function initializes essential states before running yyparse().
syntax_tree *parse(const char *input_path)
{
    if (input_path != NULL) {
        if (!(yyin = fopen(input_path, "r"))) {
            fprintf(stderr, "[ERR] Open input file %s failed.\n", input_path);
            exit(1);
        }
    } else {
        yyin = stdin;
    }

    lines = pos_start = pos_end = 1;
    gt = new_syntax_tree();
    yyrestart(yyin);
    yyparse();
    return gt;
}

/// A helper function to quickly construct a tree node.
///
/// e.g. $$ = node("program", 1, $1);
syntax_tree_node *node(const char *name, int children_num, ...)
{
    syntax_tree_node *p = new_syntax_tree_node(name);
    syntax_tree_node *child;
    if (children_num == 0) {
        child = new_syntax_tree_node("epsilon");
        syntax_tree_add_child(p, child);
    } else {
        va_list ap;
        va_start(ap, children_num);
        for (int i = 0; i < children_num; ++i) {
            child = va_arg(ap, syntax_tree_node *);
            syntax_tree_add_child(p, child);
        }
        va_end(ap);
    }
    return p;
}
