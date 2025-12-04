% interface.pl
:- module(interface, [
    limpar_ecra/0,
    pausar/0,
    banner/0,
    mostrar_estado/4,
    mostrar_pergunta/2,
    mostrar_opcoes/1,
    mostrar_distribuicao_publico/1,
    mostrar_sugestao_telefone/1,
    escrever_vitoria_final/1,
    escrever_derrota/1,
    escrever_desistencia/1
]).

limpar_ecra :-
    write('\e[2J\e[H').

pausar :-
    write('\nPressiona ENTER para continuar...'),
    read_line_to_string(user_input, _).

banner :-
    limpar_ecra,
    write('=========================================\n'),
    write('      QUEM QUER SER MILIONÁRIO?         \n'),
    write('=========================================\n\n').

mostrar_estado(Nivel, PremioAtual, PremioSeguro, Ajudas) :-
    format("Nível atual: ~d~n", [Nivel]),
    format("Prémio atual: €~d~n", [PremioAtual]),
    format("Patamar de segurança: €~d~n", [PremioSeguro]),
    format("Ajudas disponíveis: ~w~n~n", [Ajudas]).

mostrar_pergunta(Texto, Opcoes) :-
    format("Pergunta: ~s~n", [Texto]),
    mostrar_opcoes(Opcoes).

mostrar_opcoes([]).
mostrar_opcoes([Letra-Texto|R]) :-
    format("  ~w) ~s~n", [Letra, Texto]),
    mostrar_opcoes(R).

mostrar_distribuicao_publico([]) :-
    nl.
mostrar_distribuicao_publico([Letra-Percent|R]) :-
    format("  ~w: ~d%%~n", [Letra, Percent]),
    mostrar_distribuicao_publico(R).

mostrar_sugestao_telefone(nao_sei) :-
    write("O amigo não tem a certeza... diz que não sabe.\n").
mostrar_sugestao_telefone(Letra) :-
    format("O amigo acha que a resposta correta é: ~w~n", [Letra]).

escrever_vitoria_final(Premio) :-
    banner,
    format("PARABÉNS! És um verdadeiro milionário!~nPrémio final: €~d~n", [Premio]),
    nl.

escrever_derrota(PremioSeguro) :-
    banner,
    format("Resposta incorreta!~nFicas apenas com o patamar de segurança: €~d~n", [PremioSeguro]),
    nl.

escrever_desistencia(PremioAtual) :-
    banner,
    format("Decidiste desistir com: €~d~n", [PremioAtual]),
    nl.
