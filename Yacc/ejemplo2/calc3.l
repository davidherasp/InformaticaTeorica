%{
  #include "y.tab.h"
  #include "calc3.h"
  #include <string.h>
  

%}
entero	[0-9]+
real	{entero}+[.]{entero}([eE][-+]?{entero})?
iden	[a-z][a-z0-9]*
%%
{entero}|{real}	{yylval.valor = atof(yytext);
	 	 return NUM;
		}
[ \t]	;
"fin"	{return 0; /*finito*/}
{iden}	{
	 yylval.indice = buscar_simbolo(yytext); 

	 return VARIABLE;
	}

.|\n	return yytext[0];

%%
int yywrap(){
return 1;
}

