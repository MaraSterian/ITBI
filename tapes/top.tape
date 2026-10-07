# Laboratorul 3: top, actualizare în timp real, sortare și ieșire cu q
# Necesită imaginea itbi-demo (vezi tapes/README.md)
# Generare: vhs tapes/top.tape

Output docs/assets/gifs/top.gif

Set Shell bash
Set FontSize 16
Set Width 1000
Set Height 550
Set Padding 20
Set TypingSpeed 80ms
Set Theme "Catppuccin Mocha"

# Câteva procese ca lista să nu fie goală: unul care consumă CPU, altele care dorm
Hide
Type "docker run --rm -it --name itbi-top -u student -w /home/student itbi-demo bash"
Enter
Sleep 2s
Type "(yes > /dev/null &) ; (sleep 1000 &) ; (sleep 2000 &) ; export PS1='$ ' && clear"
Enter
Sleep 1s
Show

Sleep 500ms
Type "top"
Enter

# Valorile se actualizează singure la câteva secunde
Sleep 5s

# M sortează după memorie, P înapoi după CPU
Type "M"
Sleep 3s
Type "P"
Sleep 3s

Type "q"
Sleep 2s

Hide
Type "exit"
Enter
Sleep 1s
Type "docker rm -f itbi-top >/dev/null 2>&1"
Enter
Sleep 1s
