# Laboratorul 1: oprirea unei comenzi cu Ctrl+C
# Generare: vhs tapes/ctrl-c.tape

Output docs/assets/gifs/ctrl-c.gif

Set Shell bash
Set FontSize 20
Set Width 800
Set Height 300
Set Padding 20
Set TypingSpeed 80ms
Set Theme "Catppuccin Mocha"

# Prompt simplu "$ ", ca în exemplele din laborator
Hide
Type "export PS1='$ ' && clear"
Enter
Show

Sleep 500ms
Type "sleep 100"
Sleep 500ms
Enter
Sleep 3s
Ctrl+C
Sleep 2s
