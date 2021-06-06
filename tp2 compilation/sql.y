%{
#include <stdio.h>
int num_lines = 0, num_chars = 0;
%}
%token ID NUM SELECT FROM DISTINCT WHERE GROUP HAVING ORDER DESC ASC
%token AND OR
%start Input
%%
Input:
|Input S;
S	: ST1 ';' 
ST1 	: SELECT attributList FROM tableList {printf("REQUETE ACCEPTEE... \n\t");}
	| SELECT error {printf("REQUETE Manque un attribut... \n\t");}
     	| SELECT DISTINCT attributList FROM tableList {printf("REQUETE ACCEPTEE... \n\t");}
     	| SELECT DISTINCT attributList FROM error {printf("REQUETE MANQUE un tablelsit... \n\t");}
	| SELECT attributList FROM tableList ST2;
	
ST2:	WHERE error {printf("Condition manquante !! \n");}
	| WHERE COND ST3
	|
	|WHERE COND {printf("REQUETE avec Condition ACCEPTEE... \n\t");};

ST3:	GROUP attributList ST4 {printf("REQUETE avec Group ACCEPTEE... \n\t");}
	| ST4
	;
	
ST4:	HAVING COND ST5 {printf("REQUETE avec Having ACCEPTEE... \n\t");}
	| ST5
	;
	
ST5:	ORDER attributList ST6 {printf("REQUETE avec Order ACCEPTEE... \n\t");}
	|
	;

ST6:	DESC 
	| ASC
	;

attributList :		ID','attributList
	     	| '*'
		| ID
		;

tableList	: ID',' tableList
	  	  | ID
		  ;
COND:	COND OR COND
	| COND AND COND
	| E;

E:	F '=' F
	| F '<' F
	| F '>' F
	| F '=''=' F
	| F '<''=' F
	| F '>''=' F
	| F '!''=' F
	| F OR F
	| F AND F;

F: 	ID
	| NUM;
%%
extern FILE * yyin;
extern int yylineno, yychar;
void yyerror(char *s) {
    fprintf(stderr,"%s: token %d on line %d\n", s, yychar, yylineno);
    return 1;
}
int main(void)
 {

printf("Entrer une requete:\n");
yyin=fopen("./test.txt","r");
if (yyin==NULL) return -1;
yyparse();
}
