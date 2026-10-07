# Laboratorul 1: Linia de comandă, Sistemul de fișiere

## Ierarhie

În sistemele de operare de tip UNIX fișierele și directoarele sunt organizate într-o structură arborescentă. Rădăcina este notată cu `/` și se mai numește și *root*. În rădăcină se găsesc mai multe directoare și fișiere. La rândul lor, aceste directoare pot conține alte fișiere și directoare. Directoarele dintr-un director se mai numesc și *subdirectoare*, subliniind relația ierarhică.

De exemplu, lista conturilor de utilizator se găsește în fișierul `/etc/passwd`. Acesta se află în directorul `etc`, care se află în rădăcină. Un exemplu cu mai multe niveluri este `/usr/bin/ls`, executabilul comenzii `ls`: fișierul `ls` se află în directorul `bin`, care se află la rândul său în directorul `usr`, care se află în rădăcină.

Un șir precum `/usr/bin/ls` se numește *calea* fișierului: numele directoarelor parcurse pornind de la rădăcină, separate prin `/`. O cale care începe cu `/` este o **cale absolută** și desemnează același fișier indiferent unde vă aflați în sistem. O cale care nu începe cu `/` este o **cale relativă** și este interpretată pornind de la *directorul curent*, adică directorul în care lucrați la un moment dat (vezi secțiunea Navigare). De exemplu, dacă directorul curent este `/usr`, calea relativă `bin/ls` desemnează același fișier ca și calea absolută `/usr/bin/ls`. Dacă însă directorul curent este `/etc`, aceeași cale relativă `bin/ls` desemnează `/etc/bin/ls`, care nu există.

Două nume speciale există în orice director: `.` reprezintă directorul însuși, iar `..` directorul părinte. Astfel, dacă directorul curent este `/usr/bin`, calea `./ls` desemnează `/usr/bin/ls`, iar calea `../lib` desemnează `/usr/lib`.

## Linia de comandă

Majoritatea comenzilor vor fi executate în cadrul unui terminal (ex. xterm(1), GNOME Terminal etc.). Deși dificil și aparent mai complicat la început, folosirea terminalului oferă multe avantaje precum flexibilitate, automatizarea sarcinilor și control la distanță al altor mașini.

Un terminal tipic are la bază un program de tip shell (ex. bash(1), ksh, zsh) care gestionează și execută comenzi secvențial sau în paralel. Promptul unui terminal indică faptul că se așteaptă o comandă de la utilizator și este în cea mai simplă formă constituit din simbolul `$` sau `%` pentru utilizatorii comuni și `#` pentru administrator (denumit *root* în UNIX).

Tot ce este scris în dreapta promptului reprezintă comanda utilizatorului către mașină.

```
$ echo "Hello, World!"
Hello, World!
$
```

În exemplul de mai sus a fost executată comanda `echo` cu parametrul `"Hello, World!"`. Rezultatul comenzii, dacă există, este afișat fără a fi prefixat cu prompt. Încheierea comenzii este semnalată prin reaparitia promptului.

De fiecare dată când vedeți o comandă necunoscută citiți manualul pentru a afla ce face:

```
$ man echo
```

Din motive istorice, manualul sistemului de operare (ce include manualele comenzilor) este împărțit în secțiuni. Astfel pot exista mai multe intrări cu același nume dar în secțiuni diferite. Vezi cunoscuta funcție `printf`.

```
$ man printf
$ man 3 printf
```

Prima instrucțiune s-ar putea să vă surprindă afișând manualul comenzii `printf` nu a funcției C `printf`. Comenzile de terminal se află de regulă în secțiunea 1, pe când funcțiile se află în secțiunea 3. Pentru a accesa manualul funcției trebuie să specificăm un argument în plus comenzii `man`(1) care specifică secțiunea explicit. Din această cauză când ne referim la o comandă sau o funcție punem la sfârșit și secțiunea din manual în care este documentată: `printf`(1) versus `printf`(3). Este bine de știut că există manual și pentru comanda de citit manuale:

```
$ man man
```

În interiorul unei pagini de manual vă deplasați cu săgețile sau cu `Space` (o pagină întreagă), căutați un cuvânt cu `/`, treceți la următoarea potrivire cu `n` și ieșiți cu `q`:

![Navigarea în pagina de manual a comenzii ls](../assets/gifs/man.gif)

## Lucrul eficient în linia de comandă

Câteva combinații de taste vă scutesc de mult timp și de multe greșeli în terminal:

| Tastă | Efect |
|---|---|
| `Tab` | completează numele comenzii sau al fișierului început |
| `↑` / `↓` | parcurge comenzile introduse anterior |
| `Ctrl+C` | întrerupe comanda aflată în execuție |

Când există o singură potrivire, `Tab` completează direct numele. Când există mai multe, apăsați `Tab` de două ori pentru a vedea variantele, apoi mai tastați câteva litere:

![Completarea automată a numelor de directoare cu Tab](../assets/gifs/tab.gif)

Cu `↑` puteți readuce o comandă anterioară și o puteți modifica înainte de a o rula din nou:

![Parcurgerea și modificarea comenzilor anterioare cu săgețile](../assets/gifs/history.gif)

Pentru a exersa `Ctrl+C`, rulați:

```
$ sleep 100
```

Comanda `sleep`(1) așteaptă 100 de secunde fără să afișeze nimic, iar promptul nu reapare până la încheierea ei. Apăsați `Ctrl+C` pentru a o opri și a reveni la prompt. Același lucru îl puteți face cu orice comandă care durează prea mult sau pare blocată.

![Comanda sleep 100 întreruptă cu Ctrl+C](../assets/gifs/ctrl-c.gif)

**Copiere și lipire.** Deoarece `Ctrl+C` întrerupe comenzi, în majoritatea terminalelor copierea și lipirea se fac cu `Ctrl+Shift+C` și `Ctrl+Shift+V`, sau din meniul deschis cu click dreapta. Atenție când copiați comenzi din acest document: simbolul `$` de la începutul liniei este promptul și nu face parte din comandă, iar liniile fără `$` sunt rezultatul afișat de comandă. Copiați doar comanda propriu-zisă.

## Navigare

În general, fiecare utilizator are un spațiu de lucru propriu în care își poate desfășura activitatea. Acest spațiu este găzduit într-un director, de regulă `/home/username`, care este memorat în variabila `$HOME`.

```
$ echo $HOME
/home/horatiu
```

Acest tip de variabilă se mai numește și variabilă de mediu. Ele sunt definite dinamic de sistem sau utilizator pentru a fi folosite de programe la execuție. Variabilele sunt în general scrise cu litere mari și precedate de simbolul `$`.

Shell-ul oferă și o prescurtare pentru directorul `$HOME`: caracterul `~` (tilda). Astfel, `~/Documents` este echivalent cu `$HOME/Documents`, adică `/home/horatiu/Documents` în exemplul de mai sus.

Când este pornit un terminal, acesta de regulă vă plasează în directorul `$HOME`. Folosiți comanda `pwd`(1) pentru a verifica în orice moment unde vă aflați și comanda `ls`(1) pentru a lista conținutul directorului curent.

```
$ pwd
/home/horatiu/Documents/itbi/lab1
$ ls
itbi-lab-1.aux  itbi-lab-1.fdb_latexmk  itbi-lab-1.fls
itbi-lab-1.log  itbi-lab-1.pdf          itbi-lab-1.tex
```

Toate comenzile se execută relativ la directorul curent: `ls`(1) verifică implicit directorul curent și listează conținutul său.

Comportamentul unei comenzi poate fi modificat prin *opțiuni*, care de regulă încep cu `-`. De exemplu, opțiunea `-l` a comenzii `ls`(1) afișează detalii despre fiecare fișier:

```
$ ls -l /etc/passwd
-rw-r--r-- 1 root root 2847 Sep 12 10:31 /etc/passwd
```

Coloanele reprezintă, în ordine: tipul fișierului și permisiunile (discutate într-un laborator viitor), numărul de legături, proprietarul, grupul, dimensiunea în octeți, data ultimei modificări și numele. Primul caracter indică tipul: `-` pentru un fișier obișnuit și `d` pentru un director.

Fișierele și directoarele al căror nume începe cu `.` sunt *ascunse*: `ls`(1) nu le afișează implicit. De regulă acestea sunt fișiere de configurare, precum `~/.bashrc`, pe care shell-ul bash îl citește la pornire. Pentru a le afișa folosiți opțiunea `-a`:

```
$ ls -a ~
.  ..  .bash_history  .bashrc  .profile  Documents
```

Rezultatul diferă de la un sistem la altul. Observați că în listă apar și intrările speciale `.` și `..`, descrise în secțiunea Ierarhie. Opțiunile pot fi și combinate: `ls -la` afișează detaliat toate fișierele, inclusiv pe cele ascunse.

Dacă doriți să schimbați directorul curent folosiți comanda `cd`(1). Aceasta primește ca parametru viitorul director curent. El poate fi dat relativ la directorul curent sau în formă absolută pornind de la rădăcină. Reamintim că `..` desemnează directorul părinte. Deci dacă vrem din exemplul anterior să ajungem acasă putem folosi oricare dintre următoarele comenzi:

```
$ cd ../../../
$ cd /home/horatiu
$ cd $HOME
$ cd ~
$ cd
```

Implicit `cd`(1) fără argumente schimbă directorul în directorul `$HOME`.

Pentru a afla unde se află executabilul aferent unei comenzi folosiți comanda `which`(1):

```
$ which ls
/usr/bin/ls
```

O altă variabilă importantă este cea în care sunt memorate căile din sistemul de fișiere în care se găsesc executabilele.

```
$ echo $PATH
/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin
```

În general, comanda pentru a rula un executabil este dată de calea (fie absolută, fie relativă la directorul curent) către acesta.

Calea absolută:

```
$ /path/to/executable
```

Calea relativă:

```
$ ./path/to/executable
```

Observați că `ls`(1) se află într-unul din directoarele conținute în `$PATH`, motiv pentru care nu este nevoie să specificăm întreaga cale. Pentru a adăuga directoarele la `$PATH` se poate folosi comanda

```
$ export PATH=$PATH:/path/to/directory
```

pentru adăugare la final, sau

```
$ export PATH=/path/to/directory:$PATH
```

pentru adăugare la început.

Spre exemplu, după

```
$ export PATH=$PATH:/home/horatiu/itbi/bin
```

toate executabilele din `/home/horatiu/itbi/bin` vor putea fi apelate drept comenzi cu numele lor.

## Editarea textului în linia de comandă

Pentru editarea fișierelor din linia de comandă sunt disponibile diverse editoare fără interfață grafică, precum `nano(1)` sau `vi(1)`.

```
$ nano main.cpp
```

În `nano`(1) scrieți direct textul, salvați cu `Ctrl+O` (confirmați numele fișierului cu `Enter`) și ieșiți cu `Ctrl+X`. Scurtăturile principale sunt afișate în partea de jos a ecranului, unde `^` înseamnă tasta `Ctrl`.

![Editarea, salvarea și închiderea unui fișier în nano](../assets/gifs/nano.gif)

Un avantaj al acestora este că pot fi utilizate inclusiv pe sisteme care nu pun la dispoziție o interfață grafică. Desigur, multe distribuții vin cu editoare grafice instalate, precum `gedit` sau `kate`, care pot fi apelate într-o manieră similară.

```
$ gedit main.cpp
```

## Citire și scriere

Pentru a crea fișiere noi text se poate folosi `echo`(1):

```
$ echo "lorem ipsum" > foo
```

unde operatorul `>` redirecționează ieșirea comenzii către fișierul `foo`. Dacă `foo` există, va fi suprascris. Pentru a adăuga la sfârșitul unui fișier existent folosiți `>>`. Fișierele text scurte pot fi rapid afișate în terminal cu ajutorul comenzii `cat`(1).

```
$ cat foo
lorem ipsum
```

Deși se poate aplica aceeași comandă asupra fișierelor binare, precum executabilele, nu este recomandat deoarece anumite "caractere" rezultate pot fi interpretate de shell drept caractere de control care vor da peste cap funcționarea normală a terminalului.

Atunci când ieșirea unei comenzi este prea lungă și depășește lungimea terminalului, pentru a parcurge toată informația se recomandă folosirea unui *pager* precum `less`(1):

```
$ ls -l /usr/bin | less
```

unde operatorul `|` se numește *pipe*. Un *pipe* transformă ieșirea programului din stânga în intrarea celui din dreapta. Pentru a ieși din `less`(1) apăsați tasta `q`. Pentru a căuta un text folosiți comanda `/`. De exemplu `/print` va căuta șirul de caractere `print`. Evident, `less`(1) poate fi folosit direct pentru a inspecta fișiere și este util mai ales pentru fișiere text mari:

```
$ less /etc/passwd
```

## Manipulare

Directoarele sunt create cu comanda `mkdir`(1):

```
$ pwd
/home/horatiu/Documents/itbi
$ mkdir tmp
$ cd tmp
```

Pentru a crea fișiere noi lipsite de conținut folosiți comanda `touch`(1).

```
$ touch foo
$ ls
foo
```

Operarea de copiere se face cu comanda `cp`(1):

```
$ cp foo bar
$ ls
bar  foo
```

iar cea de mutare cu comanda `mv`(1):

```
$ mv bar baz
$ ls
baz  foo
```

Fișierele se șterg cu comanda `rm`(1), iar directoarele goale cu comanda `rmdir`(1):

```
$ pwd
/home/horatiu/wrk/ub/itbi/lab/1/tmp
$ ls
baz  foo
$ rm baz foo
$ ls
$ cd ..
$ rmdir tmp
```

## Sarcini de laborator

1.  Rulați toate comenzile descrise în laborator

2.  Refaceți următoarea ierarhie de directoare și fișiere folosind comenzile `mkdir`(1) și `touch`(1):

    ```
    itbi
    |-- curs
    |   `-- 1
    |       |-- itbi-curs-1.pdf
    |       `-- itbi-curs-1.tex
    `-- lab
        `-- 1
            |-- itbi-lab-1.pdf
            `-- itbi-lab-1.tex
    ```

3.  Creați un director și câteva fișiere în acesta. Încercați să ștergeți directorul creat folosind `rm` sau `rmdir`. Ce observați? Căutați în manualul `rm`(1) cum să ștergeți recursiv și folosiți informația pentru a șterge într-o singură instrucțiune directorul creat devreme.

4.  Creați un director `bin` în `$HOME` și adăugați-l în `$PATH`. Copiați un executabil existent (de exemplu `gcc`) și observați cum/dacă se modifică ieșirea comenzii `which`(1) când întrebați de executabilul copiat. Dacă nu se schimbă, de ce?

