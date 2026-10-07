# Laboratorul 5: screen, detașarea (Ctrl+A D) și reatașarea unei comenzi
# Necesită imaginea itbi-demo (vezi tapes/README.md)
# Generare: vhs tapes/screen.tape

Output docs/assets/gifs/screen.gif

Set Shell bash
Set FontSize 16
Set Width 1000
Set Height 450
Set Padding 20
Set TypingSpeed 70ms
Set Theme "Catppuccin Mocha"

Hide
Type "docker rm -f itbi-server >/dev/null 2>&1; docker network create itbi >/dev/null 2>&1; docker run -d --rm --name itbi-server --hostname server --network itbi --network-alias server itbi-demo /usr/sbin/sshd -D >/dev/null"
Enter
Sleep 2s
Type "docker run --rm -it --name itbi-laptop --hostname laptop --network itbi -u student -w /home/student itbi-demo bash"
Enter
Sleep 2s
Type "mkdir -p ~/.ssh && ssh-keyscan server > ~/.ssh/known_hosts 2>/dev/null; clear"
Enter
Sleep 1s
Show

Sleep 500ms
# În laborator se folosește sleep 300; aici ping, ca să se vadă că rulează în continuare
Type "screen ssh server ping localhost"
Enter
Sleep 2s
Type@150ms "student"
Enter
Sleep 4s

# Ctrl+A, apoi d: comanda continuă să ruleze, dar promptul revine
Ctrl+A
Sleep 300ms
Type "d"
Sleep 2s

Type "screen -ls"
Enter
Sleep 4s

# Reatașare: ping a continuat cât timp sesiunea a fost detașată
Type "screen -r"
Enter
Sleep 3s
Ctrl+C
Sleep 3s

Hide
Type "exit"
Enter
Sleep 1s
Type "docker rm -f itbi-server >/dev/null 2>&1"
Enter
Sleep 1s
