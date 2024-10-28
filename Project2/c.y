%{
#include <stdio.h> /* printf() */
#include <string.h> /* strcpy() */
#include "common.h" /* MAX_STR_LEN */
int yylex(void);
void yyerror(const char *txt);
 
void found( const char *nonterminal, const char *value );
%}

%union 
{
	char s[ MAX_STR_LEN + 1 ]; /* text field for idents etc. */
	int i; /* integer field */
	double d; /* floating point field */
}

%token<i> KW_CHAR KW_UNSIGNED KW_SHORT KW_INT KW_LONG KW_FLOAT KW_VOID KW_FOR
%token<i> KW_DOUBLE KW_IF KW_ELSE KW_WHILE KW_DO KW_STRUCT
%token<i> INTEGER_CONST 
%token<d> FLOAT_CONST
%token<s> STRING_CONST CHARACTER_CONST
%token<i> INC LE
%token<s> IDENT

 /* Precedence of arithmetic operators '+' '-' '*' '/' 'NEG' */
%left '+' '-'
%left '*' '/'
%right NEG
%right COND

%type <s> FUN_HEAD FUN_CALL
%%

 /* STRUCTURE OF A C PROGRAM */

 /* program can be empty (semantic error),
    it can contain a syntax error or
    it may consist of a list of sections (SECTION_LIST) */
Grammar: { yyerror( "File is empty" ); YYERROR; }
	| error
	/* !!!!!!!! Start here !!!!!!!!!!!! */

;

/* SECTION_LIST */
 /* section list is a sequence of at least one section (SECTION) */
 
/* SECTION */
 /* section can be a declaration (S_DECLARATION) or a function (S_FUNCTION) */


 /* DATA DECLARATIONS */

/* S_DECLARACTION */
 /* data declaraction consists of a data type specification (DATA_TYPE)
    and a list of variables (VAR_LIST) finished with a semicolon */

/* DATA_TYPE */
 /* data type can be one of simple types: char, unsigned char, short,
    unsigned short, int, unsigned int, unsigned, long, unsigned long,
    float, double
    or it can be a structure (STRUCTURE) */

/* STRUCTURE */
 /* structure consists of a keyword struct (KW_STRUCT),
    optional structure name (OPT_TAG), left brace,
    list of fields (FIELD_LIST) and right brace. */

/* OPT_TAG */
 /* optional structure name is either empty or contains an identifier */

/* FIELD_LIST */
 /* list of fields is a non-empty sequence of fields (FIELD) */

/* FIELD */
/* a field is a data declaration (S_DECLARATION) */


/* VAR_LIST */
 /* list of variables consists of at least one variable (VAR). 
    More variables are separated with commas */

/* VAR */
 /* Variable is an identifier (IDENT) with subscripts (SUBSCRIPTS)
    or an identifier with initialization (done with the equal sign)
    that may be an arithmetic or logical expression (EXPR) or
                a string (STRING_CONST) */

/* SUBSCRIPTS */
 /* subscripts are a possibly empty sequence of subscripts (SUBSCRIPT) */

/* SUBSCRIPT */
 /* index is an expression in square brackets */

 /* FUNCTION DECLARATIONS */

/* S_FUNCTION */
 /* function declaration consists of return type specification 
    (DATA_TYPE or KW_VOID), function header (FUN_HEAD), and function body 
    (BLOCK). WATCH OUT! Create two separate rules, one for DATA_TYPE,
    and one for KW_VOID */

/* FUN_HEAD */
 /* function header starts with an identifier (IDENT), followed by 
    formal parameters (FORM_PARAMS) in parentheses */


/* FORM_PARAMS */
 /* formal parameters can be keyword void,
    or they can be formal  list (FORM_PARAM_LIST) */

/* FORM_PARAM_LIST */
 /* formal parameter list is a list of at least one FORM_PARAM,
    with formal parameters separated with commas */

/* FORM_PARAM */
 /* formal parameter consists of type definition (DATA_TYPE) and
    an identifier (IDENT) */

/* BLOCK */
 /* block consists of a single instruction (INSTRUCTION), or
    of a sequence: data declaration list (DECL_LIST)
    and instruction list (INSTR_LIST), with the whole sequence in braces */

/* DECL_LIST */
 /* declaration list can be empty or it may consist of a sequence of
    declarations (S_DECLARATION) */

/* INSTR_LIST */
 /* instruction list may be empty or it may consist of a sequence of
    instructions (INSTRUCTION) */

/* SIMPLE AND COMPLEX INSTRUCTIONS */

/* INSTRUCTION */
 /* instruction can be either:
    empty instruction (;),
    function call (FUN_CALL), 
    for loop (FOR_INSTR),
    assignment (ASSIGNMENT) followed by a semicolon,
    incrementation (INCR) followed by a semicolon,
    conditional instruction (IF_INSTR),
    while loop (WHILE_INSTR),
    do...while loop (DO_WHILE)  */

/* FUN_CALL */
 /* function callconsists of an identifier, left parenthesis,
    actual parameters (ACT_PARAMS), and right parenthesis.
    The right parenthesis is followed by a semicolon. */

/* ACT_PARAMS */
 /* actual parameters can be empty
    or they may contain a list of actual parameters (ACT_PARAM_LIST) */

/* ACT_PARAM_LIST */
 /* list of actual parameters is a comma-separated non-empty list
    of actual parameters (ACT_PARAM) */

/* ACT_PARAM */
/* actual parameter can be an expression (EXPR) or a string (STRING_CONST) */

/* INCR */
 /* incrementation consist of an identifier, a qualifier (QUALIF)
    and an incrementation operator (INC) */

/* QUALIF */
 /* qualifier can be subscripts (SUBSCRIPTS),
    or it may consist of a dot (period), identifier and a qualifier */

/* ASSIGNMENT */
 /* assignment consists of an identifier, qualifier,
    assignment operator and an expression */

/* NUMBER */
 /* a number can either be an integer constant or a floating point constant */

/* EXPR */
 /* expression may be one of the following:
    number,
    identifier with a qualifier,
    addition,
    subtraction,
    multiplication,
    division,
    negative expression (use priority of NEG),
    expression in parentheses,
    or a conditional expression (COND_EXPR) (use priority of COND) */

/* FOR_INSTR */
 /* for loop in simplified version consists of keyword for
    (KW_FOR), left parenthesis, assignment (ASSIGNMENT), semicolon,
    logical expression (LOG_EXPR), semicolon, incrementation (INCR),
    right parenthesis, and a block (BLOCK)
 */

/* LOG_EXPR */
 /* logical expression consists of two arithmetic expressions (EXPR),
    with operators <= (LE), <, and  > in between. */

/* IF_INSTR */
 /* conditional expression consists of keyword if (KW_IF), left parenthesis,
    logical expression (LOG_EXPR), right parenthesis, block (BLOCK),
    and else part (ELSE_PART)
  */

/* ELSE_PART */
/* else part can either be empty or it may consist of keword else (KW_ELSE)
   and a block (BLOCK) */

/* WHILE_INSTR */
/* while loop consists of keyword while (KW_WHILE), left parenthesis,
   logical expression (LOG_EXPR), right parenthesis, and a block (BLOCK)
 */

/* DO_WHILE */
/* do while loop consists of keyword do (KW_DO), block (BLOCK),
   keyword WHILE, left parenthesis,
   logical expression (LOG_EXPR), right parenthesis, and a semicolon
 */

/* COND_EXPR */
/* conditional expression consists of a logical expression (LOG_EXPR),
   question mark, expression (EXPR), colon, and expression */
%%


int main( void )
{
	int ret;
	printf( "Author: first nad last name\n" );
	printf( "yytext              Token type      Token value as string\n\n" );
	ret = yyparse();
	return ret;
}

void yyerror( const char *txt )
{
	printf( "Syntax error %s\n", txt );
}

void found( const char *nonterminal, const char *value )
{ /* info on syntax structures found */
	printf( "======== FOUND: %s %s%s%s ========\n", nonterminal, 
		(*value) ? "'" : "", value, (*value) ? "'" : "" );
}
