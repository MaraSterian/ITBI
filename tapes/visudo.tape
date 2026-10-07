# Laboratorul 3: editarea /etc/sudoers cu visudo, inclusiv ce se întâmplă la o greșeală
# Necesită imaginea itbi-demo (vezi tapes/README.md)
# Generare: vhs tapes/visudo.tape

Output docs/assets/gifs/visudo.gif

Set Shell bash
Set FontSize 16
Set Width 1000
Set Height 650
Set Padding 20
Set TypingSpeed 60ms
Set Theme "Catppuccin Mocha"

Hide
Type "docker run --rm -it --name itbi-visudo --hostname laptop -u student -w /home/student itbi-demo bash"
Enter
Sleep 2s
Type "clear"
Enter
Sleep 500ms
Show

Sleep 500ms
Type "sudo visudo"
Enter
Sleep 1s
Type@150ms "student"
Enter
Sleep 2s

# La finalul fișierului adăugăm o linie, intenționat greșită (lipsește =)
PageDown@200ms 5
Sleep 800ms
Type "%users ALL /sbin/mount /cdrom"
Sleep 1s
Ctrl+O
Sleep 1s
Enter
Sleep 800ms
Ctrl+X
Sleep 2.5s

# visudo nu salvează un fișier greșit și întreabă ce facem: e = editare din nou
Type "e"
Enter
Sleep 2s
PageDown@200ms 5
Up
Sleep 800ms
Ctrl+K
Sleep 800ms
Type "%users ALL=/sbin/mount /cdrom"
Sleep 1s
Ctrl+O
Sleep 1s
Enter
Sleep 800ms
Ctrl+X
Sleep 2s

Type "sudo tail -n 1 /etc/sudoers"
Enter
Sleep 3s

Hide
Type "exit"
Enter
Sleep 1s
