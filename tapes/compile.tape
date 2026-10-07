# Laboratorul 2: compilarea și rularea unui program C
# Necesită imaginea itbi-demo (vezi tapes/README.md)
# Generare: vhs tapes/compile.tape

Output docs/assets/gifs/compile.gif

Set Shell bash
Set FontSize 18
Set Width 900
Set Height 450
Set Padding 20
Set TypingSpeed 70ms
Set Theme "Catppuccin Mocha"

Hide
Type "docker run --rm -it --name itbi-compile -u student -w /home/student itbi-demo bash"
Enter
Sleep 2s
Type `printf '#include <stdio.h>\n\nint main(void)\n{\n  printf("Hello, World!\\n");\n  return 0;\n}\n' > hello.c && export PS1='$ ' && clear`
Enter
Sleep 500ms
Show

Sleep 500ms
Type "cat hello.c"
Enter
Sleep 2s
Type "cc hello.c -o hello"
Enter
Sleep 1.5s
Type "ls"
Enter
Sleep 1.5s

# Fără ./ shell-ul caută executabilul în $PATH și nu îl găsește
Type "hello"
Enter
Sleep 2s
Type "./hello"
Enter
Sleep 2.5s

Hide
Type "exit"
Enter
Sleep 1s
