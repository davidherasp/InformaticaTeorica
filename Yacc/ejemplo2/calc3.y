%{
#include "calc3.h"
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <stdio.h>

void yyerror(const char* msg) {
    fprintf(stderr, "%s\n", msg);
}
int yylex(void);

  int num_sim = 0;

%}

%union 	{
	   double          valor;
	   struct simbolo  *indice;
	}
%token 	<valor>		NUM
%token 	<indice>	VARIABLE
%type	<valor>		exp asignacion lista

%right '='
%left '+' '-'
%left '*' '/'
%nonassoc MENOSUNARIO
%right '^'

%%
lista:	asignacion '\n' 
   |	lista asignacion '\n'
   ;

asignacion: 	VARIABLE '=' exp
		{
		   $$ = $1->valor = $3;
		}
	   | 	exp
		{
		   { printf("\t = %.8g\n",$1); }
		}
		;
		
exp:	exp '+' exp 
	{
	  $$ = $1 + $3; 
	}
   |	exp '-' exp 
	{
	  $$ = $1 - $3; 
	}
   |	exp '*' exp 
	{
	  $$ = $1 * $3; 
	}
   |	exp '/' exp 
	{
	  if ($3 == 0)
              yyerror("division por cero");
	  else
              $$ = $1 / $3;
			
	}
   |	'-' exp %prec MENOSUNARIO 
	{
	  $$ = -$2; 
	}
   |	exp '^' exp
	{
	  $$ = $1+$3;
	}
   |	'(' exp ')' 
	{
	  $$ = $2; 
	}
   |	NUM  
	{
	  $$ = $1; 
	}
   |	VARIABLE 
        {
   	  $$ = $1->valor;
	}
   
   ;

%%

int main()
{
      yyparse();
 
}


struct simbolo *buscar_simbolo(char *s)
{
  int i;
  if (num_sim == MAX_SIM)
  {
     yyerror("Demasiados simbolos");
     exit(1);
  }
  else{
  
    for (i = 0; i<num_sim; i++)
    {
       if ((strcmp(s,tabla_simbolos[i].nombre) == 0)) 
          {
            /*strcmp devuelve 0 si son iguales */
	    return &tabla_simbolos[i];	    
	  }
    }
    tabla_simbolos[num_sim].nombre = (char *) malloc (strlen(s)+1);
    strcpy(tabla_simbolos[num_sim].nombre,s);
    /* tabla_simbolos[num_sim].nombre = strdup(s);*/
    num_sim++;
    return &tabla_simbolos[num_sim-1];
   
  }

}
