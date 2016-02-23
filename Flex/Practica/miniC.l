%{
#include <stdio.h>
#include <string.h>

%}

letra [a-zA-Z]
natural [0-9]
noDigitos [_{letra}]
puntuacion [,;)}]
input [^\r\n]
operador [+*=&]
operador2 ("&&")
blanco (" ")
eol( \n | \r | \r\n )
numero( {natural}+ ("."{natural}+)? )
ident(  {letra} ({noDigitos}|{natural})* )
coment(  "//" {input}* {eol}? )




%%

{}   { 
                
			  
		  }

.               ;

%%


int main()
{
  

}
int yywrap(){
return 1;
}
