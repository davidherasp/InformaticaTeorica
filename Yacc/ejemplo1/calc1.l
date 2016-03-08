%{
  #include "y.tab.h"
  #include <stdlib.h>
  #include <stdio.h>
  #include <string.h>
%}

%%

[0-9]+	{yylval = atoi(yytext); 
	 return NUM;}
[ \t]	;
\n	return 0;
.	return yytext[0];

%%
int yywrap(){
return 1;
}