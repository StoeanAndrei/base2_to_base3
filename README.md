# base2_to_base3

Solutia problemei date este impartita in doua parti:
1. algoritmul de impartire a numerelor intregi pentru aflarea catului si a restului
2. algoritmul pentru implementarea automatului finit

Algoritmul de impartire 'div_algo' primeste 2 semnale de intrare fiind reprezentate de 2 numere intregi reprezentand deimpartitul si impartitorul. Acest algoritm efectueaza impartirea numerelor printr-o metoda binara pentru aflarea catului si a restului. Algoritmul pentru implementarea automatului finit 'base2_to_base3' este un algoritm cat se poate de clar. Automatul are 4 stari: READ, EXEC, EXEC2 si DONE. Aceste stari au roluri diverse precum:

1. READ reprezinta starea in care se citeste valoarea de intrare si se salveaza intr-un registru auxiliar. Pentru a trece la starea urmatoare, numarul trebuie sa fie citit, primind astfel un semnal pozitiv.

2. EXEC reprezinta starea in care se executa operatia de impartire prin algoritmul 'div_algo', fiind datele necesare catre acesta.

3. EXEC2 reprezinta starea in care se citesc rezultatele algoritmului de impartire, se formeaza numarul in baza 3, iar apoi in functie de valoarea din registrul auxiliar ajutator se trece la starea urmatoare.

4. DONE reprezinta starea finala care marcheaza finalul executiei printr-un semnal pozitiv la iesire.
