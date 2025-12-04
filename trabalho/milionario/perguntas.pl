% perguntas.pl
:- module(perguntas, [
    pergunta/6,
    numero_perguntas/1,
    patamar/1
]).

% pergunta(Id, Texto, Opcoes, Correta, Nivel, Premio).

pergunta(1,
    "Qual é a capital de Portugal?",
    [a-"Lisboa", b-"Porto", c-"Coimbra", d-"Braga"],
    a, 1, 100).

pergunta(2,
    "Quanto é 7 * 8?",
    [a-"54", b-"56", c-"64", d-"58"],
    b, 2, 200).

pergunta(3,
    "Quem escreveu 'Os Lusíadas'?",
    [a-"Fernando Pessoa", b-"Eça de Queirós", c-"Camões", d-"Sophia de Mello Breyner"],
    c, 3, 300).

pergunta(4,
    "Qual é o maior planeta do Sistema Solar?",
    [a-"Terra", b-"Júpiter", c-"Saturno", d-"Neptuno"],
    b, 4, 500).

pergunta(5,
    "Quantos continentes existem tradicionalmente?",
    [a-"4", b-"5", c-"6", d-"7"],
    d, 5, 1000).

pergunta(6,
    "Que linguagem é usada principalmente para páginas web no lado do cliente?",
    [a-"Java", b-"Python", c-"JavaScript", d-"C++"],
    c, 6, 2000).

pergunta(7,
    "Que país venceu o Mundial de Futebol de 2016 (UEFA Euro 2016)?",
    [a-"Espanha", b-"França", c-"Alemanha", d-"Portugal"],
    d, 7, 4000).

pergunta(8,
    "Em matemática, o número pi é aproximadamente:",
    [a-"2.14", b-"3.14", c-"1.41", d-"1.73"],
    b, 8, 8000).

pergunta(9,
    "Qual destes animais é um mamífero?",
    [a-"Tubarão", b-"Sardinha", c-"Golfinho", d-"Polvo"],
    c, 9, 16000).

pergunta(10,
    "Quem formulou a teoria da relatividade?",
    [a-"Isaac Newton", b-"Albert Einstein", c-"Niels Bohr", d-"Galileu Galilei"],
    b, 10, 32000).

pergunta(11,
    "Em informática, o que significa 'CPU'?",
    [a-"Central Processor Unit", b-"Central Processing Unit", c-"Core Processing Unit", d-"Computer Processing Unit"],
    b, 11, 64000).

pergunta(12,
    "Qual é o elemento químico representado por 'Au'?",
    [a-"Prata", b-"Ouro", c-"Cobre", d-"Alumínio"],
    b, 12, 125000).

pergunta(13,
    "Que oceano é o maior do mundo?",
    [a-"Atlântico", b-"Índico", c-"Pacífico", d-"Ártico"],
    c, 13, 250000).

pergunta(14,
    "Qual destes é um sistema operativo?",
    [a-"Python", b-"Linux", c-"HTML", d-"MySQL"],
    b, 14, 500000).

pergunta(15,
    "Quem pintou a obra 'Guernica'?",
    [a-"Picasso", b-"Van Gogh", c-"Monet", d-"Rembrandt"],
    a, 15, 1000000).

pergunta(16,
    "Que país tem como capital 'Ottawa'?",
    [a-"Austrália", b-"Canadá", c-"Estados Unidos", d-"Nova Zelândia"],
    b, 16, 2000000).

pergunta(17,
    "Na informática, 'RAM' significa:",
    [a-"Random Access Memory", b-"Read Access Memory", c-"Rapid Access Memory", d-"Remote Access Memory"],
    a, 17, 4000000).

pergunta(18,
    "Quem foi o primeiro homem a pisar a Lua?",
    [a-"Yuri Gagarin", b-"Buzz Aldrin", c-"Neil Armstrong", d-"Michael Collins"],
    c, 18, 8000000).

pergunta(19,
    "Em estatística, a média é:",
    [a-"O valor mais frequente", b-"O valor central ordenado", c-"A soma dos valores dividida pelo número de valores", d-"O valor mínimo"],
    c, 19, 16000000).

pergunta(20,
    "Qual destes é um paradigma de programação lógica?",
    [a-"Prolog", b-"C", c-"Java", d-"Fortran"],
    a, 20, 32000000).

% Número total de perguntas
numero_perguntas(20).

% Patamares de segurança (podes ajustar)
patamar(5).
patamar(10).
patamar(15).
