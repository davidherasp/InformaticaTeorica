%{
#include <stdio.h>
int cont=0;
int contmin=0;
int contmay=0;
int conttres=0;
%}

minus [a-z]+
mayus [A-Z]+ 
mix [a-zA-Z]+
tres [a-zA-Z]{3,3}

%%

{minus} {}

{mayus} {}

. | /n ;

%%
int main()
{
  char nfe[100];
  printf("Fichero de entrada: ");
  scanf("%s",nfe);
  yyin=fopen(nfe,"r");
  if (yyin !=NULL)
    yylex();
  printf("Cantidad de min: %d", contmin);
  printf("Cantidad de may: %d", contmay);
  printf("0Cantidad de 3: %d", conttres);
}

int yywrap(){
return 1;
}
