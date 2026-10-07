# Laboratorul 1: completarea automată cu Tab
# Generare: vhs tapes/tab.tape

Output docs/assets/gifs/tab.gif

Set Shell bash
Set FontSize 20
Set Width 800
Set Height 300
Set Padding 20
Set TypingSpeed 80ms
Set Theme "Catppuccin Mocha"

# Director temporar cu câteva directoare, ca rezultatul să fie același pe orice sistem
Hide
Type "export PS1='$ ' HISTFILE=/dev/null && cd $(mktemp -d) && mkdir Desktop Documents Downloads && bind 'set bell-style none' && history -c && clear"
Enter
Show

Sleep 500ms

# O singură potrivire: Tab completează direct
Type "cd Doc"
Sleep 800ms
Tab
Sleep 1.5s
Ctrl+C
Sleep 500ms

# Mai multe potriviri: Tab de două ori afișează variantele
Type "cd D"
Sleep 800ms
Tab@600ms 2
Sleep 1.5s
Type "ow"
Sleep 500ms
Tab
Sleep 1s
Enter
Sleep 2s
