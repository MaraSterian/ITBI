# Laboratorul 2: Căutare, liste de comenzi, compilare

## Căutarea

Căutarea unui fragment de text într-un fișier se poate face folosind expresii regulate în cadrul comenzii `grep`(1). Fie următorul fișier text:

```
$ echo -e "words\nrat\nrata\nratat\nratata\nrata tata" > rat
```

unde `\n` reprezintă o linie nouă (ca în limbajul C). Pentru a găsi cuvintele ce conțin `at` în fișier folosim comanda:

```
$ grep at rat
rat
rata
ratat
ratata
rata tata
```

Dacă vrem să găsim cuvintele care se termină în litera `t` atunci vom folosi comanda:

```
$ grep t$ rat
rat
ratat
```

unde caracterul `$` simbolizează sfârșitul liniei. Pentru începutul liniei se folosește `^`:

```
$ grep ^w rat
words
```

Alte caractere speciale utile, numite *wildcards*, sunt:

- `*` – găsește de 0 sau mai multe ori atomul precedent
- `+` – găsește de 1 sau mai multe ori atomul precedent
- `?` – găsește de 0 sau 1 ori atomul precedent

unde un *atom* este implicit caracterul precedent sau grupul precedent de caractere. Gruparea mai multor caractere se face cu ajutorul parantezelor rotunde `()`. În exemplul nostru putem căuta toate cuvintele care încep cu `rata` și sunt urmate de `ta` de 0 sau mai multe ori astfel:

```
$ grep -E 'rata(ta)*' rat
rata
ratat
ratata
rata tata
$ grep -E 'rata(ta)+' rat
ratata
$ grep -E 'rata(ta)?' rat
rata
ratat
ratata
rata tata
```

Observați că am folosit parantezele pentru grupare și opțiunea `-E` pentru a folosi expresii regulate.

În Ubuntu, `grep`(1) colorează partea din fiecare linie care se potrivește cu expresia, așa că puteți vedea exact ce a găsit:

![Potrivirile găsite de grep, evidențiate cu culoare](../assets/gifs/grep-color.gif)

## Liste de comenzi

Așa cum s-a menționat la curs, o listă de comenzi care se execută secvențial poate fi tipărită pe o singură linie la promptul shell de maniera următoare:

- `cmd1; cmd2; cmd3; ...` – se execută mai întâi `cmd1`, după ce se termină `cmd1` se execută `cmd2`, ș.a.m.d.

Iată un exemplu concret:

```
$ echo -n "prima lista de comenzi a utilizatorului "; whoami; ls -l
```

În comanda de mai sus (o listă de comenzi este până la urmă și ea o comandă), `echo -n` suprimă afișarea caracterului *newline*.

### Expresii logice

Toate shell-urile POSIX oferă acces la expresii logice pentru a procesa și lega diferite comenzi. Expresiile logice primare de tip *și*/*sau* au aceeași sintaxă ca în limbajul C: `&&`, respectiv `||`.

Comenzile efectuate în shell se execută cu succes sau nu și întorc o valoare pentru a semnala acest lucru. Valoarea întoarsă și semnificația ei este documentată în manual. În general o valoare nulă semnifică succes și una nenulă eșec. Din această cauză modul de operare al expresiilor logice este pe dos:

- `cmd1 && cmd2` – execută `cmd2` doar dacă ieșirea lui `cmd1` este zero;
- `cmd1 || cmd2` – execută `cmd2` doar dacă ieșirea lui `cmd1` este nenulă.

Valoarea întoarsă de ultima comandă executată este salvată în variabila `$?`. În următorul exemplu, întâi creăm un fișier nou `animals.txt` în care punem cuvântul `cat`, după care căutăm pe rând cuvintele `cat` și `dog` în acest fișier. Prima dată căutarea se întoarce cu succes (zero), iar a doua oară fără niciun rezultat deci cu valoare nenulă (unu).

```
$ echo cat > animals.txt
$ grep cat animals.txt
cat
$ echo $?
0
$ grep dog animals.txt
$ echo $?
1
```

În funcție de ieșire se iau diferite decizii. De exemplu, fie fișierul `agenda.txt` în care se găsesc datele de contact ale diferitor persoane. Pentru a căuta dacă o anumită persoană există în agendă se poate folosi comanda `grep`(1):

```
$ echo Ana > agenda.txt
$ grep Ana agenda.txt
Ana
$ grep Mara agenda.txt
```

La finalul execuției comenzii `grep`(1) aceasta iese fie cu valoarea 0, dacă s-au găsit una sau mai multe intrări, sau 1 dacă nu s-a găsit nimic. Pentru a obține un verdict mai prietenos putem folosi expresia logică *sau*:

```
$ echo Ana > agenda.txt
$ grep Ana agenda.txt || echo "Persoana nu exista!"
Ana
$ grep Mara agenda.txt || echo "Persoana nu exista!"
Persoana nu exista!
```

Dacă nu ne amintim dacă am trecut-o pe Ana-Maria drept Ana sau Maria în agendă, putem de asemenea folosi expresii logice pentru a căuta după Maria în caz că Ana nu există:

```
$ echo Maria > agenda.txt
$ grep Ana agenda.txt || grep Maria agenda.txt
Maria
```

## Compilarea programelor C

### Compilarea și executarea unui program C

În sistemele de operare de tip UNIX, compilatorul de C este invocat prin comanda `cc`(1) (scurt de la *C compiler*). Acesta așteaptă ca argumente fișierele sursă și, opțional, numele executabilului rezultat în urma compilării. În Linux, compilatorul uzual de C este varianta GNU, iar compilatorul se numește `gcc`.

```
$ cc hello.c -o hello
```

În comanda de sus, compilatorul primește fișierul C `hello.c` și numele executabilului `hello` transmis prin opțiunea `-o` (de la *output*). Atenție, dacă omiteți specificarea unui nume pentru executabil acesta va fi implicit denumit `a.out` din motive istorice.

Pentru a executa binarul rezultat se folosește comanda:

```
$ ./hello
Hello, World!
```

unde `hello` este numele executabilului, iar `./` spune shell-ului să nu caute executabilul în `$PATH` pentru că se află în directorul curent.

![Compilarea programului hello.c și rularea lui, cu și fără ./](../assets/gifs/compile.gif)

Formatul cel mai general al funcției `main` conține în semnătura funcției numărul argumentelor din linia de comandă (`argc`), un vector de stringuri care conține argumentele propriu-zise din linia de comandă (`argv`), și respectiv mediul de execuție reprezentat ca un vector de stringuri (`envp`). Fiecare element al vectorului care reprezintă mediul de execuție are forma discutată `nume=valoare`. Aceasta este modalitatea prin care shell-ul comunică mediul de execuție comenzilor pe care le lansează și care astfel pot folosi valorile variabilelor de mediu pentru a-și adapta comportamentul la mediul de execuție.

Compilați și executați similar cu programul `hello.c` de mai sus programul `printenv.c` de mai jos, care tipărește prima variabilă de mediu din listă.

```c
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[], char *envp[])
{
  printf("Prima variabila de mediu este %s\n", envp[0]);
  exit(0);
}
```

**Obs:** Așa cum am menționat anterior, fiecare comandă (program executabil) Unix întoarce un cod de retur folosit așa cum am văzut în comenzi condiționale, de pildă. Convenția Unix este că orice program care întoarce cod de retur 0 s-a terminat cu succes, în vreme ce un cod nenul (uzual pozitiv) desemnează o condiție de eroare. Din acest motiv, este o bună practică de programare să încheiați programele folosind apelul `exit` care este responsabil pentru a comunica acest cod de retur, care e returnat de către shell prin evaluarea variabilei `$?`.

## Sarcini de laborator

1.  Utilitarul `wc`(1), cu opțiunea `-l` va afișa numărul de linii al fișierului (sau fișierelor) primit ca argument.

    ```
    $ wc -l curs1.tex
    300 Curs1/curs1.tex
    ```

    Să presupunem că am vrea să efectuăm această operație pentru toate fișierele cu o anumită proprietate. Încercăm acest lucru în două moduri, dintre care doar al doilea funcționează:

    ```
    $ find . -name "*.tex" | wc -l
    3
    $ find . -name "*.tex" | xargs wc -l
      300 ./Curs1/curs1.tex
      255 ./Curs2/curs2.tex
       84 ./Curs0/curs0.tex
      639 total
    ```

    Citiți documentația pentru `xargs`(1) și încercați să explicați comportamentul diferit al celor două comenzi de mai sus.

2.  Creați un director `logs` și câteva fișiere în acesta. În unele (nu toate) dintre acestea, adăugați textul `error`. Folosind `grep`(1) și `rm`, ștergeți toate fișierele care conțin textul `error`.

3.  Creați două directoare `orig` și `backup`. În directorul `orig` creați fișierele `foo`, `bar`, `baz`. Folosiți comanda `find`(1) să copiați toate fișierele din `orig` în `backup` dar cu extensia `.orig` în plus (ex. `foo.orig`).

4.  Modificați programul `hello` să citească un nume cu `scanf` (ex. `Alex`) pe care să-l salute pe urmă cu ajutorul funcției `printf` (ex. `"Hello, Alex!"`). Compilați și executați. Încercați să combinați programul vostru cu un *pipe*.

5.  Modificați programul `printenv` de mai sus astfel încât să tipărească toate variabilele de mediu (N.B. vectorul `envp` se termină cu `NULL`). Compilați și executați.

6.  Creați un director `bin` în care copiați executabilul `hello`. Adăugați directorul `bin` (folosind calea absolută) în variabila `$PATH` și arătați că puteți executa simplu cu comanda `hello` fără a avea nevoie de prefixul `./`.
