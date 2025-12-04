% ajudas.pl
:- module(ajudas, [
    inicializar_ajudas/1,
    ajuda_disponivel/2,
    remover_ajuda/3,
    ajuda_50_50/3,
    ajuda_publico/3,
    ajuda_telefone/2
]).

:- use_module(library(random)).

inicializar_ajudas([cinquenta_cinquenta, publico, telefone]).

ajuda_disponivel(Tipo, Lista) :-
    member(Tipo, Lista).

remover_ajuda(Tipo, Lista, NovaLista) :-
    select(Tipo, Lista, NovaLista).

% 50/50: devolve uma lista de opções reduzida (mantém a correta + 1 errada)
ajuda_50_50(Correta, Opcoes, OpcoesReduzidas) :-
    findall(L, (member(L-_, Opcoes), L \= Correta), Erradas),
    random_permutation(Erradas, [Outra|_]),
    include(
        {Correta, Outra}/[Letra-Texto]>>(
            (Letra = Correta; Letra = Outra)
        ),
        Opcoes,
        OpcoesReduzidas).

% Ajuda do público: devolve distribuição [Letra-Percentagem]
ajuda_publico(Correta, Opcoes, Distribuicao) :-
    random_between(50, 80, PCorreta),
    Restante is 100 - PCorreta,
    length(Opcoes, N),
    NRest is N - 1,
    distribuir_restante(NRest, Restante, Valores),
    associar_percentagens(Opcoes, Correta, PCorreta, Valores, Distribuicao).

distribuir_restante(1, Valor, [Valor]) :- !.
distribuir_restante(N, Total, [X|Xs]) :-
    N > 1,
    Max is Total - (N-1),
    ( Max =< 0 -> X = 0 ; random_between(0, Max, X) ),
    NovoTotal is Total - X,
    N1 is N - 1,
    distribuir_restante(N1, NovoTotal, Xs).

associar_percentagens([], _, _, _, []).
associar_percentagens([L-_|Ops], Correta, PCorreta, Valores, [L-P|Res]) :-
    ( L = Correta ->
        P = PCorreta,
        Vs = Valores
    ;   Valores = [P|Vs]
    ),
    associar_percentagens(Ops, Correta, PCorreta, Vs, Res).

% Telefone: 80% de probabilidade de sugerir a correta
ajuda_telefone(Correta, Sugestao) :-
    random(0.0, 1.0, X),
    ( X < 0.8 ->
        Sugestao = Correta
    ;   Sugestao = nao_sei
    ).
