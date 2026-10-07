# Laboratorul 5: Lucrul în rețea

## Rețele de calculatoare

O rețea de calculatoare presupune conectarea fizică a mai multor calculatoare numite și *noduri* (prin analogie cu grafurile, rețelele pot fi modelate și analizate teoretic folosind teoria grafurilor) sau *host*-uri cu ajutorul unor medii de comunicare. Comunicarea efectivă dintre calculatoare folosind aceste medii de comunicare presupune două premise fundamentale: calculatoarele implicate în comunicare trebuie să se poată identifica unul pe altul și respectiv trebuie să se poată „înțelege” unul cu altul. Prima premisă este asigurată prin asignarea unei *adrese de rețea* fiecărui calculator. Cea de-a doua este realizată cu ajutorul *protocoalelor de comunicație*. În mod uzual, acestea determină și modul de adresare.

În cazul Internetului, protocoalele de comunicație sunt denumite generic TCP/IP, deși în fapt e vorba de o suită de protocoale. Adresele asignate calculatoarelor se numesc *adrese IP* (Internet Protocol) și sunt folosite de protocoalele de comunicație. O adresă de IP este compusă din 4 octeți separați de punct, de exemplu `192.168.0.1`. Odată identificat, un calculator poate oferi o multitudine de servicii: web, mail, transfer de fișiere, etc. TCP/IP identifică aceste servicii prin *porturi* cu numere: 80 pentru web, 25 pentru mail, 21 pentru transfer de fișiere, ș.a.m.d. Ele se numesc *well-known ports* pentru că sunt public cunoscute de toată lumea (ca într-o carte de telefoane). O listă de *well-known ports* în sistemele Unix se poate găsi în fișierul `/etc/services`.

## Domenii

Deși stau la baza comunicării în internet, adresele de IP sunt mai rar folosite direct, calculatoarele având în general un nume lizibil, e.g. `www.google.com`, care este asociat cu adresa lor de IP. Servere specializate numite *Domain Name Servers* (DNS), accesibile printr-un protocol de comunicație special disponibil ca serviciu pe portul 53, răspund cererilor pe care alte calculatoare conectate la internet, uzual definite ca fiind calculatoare *client* (sau pe scurt, *clienți*), le fac pentru a afla fie numele unui calculator dată fiind adresa sa de IP, fie adresa de IP a unui calculator cunoscut după numele său.

Concret, pentru a obține adresa de IP asociată unui host putem folosi mai multe metode. Comanda `nslookup`(1) (*name server look-up*) primește ca prim argument numele host-ului, așa-numitul *Fully Qualified Domain Name* sau FQDN, și, opțional, un al doilea argument care specifică ce server DNS să folosească pentru a căuta informația.

```
$ nslookup fmi.unibuc.ro
Server:     127.0.0.53
Address:    127.0.0.53#53

Non-authoritative answer:
Name: fmi.unibuc.ro
Address: 80.96.21.88
```

În prima parte sunt afișate date legate de server-ul DNS folosit. A doua parte oferă informațiile cerute: numele și adresa. Dacă dorim să întrebăm un server anume (în exemplul de mai jos server-ul Google) îi punem adresa în al doilea argument:

```
$ nslookup fmi.unibuc.ro 8.8.8.8
Server:     8.8.8.8
Address:    8.8.8.8#53

Non-authoritative answer:
Name: fmi.unibuc.ro
Address: 80.96.21.88
```

Comanda `nslookup` poate fi lansată și în mod interactiv, caz în care oferă o mică linie de comandă care permite execuția anumitor instrucțiuni, după cum se poate vedea mai jos:

```
$ nslookup
> server
Default server: 127.0.0.53
Address: 127.0.0.53#53
> server 1.1.1.1
Default server: 1.1.1.1
Address: 1.1.1.1#53
> set type=ptr
> 8.8.8.8
Server:     1.1.1.1
Address:    1.1.1.1#53

Non-authoritative answer:
8.8.8.8.in-addr.arpa    name = dns.google.

Authoritative answers can be found from:

> set type=a
> dns.google
Server:     1.1.1.1
Address:    1.1.1.1#53

Non-authoritative answer:
Name:   dns.google
Address: 8.8.4.4
Name:   dns.google
Address: 8.8.8.8

Authoritative answers can be found from:

> set type=ns
> google.com
Server:     1.1.1.1
Address:    1.1.1.1#53

Non-authoritative answer:
google.com      nameserver = ns1.google.com.
google.com      nameserver = ns2.google.com.
google.com      nameserver = ns3.google.com.
google.com      nameserver = ns4.google.com.

Authoritative answers can be found from:

> set type=mx
> google.com
Server:     1.1.1.1
Address:    1.1.1.1#53

Non-authoritative answer:
google.com      mail exchanger = 10 smtp.google.com.

Authoritative answers can be found from:
> exit
```

Comanda `server` tipărește numele serverului la care apelează `nslookup` momentan pentru a rezolva cereri de DNS. Dacă primește ca parametru o adresă de IP sau un FQDN (*Fully Qualified Domain Name*) a unui server DNS, va schimba adresa serverului DNS la care `nslookup` apelează. Comanda `set` în conjuncție cu parametrul `type` permite efectuarea de query-uri de FQDN (type A) care întoarce adresa IP corespunzătoare, query-uri de adrese IP (type PTR) care întoarce FQDN-ul corespunzător, query-uri pentru a afla serverul de DNS responsabil pt un anumit domeniu (type NS) sau pentru a afla serverul de mail (type MX) responsabil pentru un anumit domeniu.

Alte comenzi utile care funcționează similar sunt:

- `dig`(1): `$ dig @8.8.8.8 fmi.unibuc.ro` (server-ul DNS trebuie prefixat cu `@`)
- `host`(1): `$ host fmi.unibuc.ro 8.8.8.8` (server-ul DNS apare la sfârșitul comenzii)
- `whois`(1): `$ whois unibuc.ro` (informații despre domeniul principal, nu despre subdomeniul `fmi`)

Pentru a vedea dacă un host este accesibil în rețea putem folosi comanda `ping`(1). Faceți distincția între conectare și accesibilitate. Un calculator poate fi fizic conectat la rețea, dar temporar inaccesibil, fie din cauza unor defecte (hardware sau software) locale pe host fie din cauza unor defecte în rețeaua din care face parte. De asemenea, se întâmplă adesea ca un host să fie temporar inaccesibil pentru mentenanță. `ping` nu spune decât dacă la momentul execuției comenzii host-ul este accesibil (se mai spune și *online*) sau nu.

```
$ ping fmi.unibuc.ro
PING fmi.unibuc.ro (80.96.21.88): 56 data bytes
64 bytes from 80.96.21.88: icmp_seq=0 ttl=50 time=7.317 ms
64 bytes from 80.96.21.88: icmp_seq=1 ttl=50 time=7.053 ms
64 bytes from 80.96.21.88: icmp_seq=2 ttl=50 time=6.925 ms
^C
--- fmi.unibuc.ro ping statistics ---
3 packets transmitted, 3 packets received, 0.0% packet loss
round-trip min/avg/max/std-dev = 6.925/7.098/7.317/0.163 ms
```

Observați că această comandă întâi găsește adresa host-ului și apoi comunică direct cu IP-ul acestuia. În Unix, dacă nu se specifică un număr de încercări, comanda va încerca până când utilizatorul o oprește cu `Ctrl+C`. În Windows, comanda încearcă de 4 ori implicit după care se oprește.

O altă comandă utilă atunci când vreți să obțineți mai multe informații despre accesibilitatea unui nod de rețea din internet este `traceroute`. De pildă, dacă vreți să știți peste câte hop-uri trece un pachet trimis de mașina locală ca mai sus în comanda `nslookup` către serverul DNS public al Google, puteți folosi comanda de mai jos:

```
$ traceroute 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  gateway (192.168.100.1)  0.837 ms  0.809 ms  7.898 ms
 2  10.0.33.143 (10.0.33.143)  5.829 ms  5.796 ms  5.880 ms
 3  10.12.100.1 (10.12.100.1)  5.839 ms  5.912 ms  5.871 ms
 4  10.220.187.54 (10.220.187.54)  5.905 ms  5.869 ms  5.931 ms
 5  10.220.208.244 (10.220.208.244)  19.839 ms  20.122 ms  45.225 ms
 6  72.14.216.212 (72.14.216.212)  25.055 ms ...
 7  * 172.253.65.251 (172.253.65.251)  21.788 ms ...
 8  dns.google (8.8.8.8)  19.253 ms ...
```

După cum observați, în cazul calculatorului de pe care a pornit comanda a fost nevoie să se treacă de 7 routere până să se ajungă la destinație (`dns.google`). Aceste routere intermediare se numesc în limbaj colocvial *hop*-uri.

## Servicii de rețea

Fișierul `/etc/hosts` este folosit pentru a defini manual perechi *adresă IP – nume*. În momentul în care se fac query-uri de DNS, clientul local DNS de pe calculator (așa numitul *DNS resolver*) cercetează fișierul `/etc/nsswitch.conf` pentru a detecta ordinea în care se caută un server care să rezolve cererea. În general, câmpul `hosts` al fișierului `/etc/nsswitch.conf` precizează ordinea de mai jos:

```
hosts:          files dns
```

Această sintaxă ne spune că în general fișierele locale (`files`), în cazul nostru `/etc/hosts`, sunt chestionate prioritar pentru rezolvarea numelui înaintea serverelor DNS. În cazul în care fișierul `/etc/hosts` conține rezolvarea dorită a numelui, DNS resolver-ul întoarce rezultatul găsit. Dacă nu a găsit nicio intrare potrivită căutării în `/etc/hosts`, resolver-ul va căuta să acceseze un server DNS pentru a rezolva numele. Pe sistemele Unix, numele serverului DNS este uzual setat în fișierul `/etc/resolv.conf`.

Formatul `/etc/hosts` este simplu:

```
$ cat /etc/hosts
127.0.0.1        localhost
192.168.1.1      myserver
5.2.14.244       alex.unibuc.ro
```

Prima intrare din `/etc/hosts` ne indică așa-numita *adresă de loopback*. Aceasta este adresa locală a calculatorului și poate fi folosită ca orice adresă IP. Spre deosebire de o adresă IP din rețea, adresa de loopback poate fi folosită oricând, chiar și atunci când calculatorul nu este conectat fizic într-o rețea. În continuarea laboratorului veți folosi această adresă de loopback pentru a exersa toate comenzile care urmează, atunci când exercițiul nu indică expres o adresă de internet.

Atunci când secvența de boot se încheie și kernelul dă controlul procesului `init` (`systemd` în Linux), dacă s-a selectat runlevel-ul care configurează sistemul ca fiind conectat în rețea (e.g., nivelurile 3 sau 5), am văzut la curs că se execută o serie de scripturi de sistem de tip *rc* sau *run commands* care pornesc și monitorizează serviciile sistem din spațiul utilizator. În particular, pentru runlevel-urile care prevăd funcționarea în rețea, aceste scripturi pornesc serviciile de rețea. Serviciile de rețea în Linux se află în general în directorul `/etc/init.d` și sunt manipulate cu ajutorul comenzii `service`. Aceasta folosește numele serviciului (e.g., `ssh`) și comenzile pe care le înțelege scriptul aferent serviciului. În general aceste comenzi sunt standardizate pentru toate scripturile lansate de `init`: `{start, stop, restart, reload, etc}`. Iată o secvență de pornire/oprire a serviciului de `ssh`:

```
$ service ssh start
$ service ssh stop
```

Aici `ssh` este un script cu acest nume din `/etc/init.d` care poate primi ca parametru string-urile `{start, stop}`, executând pe cale de consecință pornirea, respectiv oprirea serviciului. O secvență echivalentă de comenzi este:

```
$ /etc/init.d/ssh start
$ /etc/init.d/ssh stop
```

Serviciile de rețea (și în general toate serviciile sistem) pot fi activate respectiv dezactivate cu comanda `systemctl` care controlează activitatea procesului `systemd` și a managerului de servicii. Activarea și respectiv dezactivarea unui serviciu nu presupune pornirea sau oprirea lui, ci doar marchează serviciul ca fiind legat de o procedură anume din sistem, de pildă bootarea calculatorului. Activarea/dezactivarea și pornirea/oprirea serviciilor sunt ortogonale: un serviciu poate fi activat fără a fi pornit, după cum poate fi pornit fără a fi activat. Ca un exemplu concret, următoarea comandă:

```
$ systemctl disable ssh
```

nu va avea nici un efect asupra serviciului de `ssh`. Dacă era pornit, el va continua să ruleze. În schimb, la bootarea calculatorului serviciul nu va mai fi pornit automat, va fi nevoie de apelul explicit al comenzii `service` pentru a îl porni. **N.B.** Execuția comenzilor `service` și `systemctl` necesită drepturi de `root`.

## Acces la distanță

### Transfer de date prin FTP

Pentru a accesa un host ce servește date prin protocolul FTP se folosește comanda `ftp`(1).

```
$ ftp alex@fmi.unibuc.ro
$ ftp ftp://fmi.unibuc.ro
$ ftp fmi.unibuc.ro -P 2121
```

Multe servere oferă informații legate de acces și structura datelor pe server la momentul conectării. Este important de văzut dacă este oferit acces anonim, fără autentificare. În acest caz de obicei se folosește utilizatorul `anonymous` sau `anon` și, politicos, se trece ca parolă adresa de email la care puteți fi contactați. Dacă nu doriți acest lucru, apăsați pur și simplu `Enter` când se cere parola.

O dată conectați va apărea promptul `ftp>` care indică faptul că vă aflați într-un shell specializat protocolului FTP. Comenzile de navigare și manipulare a fișierelor (dacă aveți dreptul) sunt aceleași ca cele învățate până acum în shell: `ls`, `cd`, `pwd`, `rmdir`, `chmod` etc. Pentru a vedea toate comenzile disponibile apelați la comanda `help`.

Pentru a urca sau coborî un fișier folosiți comenzile `put`, respectiv, `get`. Dacă aveți nevoie să efectuați operația pentru mai multe fișiere puteți folosi `mput` și `mget` (`m` de la *multiple*). Pentru a ieși folosiți `quit`.

Server-ele FTP sunt din ce în ce mai rare în spațiul public, dar comenzile și modul de lucru este comun cu înlocuitorii lor moderni (ex. `sftp`).

#### Instalarea și pornirea serviciului de FTP

Cel mai simplu mod de a exersa comanda `ftp` este să porniți local serviciul corespunzător (cel mai probabil instalându-l în prealabil):

```
$ apt install vsftpd
$ service vsftpd start
```

**Obs:** Dacă ați instalat software-ul cu comanda `apt`, nu este necesară pornirea serviciului, procedura de instalare a serverului îl și pornește automat. Pentru a verifica starea serviciului după instalare rulați comanda:

```
$ service vsftpd status
```

Odată ce serverul de FTP rulează, puteți folosi următoarea comandă:

```
$ ftp localhost
```

Puteți folosi la login contul `anonymous`? Dacă nu, de ce? (v. pagina de manual).

### Administrare prin SSH

#### Instalarea și pornirea serviciului de SSH

La fel ca mai sus, începeți prin a porni serviciul de SSH (eventual instalându-l în prealabil dacă nu există în sistem):

```
$ service ssh status
$ service ssh start             # daca serviciul e oprit
$ apt install openssh-server    # daca serviciul nu e instalat
```

#### Lucrul cu SSH

Pentru a executa anumite comenzi sau a configura servicii de pe un host aflat la distanță se folosește comanda `ssh`(1).

```
$ ssh fmi.unibuc.ro
$ ssh alex@fmi.unibuc.ro
$ ssh alex@fmi.unibuc.ro -p 2222
```

Rezultatul acestei comenzi este deschiderea unui shell pe o mașină aflată la distanță, identificată ca mai sus prin adresa de IP și/sau port. Numele de utilizator este fie implicit numele local al utilizatorului care lansează comanda `ssh`, fie cel precizat explicit în comandă înainte de caracterul `@`. Execuția shell-ului la distanță eșuează dacă utilizatorul nu reușește să se logheze în sistemul de la distanță cu parola de utilizator de pe sistemul respectiv.

La prima conectare, `ssh` nu cunoaște încă serverul și cere confirmarea amprentei acestuia: tastați `yes`. Urmăriți promptul: după conectare el arată numele mașinii de la distanță, iar după `exit` reveniți pe mașina proprie.

![Prima conectare prin ssh și revenirea cu exit](../assets/gifs/ssh.gif)

O variantă mai comodă și mai sigură de autentificare, care nu presupune introducerea parolei de pe sistemul de la distanță, folosește criptografia cu chei asimetrice. Această metodă de autentificare presupune folosirea a două chei: una *publică* și una *secretă*/*privată*. Cheia publică este cunoscută tuturor (poate fi distribuită public) și poate fi preluată de sistemele de calcul care vor să permită accesul pe baza ei. Cheia secretă este cunoscută doar de proprietarul contului și trebuie păstrată în siguranță. Compromiterea ei impune automat generarea unei noi perechi de chei și înlocuirea celor vechi. Perechea de chei este folosită pentru autentificare și acces fără parolă.

Cheile sunt stocate de regulă în directorul `~/.ssh/` din contul utilizatorului. Cheia publică, care folosește uzual extensia `.pub` este distribuită după generare pe sistemele de calcul în care se dorește accesul utilizatorului. Ea este adăugată pe sistemele respective într-un fișier numit `~/.ssh/authorized_keys` care conține toate cheile publice ale utilizatorului care are dreptul să utilizeze contul respectiv de pe mașina aflată la distanță.

La lansarea comenzii `ssh` se verifică conținutul directorului `~/.ssh/` și întâi se încearcă autentificarea prin chei asimetrice, dacă acestea există în director. Altfel, `ssh` recurge la procedura de *fall-back* și se încearcă metoda clasică de autentificare cu utilizator și parolă.

O dată autentificați, suntem întâmpinați de un shell identic cu cel cu care am lucrat până acum doar că rulează pe mașina de la distanță, și ca atare toate comenzile sunt executate pe host-ul la distanță nu pe mașina proprie.

Pentru a executa o simplă comandă fără a mai intra în shell, putem specifica comanda imediat după host:

```
$ ssh fmi.unibuc.ro ls
```

Generarea unei chei asimetrice se face cu comanda `ssh-keygen`(1).

```
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/alex/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/alex/.ssh/id_rsa.
Your public key has been saved in /home/alex/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:ixhRJaJimfffiqTED8+ZGSp+ZMGtqwC/V7qsmxPTtAU alex@fmi
The key's randomart image is:
+---[RSA 2048]----+
|o. Eo            |
|.+O.o.           |
|O..              |
|oOo.             |
|.o+o S           |
|..++oOo          |
| .+=*            |
|  .o*@*          |
|   .oOBOX        |
+----[SHA256]-----+
```

Cheia publică are sufix `.pub` și se găsește în `/home/alex/.ssh/id_rsa.pub`. Cea privată se găsește în același loc dar fără sufix. Implicit comanda `ssh-keygen`(1) generează chei RSA. Este recomandat să folosiți un algoritm mai nou cum ar fi `ed25519` sau `ecdsa`. Pentru aceasta folosiți argumentul `-t algoritm`:

```
$ ssh-keygen -t ed25519
Generating public/private ed25519 key pair.
```

Cheile publice pentru cei care doriți să aibă acces pe contul dumneavoastră de pe un host (ex. calculatorul propriu, server web etc.) se pun în fișierul `.ssh/authorized_keys` din `$HOME`. Pentru a adăuga o cheie publică `id_rsa.pub` folosiți

```
$ cat id_rsa.pub >> .ssh/authorized_keys
```

Întregul proces, de la generarea cheii până la conectarea fără parolă:

![Generarea unei chei ed25519, copierea ei pe server și conectarea fără parolă](../assets/gifs/ssh-keygen.gif)

Pentru a transfera date prin SSH se folosește comanda `scp`(1) care se comportă aproape identic cu `cp`(1). Diferența apare în specificarea sursei și destinației. Acestea sunt prefixate cu date legate de host.

```
$ scp hello.c fmi.unibuc.ro:
$ scp hello.c alex@fmi.unibuc.ro:code/
$ scp -r project/ alex@fmi.unibuc.ro:
```

Implicit, dacă nu este specificată nicio cale după `:`, transferul se face din/în directorul `$HOME` al utilizatorului. Dacă este specificată o cale, aceasta poate fi relativă `fmi.unibuc.ro:catalog` sau absolută `fmi.unibuc.ro:/etc/passwd`.

Adesea, comanda `scp` este folosită pentru a iniția transferuri de date de dimensiuni mari, care pot dura foarte mult, făcând impractică păstrarea deschisă a terminalului din care s-a lansat comanda. Pe de altă parte, închiderea terminalului echivalează în mod uzual cu terminarea comenzii, ceea ce nu este de dorit. Există programe care permit detașarea comenzii de terminalul de lucru, fapt ce permite închiderea acestuia. Ulterior, când utilizatorul reia sesiunea de lucru și deschide un nou terminal de lucru poate reatașa comanda noului terminal. În tot acest timp comanda a rulat în *background* și, presupunând că nu au existat erori în execuția ei, a progresat în realizarea obiectivului ei. Programe de acest tip care detașează o comandă de terminalul de lucru sunt de pildă `screen` sau `tmux`. Comanda `scp` atunci când transferă cantități mari de date se folosește în mod uzual împreună cu o comandă care permite detașarea de terminal. Mai jos aveți un exemplu de folosire a comenzii `screen` care detașează de terminal o comandă `ssh` care execută la distanță o comandă care durează mult, simulată în exemplul nostru de `sleep 300`:

```
$ screen ssh localhost sleep 300
```

După autentificare (fără parolă dacă ați generat cu succes cheile asimetrice cf. procedurii de mai sus), comanda `ssh` va executa la distanță (în fapt local, pentru că v-ați conectat la `localhost`) comanda `sleep 300`. Apoi puteți tasta `Ctrl+A` urmat de `D` pentru a detașa comanda `ssh` de terminal și veți reprimi controlul shell-ului (promptul). Puteți închide acum terminalul. Deschideți un terminal nou și executați comanda următoare:

```
$ screen -ls
```

care va lista un identificator al comenzii detașate de vechiul terminal. Cu ajutorul comenzii `screen -r <identificator>` puteți reatașa comanda `ssh` detașată anterior la terminalul curent. Tastați `Ctrl+C` pentru a termina execuția comenzii `sleep`.

În clipul de mai jos, în locul lui `sleep 300` rulează `ping`, care afișează câte o linie pe secundă. La reatașare se vede că a continuat să ruleze cât timp sesiunea a fost detașată.

![Detașarea unei comenzi cu screen, listarea și reatașarea ei](../assets/gifs/screen.gif)

O implementare similară FTP folosind protocolul SSH este SFTP. Pentru a accesa un server se folosește comanda `sftp`(1) în același mod în care folosim comanda `ssh`(1). O dată autentificați, comenzile și modul de lucru sunt aproape identice cu cele din FTP. Excepție face faptul că modul anonim nu mai este disponibil.

## Sarcini de laborator

1.  Găsiți adresele IP pentru `google.com`, `fmi.unibuc.ro`, `wikipedia.org`. Adăugați câte o intrare pentru fiecare în `/etc/hosts`.

2.  Inter-schimbați adresele de IP pentru `google.com` și `fmi.unibuc.ro`. Folosiți `ping`(1) pentru cele două host-uri înainte și după modificare. Apare vreo schimbare?

3.  Scrieți un shell script care citește tot conținutul fișierului `/etc/hosts` și pentru fiecare linie de tip *adresă IP – nume* folosiți comanda `nslookup` pentru a verifica adresa de IP a numelor din fișier. Dacă `nslookup` va întoarce o altă adresă IP decât cea din `/etc/hosts` tipăriți pe ecran mesajul `"Bogus IP for <nume> in /etc/hosts!"`. Indicație: O posibilă soluție este să folosiți comenzile `cat` și `while` într-un *pipeline*, `cat` pentru a afișa conținutul `/etc/hosts` și `while` împreună cu `read` pentru a itera prin conținutul fișierului.

4.  Inspectați cu un program de tip *pager* (`less`/`more`) conținutul scriptului `/etc/init.d/ssh`. Înțelegeți felul în care sunt folosiți parametrii de apel `start|stop|status|reload`, etc.?

5.  Accesați serverul `ftp.gnu.org` folosind un client `ftp` din linie de comandă. Navigați în directorul `gnu/wget` și obțineți fișierul `wget-XX.tar.gz` unde `XX` este cea mai recentă versiune pe care o găsiți în acel director (indiciu: folosiți `ls`).

6.  Inspirați-vă din [ghidul acesta](https://cloud.google.com/compute/docs/tutorials/basic-webserver-apache) pentru a vă crea pe mașina locală o mașină virtuală Linux care servește pagini de Web. Porniți serviciul de `ssh` din mașina virtuală, eventual instalând serviciul în prealabil dacă nu există pe mașina virtuală. Folosiți `ssh-keygen`(1) pentru a genera o pereche de chei publică-privată. Copiați cheia publică (cea cu extensia `.pub`) pe contul pe care îl folosiți pentru a accesa mașina virtuală și adăugați-o la conținutul fișierului `authorized_keys` ca mai sus. Conectați-vă prin `ssh`(1) la noua mașină virtuală de pe calculatorul local.

7.  Copiați un mic site Web de pe mașina locală pe care o folosiți pe serverul Web de pe mașina virtuală creată anterior. Acest task revine la a copia directorul care conține site-ul Web de pe mașina locală pe mașina virtuală (server) folosind `scp`(1). Noul director trebuie pus în `/var/www/html/student/`. Indicații: Pentru Windows puteți transfera fișierele folosind comanda `scp` dintr-un shell cygwin sau cu ajutorul putty.

    Pentru a intra rapid în posesia unui mini site web, puteți descărca de pe internet cu comanda `wget` codul html al unui site existent. Folosiți flag-urile `-r` (download recursiv) și `-l` pentru a limita adâncimea arborelui de documente html descărcat. Ex: `wget -r -l 2 fmi.unibuc.ro`
