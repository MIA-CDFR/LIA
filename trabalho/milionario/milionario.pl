% milionario.pl
:- use_module(library(readutil)).

:- use_module(perguntas).
:- use_module(ajudas).
:- use_module(interface).
:- use_module(logica).

:- dynamic jogador_acertou/0.
:- dynamic jogador_errou/0.
:- dynamic jogador_progrediu/0.

jogar :-
    banner,
    inicializar_ajudas(Ajudas),
    jogar_nivel(1, 0, 0, Ajudas).

% Caso base: ultrapassou o número de perguntas -> vitória total
jogar_nivel(Nivel, PremioAtual, _PremioSeguro, _Ajudas) :-
    numero_perguntas(Total),
    Nivel > Total,
    !,
    escrever_vitoria_final(PremioAtual),
    pausar.

% Caso geral: jogar uma pergunta
jogar_nivel(Nivel, PremioAtual, PremioSeguro, Ajudas) :-
    pergunta(Nivel, Texto, Opcoes, Correta, _N, PremioPergunta),
    ( patamar(Nivel) -> NovoSeguro = PremioPergunta ; NovoSeguro = PremioSeguro ),
    banner,
    mostrar_estado(Nivel, PremioAtual, NovoSeguro, Ajudas),
    mostrar_pergunta(Texto, Opcoes),
    pedir_acao(Ajudas, Acao),
    processar_acao(Acao, Nivel, PremioAtual, NovoSeguro, Ajudas, Texto, Opcoes, Correta, PremioPergunta).

% Ler ação do jogador
pedir_acao(Ajudas, Acao) :-
    write("\nIntroduz a tua opção:\n"),
    write("  A/B/C/D -> responder\n"),
    write("  50      -> ajuda 50/50\n"),
    write("  P       -> ajuda do público\n"),
    write("  T       -> telefonema\n"),
    write("  E       -> desistir\n"),
    write("> "),
    read_line_to_string(user_input, S),
    string_upper(S, U),
    normalizar_acao(U, Ajudas, Acao).

normalizar_acao("A", _Ajudas, responder(a)).
normalizar_acao("B", _Ajudas, responder(b)).
normalizar_acao("C", _Ajudas, responder(c)).
normalizar_acao("D", _Ajudas, responder(d)).
normalizar_acao("50", Ajudas, ajuda(cinquenta_cinquenta)) :-
    ( ajuda_disponivel(cinquenta_cinquenta, Ajudas) -> true
    ; write("A ajuda 50/50 já foi usada.\n"), fail ).
normalizar_acao("P", Ajudas, ajuda(publico)) :-
    ( ajuda_disponivel(publico, Ajudas) -> true
    ; write("A ajuda do público já foi usada.\n"), fail ).
normalizar_acao("T", Ajudas, ajuda(telefone)) :-
    ( ajuda_disponivel(telefone, Ajudas) -> true
    ; write("A ajuda do telefone já foi usada.\n"), fail ).
normalizar_acao("E", _Ajudas, desistir).
normalizar_acao(_, Ajudas, Acao) :-
    write("Opção inválida. Tenta novamente.\n"),
    pedir_acao(Ajudas, Acao).

% Processamento das diferentes ações
processar_acao(desistir, _Nivel, PremioAtual, _PremioSeguro, _Ajudas, _Texto, _Opcoes, _Correta, _PremioPergunta) :-
    escrever_desistencia(PremioAtual),
    pausar.

processar_acao(responder(L), Nivel, PremioAtual, PremioSeguro, Ajudas, _Texto, _Opcoes, Correta, PremioPergunta) :-
    ( L = Correta ->
        retractall(jogador_acertou),
        assertz(jogador_acertou),
        ( conclusao(progresso) -> true ; true ),
        retractall(jogador_acertou),
        NovoPremio is PremioPergunta,
        retractall(jogador_progrediu),
        assertz(jogador_progrediu),
        ( conclusao_incorreta(resposta_certa) -> true ; true ),
        retractall(jogador_progrediu),
        write("\nResposta correta! Avanças para o próximo nível.\n"),
        pausar,
        ProxNivel is Nivel + 1,
        jogar_nivel(ProxNivel, NovoPremio, PremioSeguro, Ajudas)
    ;   retractall(jogador_errou),
        assertz(jogador_errou),
        ( conclusao(nao_resposta_certa) -> true ; true ),
        retractall(jogador_errou),
        escrever_derrota(PremioSeguro),
        pausar
    ).

processar_acao(ajuda(Tipo), Nivel, PremioAtual, PremioSeguro, Ajudas, Texto, Opcoes, Correta, PremioPergunta) :-
    remover_ajuda(Tipo, Ajudas, NovasAjudas),
    ( Tipo = cinquenta_cinquenta ->
        ajuda_50_50(Correta, Opcoes, OpcoesReduzidas),
        write("\nAJUDA 50/50: Duas opções foram removidas.\n\n"),
        banner,
        mostrar_estado(Nivel, PremioAtual, PremioSeguro, NovasAjudas),
        mostrar_pergunta(Texto, OpcoesReduzidas),
        pedir_acao(NovasAjudas, Acao2),
        processar_acao(Acao2, Nivel, PremioAtual, PremioSeguro, NovasAjudas, Texto, OpcoesReduzidas, Correta, PremioPergunta)
    ; Tipo = publico ->
        ajuda_publico(Correta, Opcoes, Dist),
        write("\nAJUDA DO PÚBLICO:\n"),
        mostrar_distribuicao_publico(Dist),
        pedir_acao(NovasAjudas, Acao2),
        processar_acao(Acao2, Nivel, PremioAtual, PremioSeguro, NovasAjudas, Texto, Opcoes, Correta, PremioPergunta)
    ; Tipo = telefone ->
        ajuda_telefone(Correta, Sugestao),
        write("\nAJUDA DO TELEFONE:\n"),
        mostrar_sugestao_telefone(Sugestao),
        pedir_acao(NovasAjudas, Acao2),
        processar_acao(Acao2, Nivel, PremioAtual, PremioSeguro, NovasAjudas, Texto, Opcoes, Correta, PremioPergunta)
    ).
