# Laboratorul 5: prima conectare prin ssh (amprenta serverului, parola, promptul care se schimbă)
# Necesită imaginea itbi-demo (vezi tapes/README.md)
# Generare: vhs tapes/ssh.tape

Output docs/assets/gifs/ssh.gif

Set Shell bash
Set FontSize 16
Set Width 1000
Set Height 550
Set Padding 20
Set TypingSpeed 70ms
Set Theme "Catppuccin Mocha"

# Două containere în aceeași rețea: "laptop" (aici lucrăm) și "server" (cu sshd pornit)
Hide
Type "docker rm -f itbi-server >/dev/null 2>&1; docker network create itbi >/dev/null 2>&1; docker run -d --rm --name itbi-server --hostname server --network itbi --network-alias server itbi-demo /usr/sbin/sshd -D >/dev/null"
Enter
Sleep 2s
Type "docker run --rm -it --name itbi-laptop --hostname laptop --network itbi -u student -w /home/student itbi-demo bash"
Enter
Sleep 2s
Type "clear"
Enter
Sleep 500ms
Show

Sleep 500ms
Type "ssh server"
Enter
Sleep 2s

# Prima conectare: ssh nu cunoaște încă serverul și cere confirmare
Type "yes"
Sleep 800ms
Enter
Sleep 1.5s

# Parola nu apare pe ecran
Type@150ms "student"
Enter
Sleep 2.5s

# Promptul arată acum mașina de la distanță
Type "hostname"
Enter
Sleep 2s
Type "exit"
Enter
Sleep 1.5s
Type "hostname"
Enter
Sleep 3s

Hide
Type "exit"
Enter
Sleep 1s
Type "docker rm -f itbi-server >/dev/null 2>&1"
Enter
Sleep 1s
