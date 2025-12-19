:- use_module(perguntas).
:- use_module(library(random)).
:- use_module(library(lists)).

% HTTP
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/json)).
:- use_module(library(http/http_files)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_header)).

% Configurar CORS
:- set_setting(http:cors, [*]).

% Servir arquivos estáticos
:- http_handler(root(.), http_reply_from_files('.', []), [prefix]).

% API endpoints
:- http_handler(root('api/question'), api_question, []).
:- http_handler(root('api/check'),    api_check,    []).

% Estado lógico
:- dynamic jogador_acertou/0.
:- dynamic jogador_errou/0.


% =========================================================
%  Regras de Inferência
% =========================================================

implica(resposta_certa, progresso).

% Modus Ponens: Se resposta_certa então progresso (quando jogador_acertou)
verdadeiro(resposta_certa) :-
    jogador_acertou.

% Falácia intencional (Modus Mistaken) – para discutir no relatório:
% Se progresso então resposta_certa (não é válido em geral)
verdadeiro(progresso).

falso(progresso) :-
    jogador_errou.

conclusao(progresso) :-
    implica(resposta_certa, progresso),
    verdadeiro(resposta_certa).

conclusao(nao_resposta_certa) :-
    implica(resposta_certa, progresso),
    falso(progresso).

conclusao_incorreta(resposta_certa) :-
    implica(resposta_certa, progresso),
    verdadeiro(progresso).

% =========================================================
%  Patamares de segurança (modo consola)
% =========================================================

patamar(5, 1000).
patamar(10, 5000).

atualiza_patamar(NumPergunta, Saldo, PatamarAtual, NovoPatamar) :-
    (   patamar(NumPergunta, ValorPatamar),
        ValorPatamar =< Saldo
    ->  NovoPatamar = ValorPatamar
    ;   NovoPatamar = PatamarAtual
    ).

% =========================================================
%  Geração de perguntas por nível (progressão 1,2,3,4,5)
% =========================================================

perguntas_por_nivel(Nivel, ListaAleatoria) :-
    findall(pergunta(Id,Texto,Opcoes,Correta,Nivel,Valor),
            pergunta(Id,Texto,Opcoes,Correta,Nivel,Valor),
            Lista),
    random_permutation(Lista, ListaAleatoria).

/*
  perguntas_progressivas(ListaFinal)

  Cria a sequência de 20 perguntas assim:
  - Primeiro todas as de nível 1 (baralhadas)
  - Depois nível 2 (baralhadas)
  - Depois nível 3, nível 4, nível 5
*/
perguntas_progressivas(ListaFinal) :-
    perguntas_por_nivel(1, L1),
    perguntas_por_nivel(2, L2),
    perguntas_por_nivel(3, L3),
    perguntas_por_nivel(4, L4),
    perguntas_por_nivel(5, L5),
    append([L1,L2,L3,L4,L5], ListaFinal).

% =========================================================
%  Jogo em consola (académico)
% =========================================================

/*
  Predicado principal:

    ?- jogar.

*/

jogar :-
    perguntas_progressivas(PerguntasProgressivas),
    writeln('==============================='),
    writeln('   QUEM QUER SER MILIONARIO   '),
    writeln('==============================='),
    EstadoAjudas = ajudas(nao,nao,nao),
    loop_jogo(PerguntasProgressivas, 0, 0, 0, EstadoAjudas).

loop_jogo([], _, Saldo, _, _) :-
    format('Fim do jogo! Ganhou €~d.~n', [Saldo]), !.

loop_jogo([pergunta(Id,Texto,Opcoes,Correta,Nivel,Valor)|Restantes],
          NumPergunta, SaldoAtual, PatamarAtual, EstadoAjudas) :-

    NumPergunta1 is NumPergunta + 1,
    format('~nPergunta ~d (nivel ~d, valendo €~d)~n', [NumPergunta1,Nivel,Valor]),
    writeln(Texto),
    mostra_opcoes(Opcoes),
    format('Saldo: €~d | Patamar: €~d~n', [SaldoAtual,PatamarAtual]),
    writeln('Responda com a. b. c. d.  |  desistir.'),
    read(Input),
    Pergunta = pergunta(Id,Texto,Opcoes,Correta,Nivel,Valor),
    processa_entrada(Input,
                     Pergunta,
                     Restantes,
                     NumPergunta1,
                     SaldoAtual,
                     PatamarAtual,
                     EstadoAjudas).

processa_entrada(desistir,
                 _Pergunta,
                 _Restantes,
                 _NumPergunta,
                 SaldoAtual,
                 _PatamarAtual,
                 _EstadoAjudas) :-
    format('Desistiu com €~d. Ate a proxima!~n', [SaldoAtual]),
    !.

processa_entrada(Resp,
                 pergunta(Id,Texto,Opcoes,Correta,Nivel,Valor),
                 Restantes,
                 NumPergunta,
                 SaldoAtual,
                 PatamarAtual,
                 EstadoAjudas) :-
    ( member(Resp, [a,b,c,d]) ->
        retractall(jogador_acertou),
        retractall(jogador_errou),
        ( Resp == Correta ->
            assertz(jogador_acertou),
            conclusao(progresso),   % Modus Ponens
            NovoSaldo is SaldoAtual + Valor,
            atualiza_patamar(NumPergunta, NovoSaldo, PatamarAtual, NovoPatamar),
            format('Resposta correta! +€~d. Saldo atual: €~d.~n',
                   [Valor,NovoSaldo]),
            loop_jogo(Restantes, NumPergunta, NovoSaldo, NovoPatamar, EstadoAjudas)
        ;   assertz(jogador_errou),
            conclusao(nao_resposta_certa),  % Modus Tollens
            format('Resposta errada. Fica com o patamar: €~d.~n',
                   [PatamarAtual]),
            !
        )
    ;   writeln('Entrada invalida. Tente novamente.'),
        loop_jogo([pergunta(Id,Texto,Opcoes,Correta,Nivel,Valor)|Restantes],
                  NumPergunta-1,
                  SaldoAtual,
                  PatamarAtual,
                  EstadoAjudas)
    ).

mostra_opcoes([]).
mostra_opcoes([Letra-Texto | Resto]) :-
    format(' (~w) ~w~n', [Letra, Texto]),
    mostra_opcoes(Resto).

% =========================================================
%  Servir index.html
% =========================================================
index_page(Request) :-
    http_reply_file('index.html', [], Request).

% Define a progressão de nível em função do número de perguntas
% (1..5 => nível 1, 6..10 => nível 2, 11..15 => nível 3, 16..19 => nível 4, 20 => nível 5)
nivel_por_indice(I, 1) :- I >= 1,  I =< 5.
nivel_por_indice(I, 2) :- I >= 6,  I =< 10.
nivel_por_indice(I, 3) :- I >= 11, I =< 15.
nivel_por_indice(I, 4) :- I >= 16, I =< 19.
nivel_por_indice(I, 5) :- I =:= 20.

% /api/question?used=1,2,3
% devolve pergunta aleatoria nao usada, respeitando o nivel da progressao
api_question(Request) :-
    cors_enable(Request, [methods([get,post,options])]),
    http_parameters(Request,
        [ used(UsedStr, [optional(true), default('')])
        ]),
    parse_used_ids(UsedStr, UsedIds),
    length(UsedIds, NUsadas),
    Index is NUsadas + 1,
    (   Index > 20
    ->  reply_json(_{ done:true })
    ;   nivel_por_indice(Index, Nivel),
        findall(pergunta(Id,Texto,Opcoes,Correta,Nivel,Valor),
                pergunta(Id,Texto,Opcoes,Correta,Nivel,Valor),
                TodasNivel),
        include(nao_usada(UsedIds), TodasNivel, Disponiveis),
        ( Disponiveis = [] ->
            reply_json(_{ done:true })
        ; random_member(pergunta(Id,Texto,Opcoes,Correta,Nivel,Valor), Disponiveis),
          Opcoes = [a-A, b-B, c-C, d-D],
          reply_json(_{
              done:false,
              id:Id,
              text:Texto,
              options:_{a:A,b:B,c:C,d:D},
              correct:Correta,
              level:Nivel,
              value:Valor
          })
        )
    ).

nao_usada(UsedIds, pergunta(Id,_,_,_,_,_)) :-
    \+ member(Id, UsedIds).

parse_used_ids('', []) :- !.
parse_used_ids(Str, Ids) :-
    split_string(Str, ",", " ", Partes),
    (   Partes = [''] -> Ids = []
    ;   maplist(number_string, Ids, Partes)
    ).

% /api/check?id=3&answer=b
% verifica se a resposta esta correta
api_check(Request) :-
    cors_enable(Request, [methods([get,post,options])]),
    http_parameters(Request,
        [ id(IdAtom, []),
          answer(AnsAtom, [])
        ]),
    atom_number(IdAtom, Id),
    downcase_atom(AnsAtom, Resp),
    pergunta(Id,_Texto,_Opcoes,Correta,_Nivel,Valor),
    retractall(jogador_acertou),
    retractall(jogador_errou),
    ( Resp == Correta ->
        assertz(jogador_acertou),
        conclusao(progresso),
        Correct = true
    ;   assertz(jogador_errou),
        conclusao(nao_resposta_certa),
        Correct = false
    ),
    reply_json(_{
        correct:Correct,
        correctLetter:Correta,
        value:Valor
    }).


iniciar_servidor :-
    Port = 8086,
    format('Servidor na porta ~w...~n', [Port]),
    http_server(http_dispatch, [port(Port)]),
    % 2. Cria a URL (ajuste o caminho se for diferente de index.html)
    format(atom(URL), 'http://localhost:~w/index.html', [Port]),

    % 3. Abre o navegador padrão do sistema
    write('Servidor rodando em: '), write(URL), nl,
    www_open_url(URL).


:- initialization(iniciar_servidor).