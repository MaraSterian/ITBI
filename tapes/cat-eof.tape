# Laboratorul 4: cat > fișier citește până la Ctrl+D
# Necesită imaginea itbi-demo (vezi tapes/README.md)
# Generare: vhs tapes/cat-eof.tape

Output docs/assets/gifs/cat-eof.gif

Set Shell bash
Set FontSize 18
Set Width 900
Set Height 550
Set Padding 20
Set TypingSpeed 70ms
Set Theme "Catppuccin Mocha"

Hide
Type "docker run --rm -it --name itbi-cat -u student -w /home/student itbi-demo bash"
Enter
Sleep 2s
Type "export PS1='$ ' && clear"
Enter
Sleep 500ms
Show

Sleep 500ms
Type "cat > myfor-loop.sh"
Enter
Sleep 1s
Type "#!/bin/bash"
Enter
Type "for i in 1 2 3 4 5"
Enter
Type "do"
Enter
Type `  echo "Iteratia cu numarul $i"`
Enter
Type "done"
Enter
Sleep 2s

# Promptul nu revine: cat așteaptă în continuare text. Ctrl+D încheie intrarea.
Ctrl+D
Sleep 1.5s

Type "chmod u+x myfor-loop.sh"
Enter
Sleep 800ms
Type "./myfor-loop.sh"
Enter
Sleep 3s

Hide
Type "exit"
Enter
Sleep 1s
