%{
#include <stdio.h>
#include <stdlib.h>

int linha = 1;
FILE *arquivo;
%}

letra  [a-zA-Z_]
dig    [0-9]

%%

{dig}+("."{dig}+)?      { printf("NUMERO: %s\n", yytext); }

{letra}({letra}|{dig})* { printf("IDENTIFICADOR: %s\n", yytext); }

"=="    { printf("OPERADOR IGUAL\n"); }
"!="    { printf("OPERADOR DIFERENTE\n"); }
">="    { printf("OPERADOR MAIOR IGUAL\n"); }
"<="    { printf("OPERADOR MENOR IGUAL\n"); }
">"     { printf("OPERADOR MAIOR\n"); }
"<"     { printf("OPERADOR MENOR\n"); }

"+"     { printf("OPERADOR SOMA\n"); }
"-"     { printf("OPERADOR SUBTRACAO\n"); }
"*"     { printf("OPERADOR MULTIPLICACAO\n"); }
"/"     { printf("OPERADOR DIVISAO\n"); }
"%"     { printf("OPERADOR RESTO\n"); }

"="     { printf("ATRIBUICAO\n"); }

"("     { printf("ABRE PARENTESES\n"); }
")"     { printf("FECHA PARENTESES\n"); }

\n      { linha++; }

[ \t]+  { }

.       { printf("ERRO LEXICO (linha %d): %s\n", linha, yytext); }

%%

int main(){

    printf("=== ANALISADOR LEXICO CPython ===\n");

    arquivo = fopen("teste.txt", "r");

    if (!arquivo) {
        printf("Erro ao abrir o arquivo teste.txt\n");
        return 1;
    }

    yyin = arquivo;

    yylex();

    fclose(arquivo);

    return 0;
}

int yywrap() {
    return 1;
}
