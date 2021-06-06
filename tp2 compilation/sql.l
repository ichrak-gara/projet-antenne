%{
#include <stdio.h>
#include "y.tab.h"
%}
alpha [A-Za-z]
digit[0-9]
%%
[ \t\n]			;	
"select"		return SELECT;
"from"			return FROM;
"where"			return WHERE;
"group"		return GROUP;
"having"		return HAVING;
"order"		return ORDER;
"desc"			return DESC;
"asc"			return ASC;
"and"			return AND;
"or"			return OR;
"distinct"		return DISTINCT;
{digit}({digit})*	return NUM;
{alpha}({alpha}|{digit})*	return ID;
.				return yytext[0];

%%
int yywrap(){
return 0;
}
