# Inregistrarea comenzilor de laborator cu ajutorul `script`

Începem înregistrarea comenzilor folosind `script` și direcționăm salvarea în fișierul `labN_Nume_Prenume` (N = numărul laboratorului).

## Exemplu

```shell
student@lab:~$ script lab3_Popescu_Ioana
Script started, output log file is 'lab3_Popescu_Ioana'.
```

Acum putem începe comenzile corespunzătoare laboratorului curent:

```shell
student@lab:~$ cd itbi
student@lab:~/itbi$ ls
...restul comenzilor laboratorului...
```

Pentru a finaliza înregistrarea comenzilor introducem `exit`.

```shell
student@lab:~$ exit
exit
Script done.
```

## Indicații

- Nume de fișier fără diacritice sau spații.
- Dacă rulați din nou `script` cu același nume de fișier, conținutul anterior se **suprascrie**. Folosiți `script -a` pentru a adăuga la finalul fișierului existent.
- Nu folosiți `nano`, `vim`, `less` în timpul înregistrării cu `script` deoarece fac fișierul ilizibil. Dacă aveți nevoie să editați un fișier, deschideți un alt tab de terminal (în același director), editați de acolo, apoi rulați `cat nume_fisier_editat` în terminalul în care rulează `script` pentru a afișa conținutul în înregistrare.

## Alternativă: `asciinema`

`asciinema` înregistrează sesiunea într-un fișier `.rec` care poate fi redat ulterior. La redare păstrează corect culorile și caracterele speciale ale terminalului, spre deosebire de fișierul brut generat de `script`, care poate deveni greu de citit când sunt folosite astfel de caractere. Pentru ca fișierul de predat în format text să fie lizibil, îl convertim cu formatul `txt`: acesta elimină culorile și caracterele de control ale terminalului.

Instalați o singură dată pachetul, dacă nu îl aveți deja:

```shell
student@lab:~$ sudo apt install asciinema
```

Începeți înregistrarea laboratorului curent. Exemplul de mai jos este pentru laboratorul 3:

```shell
student@lab:~$ asciinema rec lab3_Popescu_Ioana.rec
```

Rulați comenzile laboratorului ca de obicei. Pentru a încheia, tastați `exit` sau apăsați ++ctrl+d++. Evitați introducerea parolelor sau a altor date sensibile în sesiune: ele pot apărea în înregistrare.

După încheiere, creați fișierul text care se predă:

```shell
student@lab:~$ asciinema convert lab3_Popescu_Ioana.rec lab3_Popescu_Ioana.txt
```

Fișierul `.rec` păstrează înregistrarea pentru redare, iar `lab3_Popescu_Ioana.txt` este varianta curată și ușor de citit. Nu deschideți editoare interactive (`nano`, `vim`, `less`) în sesiunea înregistrată; editați într-un alt terminal, apoi folosiți `cat nume_fisier` în sesiunea Asciinema ca să apară conținutul în înregistrare și în fișierul `.txt`.
