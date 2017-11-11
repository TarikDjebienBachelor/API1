{--------------------------------------------------------------------------------------------}
{-                                      cor_ensemble.pas                                    -}
{- Christian Lasou, 05/03/08                                                                -}
{- Correction du TP3                                                                        -}
{- OBJET : implantation d'un type ensembles                                                 -}
{--------------------------------------------------------------------------------------------}

PROGRAM ENSEMBLES;


   type MOIS = (JANVIER, FEVRIER, MARS, AVRIL, MAI, JUIN, JUILLET, AOUT, SEPTEMBRE, OCTOBRE,
                NOVEMBRE,DECEMBRE) ;
                // personnellement je préfère mettre les constantes en majuscules
   const NOM_DU_MOIS : array [MOIS] of STRING  
             = ('janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août',
                'septembre', 'octobre', 'novembre', 'décembre') ;  // j'ai ajouté les accents


   type ELEMENT = MOIS ;      // c'est un simple renommage
        ENSEMBLE = array[ELEMENT] of BOOLEAN ;

   ///////////////////////////////////////////////
   // DEUX OUTILS D'ENTREE-SORTIE POUR LES MOIS //
   ///////////////////////////////////////////////

   // contrainte d'utilisation:
   // l'utilisateur DOIT taper le mois en minuscule 
   // sans ajouter d'espace ni avant ni après,
   // et ne pas faire d'erreur...(en particulier pour les accents)
   procedure lire(out x : MOIS) ;
   var s : STRING ;
       i : MOIS ;
   begin
      readln(s);
      for i := low(MOIS) to high(MOIS) do 
         // c'est maladroit de faire une boucle pour
         // pour faire la recherche dans un tableau
         // mais ici comme la longueur du tableau
         // est assez petite...
      begin
         if NOM_DU_MOIS[i] = s then x := i ;
      end {for};
   end {lire};

   procedure ecrire(const x : MOIS) ;
   begin
      write(NOM_DU_MOIS[x]);
   end {ecrire};

   //////////////////////////////////////
   // ON PASSE MAINTEANT AUX ENSEMBLES //
   //////////////////////////////////////

   procedure afficher(const x : ENSEMBLE) ;   // version allégèe, celle du TP
   var i : ELEMENT ;                          // et je ne vais pas à la ligne après
   begin
      for i := low(x) to high(x) do begin   // il faut utiliser low et high
         if x[i] then begin
            ecrire(i) ; write(' ') ; // à la fin on aura un espace mais on ne le voit pas
         end {if} ;
      end {for} ;
   end {afficher};

   procedure afficher_joli(const x : ENSEMBLE) ;   // version mathématique assez difficile
   var i,j : ELEMENT ;
   begin
      // je veux un affichage impeccable avec les accolades, les virgules mais sans une de
      // trop, donc
      write('{') ;  // la première accolade
      // je cherche le premier élément si il en a un
      i := low(ELEMENT) ;
      while (i < high(ELEMENT)) and not x[i] do begin    // remarquez, je m'arrête quand je
         inc(i) ;                                        // suis sur high(ELEMENT)
      end {while} ;
      // ou bien i = high(ELEMENT) et x[i] est peut-être VRAI
      // ou bien i < high(ELEMENT) et x[i] est VRAI
      // De toute façon si x[i] est FAUX c'est l'ensemble vide, sinon i est le premier élément
      if not x[i] then begin  // ensemble vide il ne reste qu'à fermer l'accolade
         write('}') ;
      end else begin // i est le premier élément
         ecrire(i) ;
         // ensuite j'écris les autres en les faisant précéder de la virgule correspondante
         // sauf si i = high(ELEMENT) car succ(i) !!!
         if i < high(ELEMENT) then begin
            for j := succ(i) to high(x) do begin
               if x[j] then begin
                  write(', ') ; ecrire(j) ;
               end {if} ;
            end {for} ;
         end {if} ;
         // derrière le dernier élément je mets l'accolade
         write('}') ;
      end {if} ;
   end {afficher_joli};

   // fonction sans parametre dont le résultat est l'ensemble vide
   function partie_vide : ENSEMBLE;
   var e : ELEMENT ;
   begin
      // une première idée serait d'écrire
      // partie_vide := (FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,
      //                 FALSE,FALSE,FALSE,FALSE,FALSE,FALSE) ;
      // mais c'est refusé par le compilateur on peut déclarer une constante de type tableau
      // en mettant sa valeur sous cette forme mais ce n'est pas une "valeur" qu'on peut
      // affecter à une variable (ou nom de fonction)
      // Qu'à cela ne tienne on peut déclarer une constante PARTIE_VIDE
      // mais encore une fois ce serait maladroit car trop dépendant du type ELEMENT (qui,
      // ici , sont des MOIS) au nombre de 12 mais qui pourrait être changé par des LETTRES
      // au nombre de 26.
      // Donc il vaut mieux faire cette fonction partie_vide en utilisant une boucle
      for e := low(ELEMENT) to high(ELEMENT) do begin
         partie_vide[e] := FALSE ;
      end {for} ;
   end {partie_vide};

   // fonction sans paramètre dont le résultat est l'ensemble de tous
   //   les éléments du type ELEMENT.
   function partie_pleine : ENSEMBLE;
   var e : ELEMENT ;
   begin
      // On pourrait faire les mêmes remarques que pour partie_vide
      for e := low(ELEMENT) to high(ELEMENT) do begin
         partie_pleine[e] := TRUE ;
      end {for} ;
   end {partie_pleine};

   // fonction dont le résultat est l'ensemble des éléments qui
   //   appartiennent à a ou à b (ou les deux)
   function union(const a,b : ENSEMBLE): ENSEMBLE;
   var e : ELEMENT ;
   begin
      for e := low(ELEMENT) to high(ELEMENT) do begin
         union[e] := a[e] or b[e] ;
      end {for} ;
   end {union};

   // fonction dont le résultat est l'ensemble des éléments qui 
   //   appartiennent à a et à b 
   function intersection(const a,b:ENSEMBLE): ENSEMBLE;
   var e : ELEMENT ;
   begin
      for e := low(ELEMENT) to high(ELEMENT) do begin
         intersection[e] := a[e] and b[e] ;
      end {for} ;
   end {intersection};

   // fonction dont le résultat est l'ensemble des éléments de 
   // l'ensemble a qui n'appartiennent pas à b
   function difference(const a,b : ENSEMBLE): ENSEMBLE;
   var e : ELEMENT ;
   begin
      for e := low(ELEMENT) to high(ELEMENT) do begin
         difference[e] := a[e] and not b[e] ;
      end {for} ;
   end {difference};

   // fonction dont le résultat est le nombre d'éléments de 
   //  l'ensemble a (on ne pouvait pas l'appeler cardinal...)
   function nombre(const a : ENSEMBLE):CARDINAL;
   var e : ELEMENT ;
       resultat : CARDINAL ;
   begin
      resultat := 0 ;
      for e := low(ELEMENT) to high(ELEMENT) do begin
         if a[e] then inc(resultat) ;
      end {for} ;
      nombre := resultat ;
   end {nombre};

   // fonction dont le résultat est l'ensemble des éléments 
   // de la partie_pleine qui n'appartiennent pas à a
   function complementaire(const a : ENSEMBLE): ENSEMBLE;
   begin
      complementaire := difference(partie_pleine,a) ;
   end {complementaire};

   // prédicat permettant de tester si x est un élément de a 
   function appartient(const x : ELEMENT; const a : ENSEMBLE): BOOLEAN;
   begin
      appartient := a[x] ;
   end {appartient};

   // fonction dont le résultat est un ensemble contenant 
   // uniquement l'élément x 
   function singleton(const x : ELEMENT) : ENSEMBLE;
   begin
      singleton := partie_vide ;
      singleton[x] := TRUE ;
   end {singleton};

   // fonction dont le résultat est un ensemble contenant tous les
   //   éléments de a sauf x  (il n'est pas nécessaire que x 
   //   soit un élément de a 
   function prive(const x : ELEMENT ; const a : ENSEMBLE):ENSEMBLE;
   begin
      prive := a ;
      prive[x] := FALSE ;
   end {prive};

   // fonction dont le résultat est un ensemble contenant tous 
   //  les éléments de a  et x (il n'est pas nécessaire que 
   //  x ne soit pas un élément de a)
   function ajout(const x : ELEMENT ; const a : ENSEMBLE):ENSEMBLE;
   begin
      ajout := a ;
      ajout[x] := TRUE ;
   end {ajout};


   var t1,t2 : ENSEMBLE;
       i : CARDINAL ;
       e : ELEMENT ;

begin

   // initialisation de t1
   // totalement arbritraire, je choisis 5 éléments au hasard donc éventuellement le même
   randomize ; // pour initialiser le générateur aléatoire
   t1 := partie_vide ;
   for i := 1 to 5 do begin
      t1[ELEMENT(random(12))] := TRUE ;    // ATTENTION dépend du type ELEMENT
   end {for} ;

   // tests des procédures d'affichage
   writeln('tests des procédures d''affichage') ;
   afficher(t1) ; writeln ;
   afficher_joli(t1) ; writeln ;
   afficher(partie_vide) ; writeln ;
   afficher_joli(partie_vide) ; writeln ;
   afficher(partie_pleine) ; writeln ;
   afficher_joli(partie_pleine) ; writeln ;
   writeln ;

   // tests des 3 opérations union, intersection, difference
   writeln('tests des 3 opérations union, intersection, difference') ;
   // j'initialise t2 comme t1 mais en prenant 7 éléments au plus
   t2 := partie_vide ;
   for i := 1 to 5 do begin
      t2[ELEMENT(random(12))] := TRUE ;    // ATTENTION dépend du type ELEMENT
   end {for} ;
   write('union(') ; afficher_joli(t1) ; write(', ') ; afficher_joli(t2) ; write(') vaut ') ;
   afficher_joli(union(t1,t2)) ; writeln ;
   write('intersection(') ; afficher_joli(t1) ; write(', ') ; afficher_joli(t2) ; 
   write(') vaut ') ; afficher_joli(intersection(t1,t2)) ; writeln ;
   write('difference(') ; afficher_joli(t1) ; write(', ') ; afficher_joli(t2) ; 
   write(') vaut ') ;  afficher_joli(difference(t1,t2)) ; writeln ;

   // tests de nombre et complementaire
   writeln('tests de nombre et complementaire') ;
   write('nombre(') ; afficher_joli(t1) ; writeln(' vaut ',nombre(t1)) ;
   write('nombre(') ; afficher_joli(t2) ; writeln(' vaut ',nombre(t2)) ;
   write('complementaire(') ; afficher_joli(t1) ; write(' vaut ') ;
   afficher_joli(complementaire(t1)) ; writeln ;
   write('complementaire(') ; afficher_joli(t2) ; write(' vaut ') ;
   afficher_joli(complementaire(t2)) ; writeln ;
   writeln ;

   // tests de appartient et singleton
   // pour les tests d'appartenance je vais choisir 3 éléments au hasard et regardez si ils
   // sont dans t2, ensuite je calculerai "leur singleton"
   writeln('tests de appartient et singleton') ;
   for i := 1 to 3 do begin
      e := ELEMENT(random(12)) ;    // ATTENTION dépend du type ELEMENT
      write('appartient(') ; ecrire(e) ; write(', ') ; afficher_joli(t2) ; 
      writeln(') vaut ', appartient(e,t2)) ;
      write('singleton(') ; ecrire(e) ; write(') vaut ') ; afficher_joli(singleton(e)) ;
      writeln ;
   end {for} ;
   writeln ;

   // tests de prive et ajout
   // je fais la même chose qu'au dessus
   writeln('tests de prive et ajout') ;
   for i := 1 to 3 do begin
      e := ELEMENT(random(12)) ;    // ATTENTION dépend du type ELEMENT
      write('prive(') ; ecrire(e) ; write(', ') ; afficher_joli(t2) ; 
      write(') vaut ') ; afficher_joli(prive(e,t2)) ; writeln ;
      write('ajout(') ; ecrire(e) ; write(', ') ; afficher_joli(t2) ; 
      write(') vaut ') ; afficher_joli(ajout(e,t2)) ; writeln ;
   end {for} ;
end.


RESULTATS

tests des procédures d'affichage
mars juillet décembre
{mars, juillet, décembre}
                                // rien n'est affiché pour la partie_vide ici
{}                              // c'est mieux maintenant
janvier février mars avril mai juin juillet août septembre octobre novembre décembre
{janvier, février, mars, avril, mai, juin, juillet, août, septembre, octobre, novembre, décembre}

tests des 3 opérations union, intersection, difference
union({mars, juillet, décembre}, {février, mars, août, octobre}) vaut {février, mars, juillet, août, octobre, décembre}
intersection({mars, juillet, décembre}, {février, mars, août, octobre}) vaut {mars}
difference({mars, juillet, décembre}, {février, mars, août, octobre}) vaut {juillet, décembre}
tests de nombre et complementaire
nombre({mars, juillet, décembre} vaut 3
nombre({février, mars, août, octobre} vaut 4
complementaire({mars, juillet, décembre} vaut {janvier, février, avril, mai, juin, août, septembre, octobre, novembre}
complementaire({février, mars, août, octobre} vaut {janvier, avril, mai, juin, juillet, septembre, novembre, décembre}

tests de appartient et singleton
appartient(septembre, {mars, avril, mai, juin, décembre}) vaut FALSE
singleton(septembre) vaut {septembre}
appartient(octobre, {mars, avril, mai, juin, décembre}) vaut FALSE
singleton(octobre) vaut {octobre}
appartient(décembre, {mars, avril, mai, juin, décembre}) vaut TRUE
singleton(décembre) vaut {décembre}

tests de prive et ajout
prive(août, {mars, avril, mai, juin, décembre}) vaut {mars, avril, mai, juin, décembre}
ajout(août, {mars, avril, mai, juin, décembre}) vaut {mars, avril, mai, juin, août, décembre}
prive(mai, {mars, avril, mai, juin, décembre}) vaut {mars, avril, juin, décembre}
ajout(mai, {mars, avril, mai, juin, décembre}) vaut {mars, avril, mai, juin, décembre}
prive(juin, {mars, avril, mai, juin, décembre}) vaut {mars, avril, mai, décembre}
ajout(juin, {mars, avril, mai, juin, décembre}) vaut {mars, avril, mai, juin, décembre}
