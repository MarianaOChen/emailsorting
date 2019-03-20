/*Laboratório 2 - Classificador de e-mails 
Esta tarefa consiste em encontrar e classificar e-mails recebidos numa string de entrada. O programa deverá obrigatoriamente ser feito usando lex/flex (se precisar, modifique o Makefile adequadamente). O programa deverá encontrar três categorias de elementos:

    E-mails válidos
    E-mails válidos de domínios unicamp.br
    E-mails válidos de domínios fee.unicamp.br

Após, deverá escrever na tela o número de e-mails válidos encontrados em cada uma das categorias. Note que um e-mail válido no domínio fee.unicamp.br também é um e-mail válido de domínio unicamp.br e também um e-mail válido (veja as entradas e saídas dos testes para maiores esclarecimentos).

Aluna: Mariana O. Chen - RA 156628 
Ultima edição: 20 Março 2019 
*/


%{ 

#include <stdio.h>
#include <string.h>

/* Criteiros de desempate:
   1 - Maior match
   2 - Regra que vem antes */

/*Variaveis de contagem  */

int validos = 0; //emails validos
int uni = 0; //emails unicamp
int fee = 0; // emails fee

%}

/*Expressões Regulares -----não ta certo o '?'*/

COM (com)
BR (br)
DOT [.]

dotCOM {DOT}{COM}
dotBR {DOT}{BR}

CARACTER [a-zA-Z0-9] 
AT [@]

UNICAMP (unicamp.br)
FEE (fee)

eVALIDO {CARACTER}+{AT}{CARACTER}+({DOT}{CARACTER}+)*{dotCOM}?{dotBR}?
eUNICAMP {CARACTER}+{AT}(({CARACTER}{DOT})*({CARACTER}+{DOT})*)*{UNICAMP}
eFEE {CARACTER}+{AT}({CARACTER}+{DOT})*{FEE}{DOT}{UNICAMP}

%%

{eFEE} {//printf("é valido FEE\n");
fee++;
uni++;
validos++;}

{eUNICAMP} {//printf("é valido UNICAMP\n");
uni++;
validos++;}

{eVALIDO} {//printf("é valido\n");
validos++;}

[[:space:]]+ ;
[[:^space:]]+ ;

[.\n]* ;

%%

int main() {
  yylex();
  /*printf("oi\n");
  printf("Validos:%d\n",validos);
  printf("UNICAMP:%d\n",uni);
  printf("FEE:%d\n",fee);
*/
  printf("%d %d %d\n", validos,uni,fee);
  return 0;
}
