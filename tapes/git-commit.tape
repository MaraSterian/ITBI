# Laboratorul 6: git commit deschide un editor pentru mesaj (și varianta cu -m)
# Necesită imaginea itbi-demo (vezi tapes/README.md)
# Generare: vhs tapes/git-commit.tape

Output docs/assets/gifs/git-commit.gif

Set Shell bash
Set FontSize 16
Set Width 1000
Set Height 600
Set Padding 20
Set TypingSpeed 70ms
Set Theme "Catppuccin Mocha"

# Repository nou, cu datele din exemplul din laborator
Hide
Type "docker run --rm -it --name itbi-git -u student -w /home/student itbi-demo bash"
Enter
Sleep 2s
Type `mkdir testrepo && cd testrepo && git init -q && git config user.name "Alex Alexandrescu" && git config user.email "alex@gmail.com" && echo 'int main(void) { return 0; }' > myfile.c && export PS1='$ ' && clear`
Enter
Sleep 1s
Show

Sleep 500ms
Type "git add myfile.c"
Enter
Sleep 1s
Type "git commit myfile.c"
Enter
Sleep 2.5s

# Editorul (nano în Ubuntu): scriem mesajul pe prima linie, salvăm și ieșim
Type "Primul commit"
Sleep 1.5s
Ctrl+O
Sleep 1s
Enter
Sleep 800ms
Ctrl+X
Sleep 2s

# Mesajul poate fi dat direct cu -m, fără editor
Type `echo '/* comentariu */' >> myfile.c`
Enter
Sleep 800ms
Type `git commit -m "Al doilea commit" myfile.c`
Enter
Sleep 2s
Type "git log --oneline"
Enter
Sleep 3s

Hide
Type "exit"
Enter
Sleep 1s
