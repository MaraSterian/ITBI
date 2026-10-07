# Laboratorul 5: generarea unei chei SSH și conectarea fără parolă
# Necesită imaginea itbi-demo (vezi tapes/README.md)
# Generare: vhs tapes/ssh-keygen.tape

Output docs/assets/gifs/ssh-keygen.gif

Set Shell bash
Set FontSize 16
Set Width 1000
Set Height 750
Set Padding 20
Set TypingSpeed 60ms
Set Theme "Catppuccin Mocha"

# Server deja cunoscut (prima conectare e arătată în ssh.gif)
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

# Enter la toate întrebările: locația implicită, fără passphrase
Type "ssh-keygen -t ed25519"
Enter
Sleep 1.5s
Enter
Sleep 1s
Enter
Sleep 1s
Enter
Sleep 3s
Type "clear"
Enter

# Copiem cheia publică pe server și o adăugăm în authorized_keys
Type "scp .ssh/id_ed25519.pub server:"
Enter
Sleep 1.5s
Type@150ms "student"
Enter
Sleep 2s
Type "ssh server"
Enter
Sleep 1.5s
Type@150ms "student"
Enter
Sleep 2s
Type "mkdir -p .ssh"
Enter
Sleep 500ms
Type "cat id_ed25519.pub >> .ssh/authorized_keys"
Enter
Sleep 1s
Type "exit"
Enter
Sleep 1.5s

# De acum nu se mai cere parola
Type "ssh server"
Enter
Sleep 3s
Type "exit"
Enter
Sleep 2s

Hide
Type "exit"
Enter
Sleep 1s
Type "docker rm -f itbi-server >/dev/null 2>&1"
Enter
Sleep 1s
