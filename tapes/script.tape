# Laboratorul 4: primul script, de la scriere la rulare (inclusiv Permission denied)
# Necesită imaginea itbi-demo (vezi tapes/README.md)
# Generare: vhs tapes/script.tape

Output docs/assets/gifs/script.gif

Set Shell bash
Set FontSize 18
Set Width 900
Set Height 500
Set Padding 20
Set TypingSpeed 70ms
Set Theme "Catppuccin Mocha"

Hide
Type "docker run --rm -it --name itbi-script -u student -w /home/student itbi-demo bash"
Enter
Sleep 2s
Type "export PS1='$ ' && clear"
Enter
Sleep 500ms
Show

Sleep 500ms
Type "nano salut.sh"
Enter
Sleep 1.5s
Type "#!/bin/bash"
Enter
Enter
Type `echo "Hello scripting world!"`
Enter
Type "exit 0"
Sleep 1s
Ctrl+O
Sleep 800ms
Enter
Sleep 800ms
Ctrl+X
Sleep 1s

# Fișierul nou nu are drept de execuție
Type "./salut.sh"
Enter
Sleep 2s
Type "ls -l salut.sh"
Enter
Sleep 2s
Type "chmod u+x salut.sh"
Enter
Sleep 1s
Type "ls -l salut.sh"
Enter
Sleep 2s
Type "./salut.sh"
Enter
Sleep 3s

Hide
Type "exit"
Enter
Sleep 1s
