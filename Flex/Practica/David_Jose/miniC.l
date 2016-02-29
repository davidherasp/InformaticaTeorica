%{

#include <stdio.h>
#include <string.h>
int ints = 0, floats = 0, ifs = 0, mains = 0, elses = 0, scanfs = 0, printfs = 0, lineasCodigo = 0, lineasComentario = 0, idents = 0;
char *identificadores[10][10];

%}

letra [a-zA-Z]
natural [0-9]
nodigitos [_a-zA-Z]
puntuacion [,;)}]
input [^\r\n]
operador [+*=&]
operador2 ("&&")
blanco (" ")
eol (\n|\r|\r\n)
numero ({natural}+("."{natural}+)?)
ident {letra}({nodigitos}|{natural})*
coment ("//"{input}*{eol}?)

%%

"printf"	printfs++;
"int"		{ints++; REJECT;}			
"float"		{floats++; REJECT;}
"if"		ifs++;
"else"		elses++;
"main"		mains++;
"scanf"		scanfs++;

("int "{ident}) {
	char identificador[10];
	strcpy(identificador,yytext) ;
	for(int i = 0; i < 10; i++)
	{
		if( i >= 3)
		{
			identificadores[idents][i-4]=identificador[i];
		}
	}
	idents++ ;
}

("float "{ident}) {
	char identificador[10];
	strcpy(identificador,yytext) ;
	for(int i = 0; i < 10; i++)
	{
		if( i >= 4)
		{
			identificadores[idents][i-5]=identificador[i];
		}
	}
	idents++ ;
}

(","{ident}) {
	char identificador[10];
	strcpy(identificador,yytext) ;
	for(int i = 0; i < 10; i++)
	{
		if( i >= 1)
		{
			identificadores[idents][i-2]=identificador[i];
		}
	}
	idents++ ;
}

{coment} {
	lineasComentario++ ;
}

.|\n ;

%%

int main()
{	
	char nombre[100];
	yyin = fopen ("../data/entrada.c","r");
	
	if (yyin != NULL)
	{
		yylex();
	}

	printf("\nints: %d floats: %d if: %d, main: %d, else: %d, scanf: %d, printf: %d\n",ints, floats, ifs, mains, elses, scanfs, printfs);
  	printf("Numero lineas comentario: %d\n",lineasComentario);
  	printf("Idents: ");

  	for (int i = 0; i < idents; i++)
  	{
  		printf("%s, ", identificadores[i]);
  	} 

  	printf("\n");
}

int yywrap()
{
	return 1;
}
