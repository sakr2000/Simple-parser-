%{ 
    //  The code was cloned from : https://github.com/jatin69/python-parser
    // with adding some edits in keywords of the language and tokens     

    #include <stdio.h>
    #include <stdlib.h>
    #include "simple-parser.tab.h" 
    
    int i;
    #define border printf("\n"); for(i=0; i<=90; ++i) { putchar('*'); } printf("\n");
    void yyerror(char *errorMsg);
    void success(char *successMsg);
%}

%%
"if"|"include"|"switch"|"int"|"float"|"goto"|"const"|"break"|"continue" return (KEYWORD);
"and"|"static"|"class"|"def"|"short"|"else if" return (KEYWORD);
"else"|"double"|"for"|"return"|"struct"|"while" return (KEYWORD);
"printf" return(PRINT);

[ \t]                   ;
\=                      return (EQ);
\+                      return (PLUS);
\-                      return (MINUS);
\*                      return (MUL);
\/                      return (DIVIDE);
\(                      return (LEFTBRACKET);
\)                      return (RIGHTBRACKET);
\;                      return (SEMICOLON);
\'([^\'\n])*\'          return (STRING_Single);
\"([^\"\n])*\"          return (STRING_Double); 
[0-9]+                  return NUMBER;
[_a-zA-Z][_a-zA-Z0-9]*  return ID ; 
.                       { printf("\n Unidentified token %s\n", yytext);  exit(1); }

%%

int main() {
    printf("\n****************************** SIMPLE PARSER ******************************\n");
    printf("\nEnter an expression : \n");
    yyparse();
    return 0;
}

void success(char *successMsg) {
    fprintf(stderr, "\n%s\n", successMsg);
    border;
}

void yyerror(char *errorMsg){
    fprintf(stderr, "\n%s\n", errorMsg);
    border;
}

int yywrap() {
  return 1;
}