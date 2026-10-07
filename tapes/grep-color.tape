# Laboratorul 2: ce anume găsește grep (potrivirile apar colorate)
# Necesită imaginea itbi-demo (vezi tapes/README.md)
# Generare: vhs tapes/grep-color.tape

Output docs/assets/gifs/grep-color.gif

Set Shell bash
Set FontSize 18
Set Width 900
Set Height 650
Set Padding 20
Set TypingSpeed 60ms
Set Theme "Catppuccin Mocha"

# În Ubuntu, grep colorează implicit potrivirile (alias din ~/.bashrc)
Hide
Type "docker run --rm -it --name itbi-grep -u student -w /home/student itbi-demo bash"
Enter
Sleep 2s
Type `echo -e "words\nrat\nrata\nratat\nratata\nrata tata" > rat && export PS1='$ ' && clear`
Enter
Sleep 500ms
Show

Sleep 500ms
Type "grep at rat"
Enter
Sleep 2s
Type "grep t$ rat"
Enter
Sleep 2s
Type "grep ^w rat"
Enter
Sleep 2s
Type "grep -E 'rata(ta)*' rat"
Enter
Sleep 2.5s
Type "grep -E 'rata(ta)+' rat"
Enter
Sleep 3s

Hide
Type "exit"
Enter
Sleep 1s
