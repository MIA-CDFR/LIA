% logica.pl
% Modus Ponens, Tollens, Mistaken
:- module(logica, [
    implica/2,
    verdadeiro/1,
    falso/1,
    conclusao/1,
    conclusao_incorreta/1
]).

/*
   Aqui modelamos as regras lógicas pedidas no enunciado.
   Nota: estes predicados são exemplo de raciocínio lógico e
   podem ser usados no relatório como ilustração formal.
*/

% Se a resposta for certa, então há progresso (Modus Ponens e Tollens)
implica(resposta_certa, progresso).

% Fatos de exemplo (devem ser interpretados como "o jogador acertou" / "errou")
verdadeiro(resposta_certa) :- jogador_acertou.
falso(progresso) :- jogador_errou.

% Modus Ponens:
% Se implica(A,B) e verdadeiro(A), então concluímos B.
conclusao(progresso) :-
    implica(resposta_certa, progresso),
    verdadeiro(resposta_certa).

% Modus Tollens:
% Se implica(A,B) e falso(B), então concluímos não A.
conclusao(nao_resposta_certa) :-
    implica(resposta_certa, progresso),
    falso(progresso).

% Falácia: "Modus Mistaken"
% Se o jogador progrediu, então a resposta era correta (nem sempre é válido).
verdadeiro(progresso) :- jogador_progrediu.

conclusao_incorreta(resposta_certa) :-
    implica(resposta_certa, progresso),
    verdadeiro(progresso).

/*
No relatório explicas que esta última regra é falaciosa:
do facto de haver progresso não se pode logicamente inferir
que a resposta tenha sido correta em todos os contextos.
*/
