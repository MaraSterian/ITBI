# Laboratorul 4: promptul de continuare > (ghilimele neînchise, \ la final de linie)
# Necesită imaginea itbi-demo (vezi tapes/README.md)
# Generare: vhs tapes/continuation.tape

Output docs/assets/gifs/continuation.gif

Set Shell bash
Set FontSize 18
Set Width 900
Set Height 450
Set Padding 20
Set TypingSpeed 70ms
Set Theme "Catppuccin Mocha"

Hide
Type "docker run --rm -it --name itbi-continuation -u student -w /home/student itbi-demo bash"
Enter
Sleep 2s
Type "export PS1='$ ' && clear"
Enter
Sleep 500ms
Show

Sleep 500ms

# Ghilimele neînchise: shell-ul așteaptă continuarea, orice comandă pare ignorată
Type `echo "Hello World`
Enter
Sleep 1.5s
Type "ls"
Enter
Sleep 1.5s
Type "pwd"
Enter
Sleep 2s

# Ctrl+C renunță la comanda neterminată
Ctrl+C
Sleep 1.5s

# Folosit intenționat: \ continuă comanda pe linia următoare
Type `[ -f /etc/passwd ] && \`
Enter
Sleep 1s
Type `echo "Fisierul exista"`
Enter
Sleep 3s

Hide
Type "exit"
Enter
Sleep 1s
