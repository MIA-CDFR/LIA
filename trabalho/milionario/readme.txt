============================================================
                 QUEM QUER SER MILIONÁRIO – PROLOG
============================================================

Trabalho prático da UC Lógica e Inteligência Artificial  
Universidade do Minho  
2025 / 2026

Autores:
[Colocar nomes]
============================================================


1. DESCRIÇÃO DO PROJETO
------------------------------------------------------------
Este projeto implementa uma versão textual e interativa do 
jogo “Quem Quer Ser Milionário?” em Prolog.

Inclui:
- 20 perguntas com níveis de dificuldade crescentes;
- Patamares de segurança;
- Três ajudas (50/50, público, telefone);
- Controlo recursivo do jogo;
- Demonstração das regras de inferência:
    * Modus Ponens
    * Modus Tollens
    * Modus Mistaken (falácia)
- Interface textual com ASCII art.


2. ESTRUTURA DE FICHEIROS
------------------------------------------------------------
milionario/
 ├── milionario.pl     ← Código principal e loop do jogo
 ├── perguntas.pl      ← Base de dados das 20 perguntas
 ├── ajudas.pl         ← Implementação das ajudas
 ├── interface.pl      ← ASCII art e interações com o jogador
 ├── logica.pl         ← Regras lógicas (Ponens, Tollens, Mistaken)
 └── README.txt        ← Este ficheiro


3. COMO CORRER O JOGO
------------------------------------------------------------
1) Abrir o SWI-Prolog.

2) Mudar para a pasta do projeto:
   ?- cd('CAMINHO/para/milionario').

3) Carregar o programa:
   ?- [milionario].

4) Iniciar o jogo:
   ?- jogar.


4. COMO JOGAR
------------------------------------------------------------
Durante o jogo podes:

A, B, C, D   → responder
50           → ajuda 50/50
P            → ajuda do público
T            → ajuda por telefone
D            → desistir


5. DEPENDÊNCIAS
------------------------------------------------------------
O projeto usa apenas SWI-Prolog.

Bibliotecas nativas utilizadas:
- library(random)
- library(readutil)


6. NOTAS SOBRE LÓGICA
------------------------------------------------------------
O ficheiro logica.pl implementa e demonstra:

• Modus Ponens:
   Se a resposta é correta → há progresso.

• Modus Tollens:
   Se não houve progresso → a resposta não era correta.

• Modus Mistaken (falacioso):
   Se houve progresso → a resposta era correta.
   (Este raciocínio é falsamente válido e deve ser explicado
   no relatório técnico.)


7. AUTORIA
------------------------------------------------------------
Projeto desenvolvido por:
[Colocar nomes e nºs de aluno]


============================================================
Fim do README
============================================================
