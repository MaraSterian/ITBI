# Laboratorul 1: istoricul comenzilor cu săgețile sus/jos
# Generare: vhs tapes/history.tape

Output docs/assets/gifs/history.gif

Set Shell bash
Set FontSize 20
Set Width 800
Set Height 350
Set Padding 20
Set TypingSpeed 80ms
Set Theme "Catppuccin Mocha"

# Istoric gol, ca săgeata sus să găsească doar comenzile din clip
Hide
Type "export PS1='$ ' HISTFILE=/dev/null && cd $(mktemp -d) && history -c && clear"
Enter
Show

Sleep 500ms
Type "ls -l /etc/passwd"
Enter
Sleep 1s
Type "pwd"
Enter
Sleep 1s

# Parcurgem istoricul înapoi și înainte
Up
Sleep 1s
Up
Sleep 1s
Down
Sleep 1s
Up
Sleep 1s

# Modificăm comanda recuperată înainte de a o rula
Backspace@100ms 6
Type "hostname"
Sleep 800ms
Enter
Sleep 2s
