# Laboratorul 1: navigarea într-o pagină de manual
# Generare: vhs tapes/man.tape

Output docs/assets/gifs/man.gif

Set Shell bash
Set FontSize 18
Set Width 900
Set Height 550
Set Padding 20
Set TypingSpeed 80ms
Set Theme "Catppuccin Mocha"

# Pager implicit (less), indiferent de configurația locală
Hide
Type "export PS1='$ ' HISTFILE=/dev/null MANPAGER=less LESS= && history -c && clear"
Enter
Show

Sleep 500ms
Type "man ls"
Sleep 500ms
Enter
Sleep 2s

# Derulare cu săgeata jos, apoi o pagină întreagă cu Space
Down@200ms 6
Sleep 800ms
Space
Sleep 1.5s

# Căutare cu / și salt la următoarea potrivire cu n
Type "/sort"
Sleep 800ms
Enter
Sleep 1.5s
Type "n"
Sleep 1.5s
Type "n"
Sleep 1.5s

# Ieșire cu q
Type "q"
Sleep 2s
