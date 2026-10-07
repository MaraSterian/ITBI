# Laboratorul 3: parola nu apare pe ecran când o tastați (sudo, passwd)
# Necesită imaginea itbi-demo (vezi tapes/README.md)
# Generare: vhs tapes/password.tape

Output docs/assets/gifs/password.gif

Set Shell bash
Set FontSize 18
Set Width 900
Set Height 400
Set Padding 20
Set TypingSpeed 80ms
Set Theme "Catppuccin Mocha"

# Prompt Ubuntu obișnuit (utilizator@mașină), parola contului este "student"
Hide
Type "docker run --rm -it --name itbi-password --hostname laptop -u student -w /home/student itbi-demo bash"
Enter
Sleep 2s
Type "clear"
Enter
Sleep 500ms
Show

Sleep 500ms
Type "sudo whoami"
Enter
Sleep 1.5s
# Parola se tastează, dar nu apare nimic, nici măcar steluțe
Type@200ms "student"
Sleep 1s
Enter
Sleep 2s

Type "passwd"
Enter
Sleep 1.5s
Type@200ms "student"
Sleep 800ms
Enter
Sleep 1.5s
Type@200ms "Laborator3!"
Sleep 800ms
Enter
Sleep 1.5s
Type@200ms "Laborator3!"
Sleep 800ms
Enter
Sleep 3s

Hide
Type "exit"
Enter
Sleep 1s
