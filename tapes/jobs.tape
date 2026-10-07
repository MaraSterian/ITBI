# Laboratorul 3: job control (&, jobs, Ctrl+Z, fg, bg)
# Necesită imaginea itbi-demo (vezi tapes/README.md)
# Generare: vhs tapes/jobs.tape

Output docs/assets/gifs/jobs.gif

Set Shell bash
Set FontSize 18
Set Width 900
Set Height 700
Set Padding 20
Set TypingSpeed 70ms
Set Theme "Catppuccin Mocha"

Hide
Type "docker run --rm -it --name itbi-jobs -u student -w /home/student itbi-demo bash"
Enter
Sleep 2s
Type "export PS1='$ ' && clear"
Enter
Sleep 500ms
Show

Sleep 500ms

# Două comenzi pornite în background: promptul revine imediat
Type "sleep 60 &"
Enter
Sleep 1s
Type "sleep 45 &"
Enter
Sleep 1s
Type "jobs"
Enter
Sleep 2s

Type "kill %2"
Enter
Sleep 1s
Type "jobs"
Enter
Sleep 2s

# Adus în foreground, promptul nu mai revine până la Ctrl+Z
Type "fg %1"
Enter
Sleep 2.5s
Ctrl+Z
Sleep 1.5s
Type "jobs"
Enter
Sleep 1.5s

# Reluat în background
Type "bg %1"
Enter
Sleep 1.5s
Type "jobs"
Enter
Sleep 2s

Type "fg %1"
Enter
Sleep 2s
Ctrl+C
Sleep 2s

Hide
Type "exit"
Enter
Sleep 1s
