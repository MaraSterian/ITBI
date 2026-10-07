# Laboratorul 4: Programarea shell

Shell-ul poate fi folosit și pentru a interpreta conținutul unor fișiere care conțin comenzi și a le executa. Aceste fișiere de comenzi poartă numele de *scripturi*. Ele pot fi văzute ca programe executabile în format text. Pentru acest lucru, este necesar ca fișierul script, `myscript` în exemplul de mai jos, să aibă permisiuni de execuție setate cel puțin pentru proprietarul fișierului:

```
$ chmod u+x myscript
```

Ulterior adăugării permisiunilor de execuție, fișierul script se poate executa ca orice fișier executabil compilat, de ex., considerând fișierul `myscript` de mai sus:

```
$ ./myscript
```

În general, pentru a preciza foarte exact pentru ce tip de shell (sau de interpretor, în sensul cel mai general) este potrivit scriptul, în mod uzual prima linie din fișierul script are o sintaxă specială prin care specifică programul care va interpreta scriptul. Această primă linie instruiește shell-ul ce interpretor de comenzi să lanseze în execuție pentru a interpreta și executa comenzile din script. De exemplu, un shell `bash` poate lansa în execuție un fișier script căruia i s-au dat drepturi de execuție ca mai sus și care conține următoarele comenzi:

```bash
#!/bin/bash

echo "Hello scripting world!"
exit 0
```

Prima linie este un comentariu (începe cu caracterul `#`) special (imediat după `#` urmează `!`) și care specifică interpretorul de comenzi (`/bin/bash`) care este folosit pentru a interpreta și executa comenzile care urmează. Ultima linie care apelează comanda `exit` cu parametrul `0` evidențiază o bună practică în programarea Unix în general (și shell scripting-ul nu face excepție) prin care se comunică procesului părinte (shell-ul care a lansat în execuție scriptul de mai sus în cazul nostru) codul de terminare al programului (al scriptului în cazul de mai sus). Convenția Unix spune că orice program care se termină fără eroare întoarce un cod `0`. Orice altă valoare de retur reprezintă a priori o terminare eronată a programului.

În cazul cel mai general, prima linie din script poate desemna orice tip de interpretor care, desigur, va fi folosit pentru a interpreta comenzile care urmează în script. Iată un script `awk`, care poate fi lansat și el în execuție de către orice alt interpretor de comenzi, inclusiv `bash`, și care tipărește argumentele primite de script în linia de comandă:

```awk
#!/usr/bin/awk -f

BEGIN {
  for (i = 0; i < ARGC; i++)
    printf "ARGV[%d] = %s\n", i, ARGV[i]
  exit
}
```

După cum se observă, `awk` este practic un limbaj de programare cu structură apropiată de limbajele de programare compilate.

De fapt, toate interpretoarele de comenzi au și propriul limbaj de programare, cu propria sintaxă și propriile comenzi. În cele ce urmează, vor fi prezentate principalele „instrucțiuni” pe care le înțelege Bourne Again Shell: loop-uri (`while`/`for`), instrucțiuni condiționale (`if`/`case`) și funcții.

## Test

Operația de test uzual folosită în instrucțiuni condiționale sau iterative este implementată de `bash` cu ajutorul comenzii interne `test` sau `[`. Pentru a verifica că `[` este de fapt o comandă puteți folosi comanda internă `type`:

```
$ type test
test is a shell builtin
$ type [
[ is a shell builtin
$ type type
type is a shell builtin
$
```

Fiind un program ca oricare altul, `[` are nevoie de spații în jurul său. De pildă, expresia `[$myvar = "somestring"]` va genera o eroare de sintaxă fiind interpretată drept `test$myvar = "somestring"]`. Versiunea corectă a comenzii anterioare este `[ $myvar = "somestring" ]`.

Comanda `test` este extrem de complexă și poate testa stringuri, numere, fișiere. Pentru o imagine comprehensivă, consultați pagina de manual. În cele ce urmează vom evidenția câteva dintre utilizările des întâlnite ale comenzii, apelând la comenzile condiționale puse la dispoziție de către shell. În secțiunile următoare vom vedea cum poate fi folosită comanda `test` împreună cu instrucțiuni condiționale și iterative.

Pentru exemplele care urmează vom folosi o variabilă shell `X` căreia i se vor asigna valori diverse și o vom folosi împreună cu comanda `test`. Pentru lizibilitate vom folosi caracterul `\` care permite extensia unei singure linii de comandă pe linia următoare (atât interactiv, la promptul shell-ului, cât și în scripturi). În mod interactiv, utilizarea `\` implică automat apariția promptului de continuare `>` stocat în variabila de mediu `PS2`.

```
$ X=4
$ [ "$X" -lt "0" ] && echo "X is less than zero" \
> || echo "X is greater than zero"
X is greater than zero

$ X=-1
$ [ "$X" -lt "0" ] && echo "X is less than zero" \
> || echo "X is greater than zero"
X is less than zero

$ X=0
$ [ "$X" = "0" ] && \
> echo "X is the string or number \"0\""
X is the string or number "0"

$ X=hello
$ [ "$X" = "hello" ] && \
> echo "X matches the string \"hello\""
X matches the string "hello"

$ X="not hello"
$ [ "$X" != "hello" ] && echo "X is not the string \"hello\""
X is not the string "hello"

$ echo $X
not hello
$ [ -n "$X" ] && echo "X is of nonzero length"
X is of nonzero length

$ X=somefile
$ [ -f "$X" ] && \
> echo "X is the path of a real file" || \
> echo "No such file: $X"
No such file: somefile

$ X=/etc/passwd
$ [ -f "$X" ] && \
> echo "X is the path of a real file" || \
> echo "No such file: $X"
X is the path of a real file

$ X=/bin/ls
$ [ -x "$X" ] && echo "X is the path of an executable file"
X is the path of an executable file

$ X=.
$ [ "$X" -nt "/etc/passwd" ] && \
> echo "X is a file which is newer than /etc/passwd"
X is a file which is newer than /etc/passwd
$
```

```
$ X=hello
$ [ -n "$X" ] && echo "$X is a non-zero string" \
> || echo "$X is the null string"
hello is a non-zero string

$ Y=bye
$ [ $X != $Y ] && echo "$X is not equal to $Y" \
> || echo "$X is equal to $Y"
hello is not equal to bye
$
```

Expresiile supuse comenzii `test` pot fi compuse cu ajutorul operatorilor logici: negație, conjuncție și disjuncție.

```
$ echo $X
hello
$ [ ! "$X" = "" ] && echo "$X is not an empty string" \
> || echo "$X is the empty string"
hello is not an empty string

$ echo $X $Y
hello bye
$ [ "$X" = "hello" -a "$Y" = "bye" ] && \
> echo "Proper greetings have been made" \
> || echo "This is not quite polite"
Proper greetings have been made

$ Y=notbye
$ echo $X $Y
hello notbye
$ [ "$X" != "hello" -o "$Y" != "bye" ] && \
> echo "This is not quite polite" \
> || echo "Politeness has been satisfied"
This is not quite polite
$
```

## Instrucțiunile de tip If și Case

Instrucțiunile condiționale de tip `if` din shell arată în felul următor:

```bash
if [ ... ]
then
  # if-code
else
  # else-code
fi
```

Observați poziția cuvintelor cheie `then`, `else` și respectiv `fi`. Ele trebuie să apară singure pe o linie chiar la începutul ei. Pentru a face economie de spațiu, se poate folosi caracterul `;` care permite unirea a două linii consecutive pe aceeași linie:

```bash
if [ ... ]; then
  # if-code
else
  # else-code
fi
```

Mai multe `if`-uri se pot îmbrica folosind instrucțiunea `elif`, ca în scriptul următor, pe care îl puteți salva în fișierul `if.sh` (atât pentru acest script cât și pentru toate cele care urmează, nu uitați să setați permisiunea de execuție înainte de a rula scriptul):

```bash
#!/bin/bash

read filename
if [ ! -e "$filename" ]; then
  echo "$filename does not exist"
elif [ -f "$filename" ]; then
  echo "$filename is a regular file"
else
  echo "$filename exists, but we don't know what kind of file it is"
fi
```

Rularea scriptului evidențiază funcționalitatea instrucțiunii `if`:

```
$ ./if.sh
somefile
somefile does not exist
$ ./if.sh
/etc/passwd
/etc/passwd is a regular file
$ ./if.sh
/etc
/etc exists, but we don't know what kind of file it is
$
```

Pentru a face scriptul de mai sus ceva mai complet se poate folosi instrucțiunea `case`, ca în scriptul de mai jos pe care îl vom denumi `case.sh`:

```bash
#!/bin/bash

echo -n "Please input a filename: "
read filename
longformat=`ls -ld $filename 2>/dev/null`
case "${longformat:0:1}" in
  -)
    echo "$filename is a regular file"
    ;;
  d)
    echo "$filename is a directory"
    ;;
  b)
    echo "$filename is a block file"
    ;;
  c)
    echo "$filename is a character file"
    ;;
  *)
    echo "Sorry, I don't know anything about $filename"
    ;;
esac
```

Rememorați din laboratoarele anterioare că orice comandă care apare între *backquotes* (`` ` ``) este înlocuită cu un string care reprezintă rezultatul execuției comenzii dintre *backquotes*. Redirecționarea `stderr` reprezentată prin descriptorul de fișier `2` este necesară pentru a trata situația în care numele fișierului introdus de la tastatură nu corespunde unui fișier existent. `/dev/null` este un fișier de tip caracter cu un comportament special în sistem: orice scriere la `/dev/null` se pierde, iar de la `/dev/null` nu se poate citi nimic. Pe cale de consecință, redirecționarea `stderr` la `/dev/null` are ca efect eliminarea mesajului de eroare generat de comanda `ls -l` atunci când numele de fișier citit de la tastatură nu corespunde unui fișier existent în sistem.

Așa cum am menționat la curs, listarea în format lung a atributelor unui fișier are ca efect, printre altele, tipărirea pe ecran ca prim caracter a tipului fișierului. Pentru a izola acest caracter în cadrul stringului generat de comanda `ls -l` se folosește sintaxa `${nume_variabila:offset:length}` care permite obținerea unui substring al variabilei `nume_variabila` care începe la poziția `offset` și are lungimea `length`.

Rezultatele rulării scriptului de mai sus arată de maniera următoare:

```
$ ./case.sh
Please input a filename: /etc
/etc is a directory
$ ./case.sh
Please input a filename: /etc/passwd
/etc/passwd is a regular file
$ ./case.sh
Please input a filename: /dev/tty1
/dev/tty1 is a character file
$ ./case.sh
Please input a filename: /dev/sda1
/dev/sda1 is a block file
$ ./case.sh
Please input a filename: somefile
Sorry, I don't know anything about somefile
$
```

## Instrucțiuni iterative

Limbajele interpretate oferă și funcționalitate de tipul instrucțiunilor iterative, a instrucțiunilor executate repetitiv într-o buclă. Principalele construcții sintactice pe care le oferă `bash` pentru implementarea buclelor sunt instrucțiunile `for` și `while`.

### For loops

Instrucțiunile de tip `for` iterează printr-o listă de valori. Executați următorul script pe care-l salvați într-un fișier `myfor-loop.sh`:

```
$ cat > myfor-loop.sh
#!/bin/bash
for i in 1 2 3 4 5
do
  echo "Iteratia cu numarul $i"
done
$ chmod u+x myfor-loop.sh
$ ./myfor-loop.sh
Iteratia cu numarul 1
Iteratia cu numarul 2
Iteratia cu numarul 3
Iteratia cu numarul 4
Iteratia cu numarul 5
$
```

Observați că `do` și `done`, cuvinte cheie ale instrucțiunii `for`, trebuie să apară pe o linie separată chiar la începutul ei. Dacă modificați scriptul și mutați cuvântul cheie `do` pe aceeași linie cu `for`, la execuția scriptului veți obține o eroare de sintaxă. Puteți repara această eroare folosind caracterul special `;` care unește două linii:

```bash
#!/bin/bash
for i in 1 2 3 4 5; do
  echo "Iteratia cu numarul $i"
done
```

Valorile din listă pot fi practic orice. De pildă, încercați să executați următorul script, pe care-l puteți salva în fișierul `myfor-loop2.sh`:

```bash
#!/bin/bash
for i in * 1.5 \* 2
do
  echo "Valoarea lui i este $i"
done
```

Ca să înțelegeți comportamentul instrucțiunii `for` în acest caz este important să vă reamintiți de interpretarea *wildcard*-urilor în `bash` prezentată la curs. Încercați să rulați scriptul de mai sus cu și fără `*`. Dar dacă folosiți *escape character* `\*`? Și dacă folosiți `\*`, ce se întâmplă dacă în corpul instrucțiunii `for` afișați valoarea variabilei `i` fără să o includeți în ghilimele (ca mai jos)?

```bash
echo Valoarea lui i este $i
```

### While loops

Instrucțiunea `while` este cel mai adesea folosită împreună cu comanda `test`, ca în exemplul de mai jos pe care îl puteți salva în fișierul `while.sh`:

```bash
#!/bin/bash

while [ "${INPUT_STRING:-hello}" != "bye" ]
do
  echo "Introduceti date (bye pentru a iesi din bucla)"
  read INPUT_STRING
  echo "Ati introdus: $INPUT_STRING"
done
```

Scriptul de mai sus citește șiruri de caractere de la tastatură în buclă până când se tipărește `"bye"`. Ce se întâmplă dacă variabila `INPUT_STRING` nu are valoare inițială?

Scriptul de mai sus se poate modifica în următoarea variantă (`while2.sh`) care nu folosește comanda `test` ci caracterul `:` (echivalent cu comanda `true`) care întoarce permanent valoarea de adevăr:

```bash
#!/bin/bash
while :
do
  echo "Introduceti date (Ctrl-C pentru a iesi din bucla)"
  read INPUT_STRING
  echo "Ati introdus: $INPUT_STRING"
done
```

De asemenea, instrucțiunea `while` se folosește des împreună cu `read`. Ca exemplu aveți scriptul de mai jos (`while3.sh`), care modifică scriptul anterior `case.sh` pentru a permite introducerea de nume de fișiere în mod repetitiv:

```bash
#!/bin/bash

echo -n "Please input a filename: "
while read filename
do
  longformat=`ls -ld $filename 2>/dev/null`
  case "${longformat:0:1}" in
    -)
      echo "$filename is a regular file"
      ;;
    d)
      echo "$filename is a directory"
      ;;
    b)
      echo "$filename is a block file"
      ;;
    c)
      echo "$filename is a character file"
      ;;
    *)
      echo "Sorry, I don't know anything about $filename"
      ;;
  esac
  echo -n "Please input a filename: "
done
```

Puteți încheia introducerea datelor cu `Ctrl+D` sau să terminați programul cu `Ctrl+C`.

## Mai multe despre variabile

Pe lângă variabilele shell-ului (variabile interne și variabile de mediu) există un set de variabile speciale care, de cele mai multe ori, nu pot fi modificate.

Primul set de variabile de interes este cel al variabilelor `0`, `1`, ..., `9`. Variabila `$0`, de pildă, reprezintă numele programului, numit în general *basename*, în vreme ce restul variabilelor până la `9`, `$1`, `$2`, ..., `$9` reprezintă parametrii cu care a fost apelat scriptul. Variabila `@` reprezintă acești parametri, al căror număr exact este stocat în variabila `#`. Pentru înțelegerea mai bună a acestor aspecte, rulați următorul script `param.sh`:

```bash
#!/bin/sh

echo "I was called with $# parameters"
echo "My name is $0"
echo "My nicer name is `basename $0`"
echo "My first parameter is $1"
echo "My second parameter is $2"
echo "All parameters are $@"
```

Comanda externă `basename` este folosită pentru a elimina calea din numele scriptului. Iată aici rezultatele unei posibile rulări:

```
$ ./param.sh
I was called with 0 parameters
My name is ./param.sh
My nicer name is param.sh
My first parameter is
My second parameter is
All parameters are
$ ./param.sh first second third fourth
I was called with 4 parameters
My name is ./param.sh
My nicer name is param.sh
My first parameter is first
My second parameter is second
All parameters are first second third fourth
$
```

Cu ajutorul comenzii `shift` se pot folosi mai mult de 9 parametri în linia de comandă. Scriptul următor, `param2.sh`, evidențiază funcția comenzii `shift` care, atunci când e apelată, iterează printre parametrii de apel ai scriptului („shiftează” parametrii la stânga). Pe măsură ce se shiftează parametrii, numărul lor, conținut în variabila `$#`, scade.

```bash
#!/bin/sh
while [ "$#" -gt "0" ]
do
  echo "\$1 (first parameter) is $1"
  shift
done
```

Rezultatul execuției comenzii demonstrează felul în care se pot accesa toți parametrii de apel, indiferent de numărul lor:

```
$ ./param2.sh 1 2 3 4
$1 (first parameter) is 1
$1 (first parameter) is 2
$1 (first parameter) is 3
$1 (first parameter) is 4
$
```

În final, așa cum am discutat la curs și în laboratoarele anterioare, variabila `?` conține valoarea codului de retur cu care s-a încheiat comanda anterioară. Valoarea acestui cod de retur se poate folosi pentru a notifica utilizatorul în privința rezultatului execuției unei comenzi ca în scriptul de mai jos (`retur.sh`):

```bash
#!/bin/sh

read cmd
eval "$cmd" 2>/dev/null
if [ "$?" -ne "0" ]; then
  echo "$cmd has failed!"
fi
```

Comanda internă a shell-ului `eval` evaluează stringul furnizat ca argument drept comandă și întoarce codul de retur al acestei comenzi. Iată câteva exemple de rulare:

```
$ ./retur.sh
somecmd
somecmd has failed!
$ ./retur.sh
[ "0" -gt "1" ]
[ "0" -gt "1" ] has failed!
$
```

## Sarcini de laborator

1.  Executați toate comenzile prezentate în acest laborator.

2.  Modificați unele dintre scripturile de la laborator pentru a primi datele necesare ca parametri în linie de comandă, în loc să fie citite de la tastatură (de ex., scripturile care identifică tipuri de fișiere).

3.  Scrieți propria versiune a comenzii `ls` fără nici un parametru (adică pentru a lista conținutul directorului curent).

4.  Scrieți un script care folosește o comandă de tip *pipeline* pentru a afișa utilizatorii și PID-urile proceselor lor așa cum sunt afișate de comanda `ps auxw`. Scriptul trebuie să captureze într-un *pipe* outputul comenzii `ps auxw` și să itereze prin fiecare linie tipărind primele două câmpuri ale outputului, cele care corespund utilizatorului și PID-ului.

5.  Scrieți un script `myfind` care emulează comportamentul simplificat al comenzii `find` cu flagurile `-name`, `-type` și `-exec`. Comanda primește ca prim parametru un director și nu funcționează recursiv (i.e., `maxdepth = 1`). Trebuie să fie capabilă să găsească un fișier după nume și/sau tip și, odată identificat, să poată executa o comandă asupra lui. Numele, tipul și comanda de execuție sunt furnizate ca parametri în linia de comandă, exact ca pentru comanda `find` (`man find`).
