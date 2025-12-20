:- module(perguntas, [pergunta/6, todas_perguntas/1]).

/*
pergunta(
    Id, => identificador unico da pergunta
    Texto, => texto da pergunta
    [a-OpA, b-OpB, c-OpC, d-OpD], => opcoes de resposta
    RespostaCorreta,  % a | b | c | d => resposta correta
    Nivel,            % 1..5 => nivel de dificuldade
    Valor             % euros => valor em euros da pergunta
).
*/

pergunta(1,
    'Quanto e 2 + 2?',
    [a-'3', b-'4', c-'5', d-'22'],
    b, 1, 100).

pergunta(2,
    'Qual e a capital de Portugal?',
    [a-'Porto', b-'Lisboa', c-'Coimbra', d-'Faro'],
    b, 1, 200).

pergunta(3,
    'Qual destes animais e um mamifero?',
    [a-'Tubarao', b-'Sardinha', c-'Golfinho', d-'Polvo'],
    c, 1, 300).

pergunta(4,
    'Qual e o planeta conhecido como Planeta Vermelho?',
    [a-'Venus', b-'Marte', c-'Jupiter', d-'Mercurio'],
    b, 1, 400).

pergunta(5,
    'Em que continente fica Portugal?',
    [a-'Europa', b-'Africa', c-'America do Sul', d-'Asia'],
    a, 1, 500).

pergunta(6,
    'Quem escreveu "Os Lusiadas"?',
    [a-'Camilo Castelo Branco', b-'Luis de Camoes', c-'Fernando Pessoa', d-'Eca de Queiros'],
    b, 2, 1000).

pergunta(7,
    'Qual e a formula quimica da agua?',
    [a-'H2O', b-'CO2', c-'O2', d-'NaCl'],
    a, 2, 2000).

pergunta(8,
    'Qual destes numeros e primo?',
    [a-'9', b-'15', c-'17', d-'21'],
    c, 2, 3000).

pergunta(9,
    'Quem pintou a Mona Lisa?',
    [a-'Picasso', b-'Van Gogh', c-'Da Vinci', d-'Rembrandt'],
    c, 2, 4000).

pergunta(10,
    'Qual e o maior oceano do mundo?',
    [a-'Atlantico', b-'Pacifico', c-'Indico', d-'Artico'],
    b, 2, 5000).

pergunta(11,
    'Qual e a lingua oficial do Brasil?',
    [a-'Espanhol', b-'Portugues', c-'Ingles', d-'Frances'],
    b, 3, 10000).

pergunta(12,
    'Qual destes animais e um marsupial?',
    [a-'Canguru', b-'Gato', c-'Cao', d-'Cavalo'],
    a, 3, 15000).

pergunta(13,
    'Qual e o simbolo quimico do ouro?',
    [a-'Ag', b-'Au', c-'Fe', d-'Pb'],
    b, 3, 20000).

pergunta(14,
    'Quem foi o primeiro homem a pisar a Lua?',
    [a-'Yuri Gagarin', b-'Buzz Aldrin', c-'Neil Armstrong', d-'Michael Collins'],
    c, 3, 30000).

pergunta(15,
    'Qual destes paises nao faz parte da Uniao Europeia?',
    [a-'Espanha', b-'Noruega', c-'Alemanha', d-'Italia'],
    b, 3, 40000).

pergunta(16,
    'Qual e a unidade de medida da forca no SI?',
    [a-'Joule', b-'Watt', c-'Newton', d-'Pascal'],
    c, 4, 50000).

pergunta(17,
    'Qual destas linguagens e principalmente usada para logica declarativa?',
    [a-'Java', b-'Python', c-'Prolog', d-'C++'],
    c, 4, 75000).

pergunta(18,
    'Quem desenvolveu a teoria da relatividade?',
    [a-'Isaac Newton', b-'Albert Einstein', c-'Galileu Galilei', d-'Niels Bohr'],
    b, 4, 100000).

pergunta(19,
    'Qual e a raiz quadrada de 144?',
    [a-'10', b-'11', c-'12', d-'13'],
    c, 4, 150000).

pergunta(20,
    'Qual e o maior pais do mundo em area?',
    [a-'Canada', b-'China', c-'Estados Unidos', d-'Russia'],
    d, 5, 200000).

todas_perguntas(Lista) :-
    findall(pergunta(Id,Texto,Opcoes,Correta,Nivel,Valor),
            pergunta(Id,Texto,Opcoes,Correta,Nivel,Valor),
            Lista).
