# GIF-uri pentru laboratoare

Fiecare fișier `.tape` descrie un clip de terminal, generat cu [VHS](https://github.com/charmbracelet/vhs) în `docs/assets/gifs/`.

## Cerințe

- `vhs` și `ttyd` (Arch: `sudo pacman -S vhs ttyd`)
- `docker`, pentru clipurile laboratoarelor 2–6

Clipurile laboratoarelor 2–6 rulează într-un container Ubuntu, ca să arate la fel ca mașina virtuală a studenților și să nu depindă de configurația calculatorului pe care se înregistrează. Imaginea se construiește o singură dată:

```
docker build -t itbi-demo tapes/
```

Containerul are utilizatorul `student`, cu parola `student` și drept de `sudo`. Clipurile SSH pornesc un al doilea container, `server`, și îl șterg la final.

## Generare

Un singur clip:

```
vhs tapes/jobs.tape
```

Toate clipurile (bash):

```
for t in tapes/*.tape; do vhs "$t"; done
```

## Modificare

Comenzile dintre `Hide` și `Show` pregătesc mediul și nu apar în clip. Ritmul se ajustează din valorile `Sleep` și `TypingSpeed`.
