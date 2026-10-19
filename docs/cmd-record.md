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