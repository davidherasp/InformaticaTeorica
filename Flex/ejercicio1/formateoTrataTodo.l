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
Minuscula (“(“)*({minus}|{digito})+({puntuacion})*
Mayuscula (“(“)*({mayusculas}|{digito})+({puntuacion})*

%%

{Minuscula}     { 
                 	cont=yyleng;	
		  	if (cont==3)
		  	{
		      		conttres=conttres+1;
		      		contmin=contmin+1;
  		  	}
		  	else
		  	{
		      		contmin=contmin+1;
		  	}
		  }

{Mayuscula}     { 
                 cont=yyleng;	
		  if (cont==3)
		  {
		      conttres=conttres+1;
		      contmay=contmay+1;
  		  }
		  else
		  {
		      contmay=contmay+1;
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
main()
{
  char nfe[100];
  printf("Fichero de entrada: ");
  scanf("%s",nfe);
  yyin=fopen(nfe,"r");
  if (yyin !=NULL)
    yylex();
  printf(“Cantidad de min: %d”, contmin);
  printf(“Cantidad de may: %d”, contmay);
  printf(“Cantidad de 3: %d”, conttres);
}

int yywrap(){
return 1;
}
