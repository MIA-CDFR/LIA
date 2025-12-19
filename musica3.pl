:- use_module(library(process)).

tocar_mp3 :-
    process_create(
        'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe',
        ['-STA',
         '-NoProfile',
         '-Command',
         'Add-Type -AssemblyName presentationCore; $p = New-Object System.Windows.Media.MediaPlayer; $p.Open([uri]"""file:///D:/MIA_prolog/milionario1/sons/begin.mp3"""); $p.Play(); Start-Sleep -Seconds 5'],
         [detached(true)]).


tocar_mp3_2(Ficheiro) :-
    process_create(
        './ffmpeg/bin/ffplay.exe',
        ['-nodisp',
         '-autoexit',
         '-loglevel', 'quiet',
         '-hide_banner',
         '-nostats',        
         Ficheiro],
        [detached(true)]).


:- dynamic musica_pid/1.

tocar_mp3_3(Ficheiro) :-
    process_create(
        './ffmpeg/bin/ffplay.exe',
        ['-nodisp','-loop','0','-loglevel','quiet',Ficheiro],
        [ process(PID),
          detached(true),
          stdout(null),
          stderr(null)
        ]),
    asserta(musica_pid(PID)).

parar_mp3 :-
    musica_pid(PID),
    process_kill(PID),
    retractall(musica_pid(_)).