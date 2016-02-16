%{
#include <stdio.h>
int cont=0;
int contmin=0;
int contmay=0;
int conttres=0;
%}

minus [a-z]
mayusculas [A-Z] 
digito [0-9]
puntuacion [,.;?:)]
blanco (" ")
min (“(“)*({minus}|{digito})+({puntuacion}))*
may (“(“)*({mayusculas}|{digito})+({puntuacion}))*

%%

{min}      { 
                 	cont=yyleng;	
		  	if (cont==3)
		  	{
		      		conttres++;
		      		contmin++;
  		  	}
		  	else
		  	{
		      		contmin++;
		  	}
		  }

{may}     { 
                 cont=yyleng;	
		  if (cont==3)
		  {
		      conttres++;
		      contmay++;
  		  }
		  else
		  {
		      contmay++;
		  }
		}

{blanco}+	{
		  cont=cont+1;
	          if (cont==40) 
		     {
		       printf(" \n");
		       cont=0;
		     }	
		  else
		    printf("%s"," ");
 		}
.               ;

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
