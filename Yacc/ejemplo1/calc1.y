%{
    #include <stdio.h>


void yyerror(const char* msg) {
    fprintf(stderr, "%s\n", msg);
}
    int yylex(void);

%}
%token NUM
%left '+' '-'
%left '*' '/'
%nonassoc MENOSUNA

%%
lista: /*epsilon*/
   |	exp { printf("\t %d\n",$1); }
   ;

exp:	exp '+' exp {$$ = $1 + $3; }
   |	exp '-' exp {$$ = $1 - $3; }
   |	exp '*' exp {$$ = $1 * $3; }
   |	exp '/' exp {if ($3 == 0)
                        yyerror("division por cero");
			 else
				$$ = $1 / $3;
			}
   |	'-' exp %prec MENOSUNA {$$ = -$2; }
   |	'(' exp ')' {$$ = $2; }
   |	NUM  {$$ = $1; }
   ;

%%

int main()
{
      yyparse();
 
}


