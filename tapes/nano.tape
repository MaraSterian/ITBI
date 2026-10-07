# Laboratorul 1: editarea, salvarea și ieșirea din nano
# Generare: vhs tapes/nano.tape

Output docs/assets/gifs/nano.gif

Set Shell bash
Set FontSize 18
Set Width 900
Set Height 450
Set Padding 20
Set TypingSpeed 80ms
Set Theme "Catppuccin Mocha"

Hide
Type "export PS1='$ ' HISTFILE=/dev/null && cd $(mktemp -d) && history -c && clear"
Enter
Show

Sleep 500ms
Type "nano notite.txt"
Sleep 500ms
Enter
Sleep 1.5s

Type "Primul meu fisier editat in terminal."
Enter
Type "Ctrl+O salveaza, Ctrl+X iese."
Sleep 1s

# Salvare: Ctrl+O, apoi Enter pentru a confirma numele fișierului
Ctrl+O
Sleep 1.5s
Enter
Sleep 1.5s

# Ieșire: Ctrl+X
Ctrl+X
Sleep 1s

Type "cat notite.txt"
Sleep 500ms
Enter
Sleep 2.5s
