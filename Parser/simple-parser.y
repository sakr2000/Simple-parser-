%{
    /*  The code was cloned from : https://github.com/jatin69/python-parser
        with adding some edits in keywords of the language and tokens     */
        
    #include <stdio.h>
    int yydebug=1;
    int yylex(void);
    
    int i;
    #define border printf("\n"); for(i=0; i<=90; ++i) { putchar('*'); } printf("\n");
    void yyerror(char *errorMsg);
    void success(char *successMsg);
%}

// tokens
%token EQ PLUS MINUS MUL DIVIDE LEFTBRACKET RIGHTBRACKET SEMICOLON
%token ID NUMBER STRING_Single STRING_Double
%token PRINT KEYWORD

// set precedence
%right EQ
%left PLUS MINUS
%left MUL DIVIDE

%%

/* Parser Grammar */

start: stmt SEMICOLON {
            success("Accepted Expression");
            YYACCEPT; 
        }
    ;

stmt:  assign_arithmetic
    |  assign_str
    |  display
    ;
    
identifier: ID | keyword { 
            yyerror("\nkeywords can't be used as a identifier\n"); 
            YYABORT; 
        }
    ;
        
keyword: PRINT | KEYWORD
    ;
    
assign_str:  identifier EQ strings
    ;

display: PRINT strings
    | PRINT strings MUL NUMBER
    | PRINT strings PLUS strings
    | PRINT expr
    ;
    
strings: STRING_Single | STRING_Double
    ;

assign_arithmetic: identifier EQ expr
    ;

expr: expr PLUS expr
    | expr MINUS expr
    | expr MUL expr
    | expr DIVIDE expr
    | factor
    | LEFTBRACKET expr RIGHTBRACKET
    | SIGN factor
    ;

SIGN: PLUS
    | MINUS
    ;

factor: identifier 
    |   NUMBER
    ;

%%