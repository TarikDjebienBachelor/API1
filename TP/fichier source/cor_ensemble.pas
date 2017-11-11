{--------------------------------------------------------------------------------------------}
{-                                      cor_ensemble.pas                                    -}
{- Christian Lasou, 05/03/08                                                                -}
{- Correction du TP3                                                                        -}
{- OBJET : implantation d'un type ensembles                                                 -}
{--------------------------------------------------------------------------------------------}

PROGRAM ENSEMBLES;


   type MOIS = (JANVIER, FEVRIER, MARS, AVRIL, MAI, JUIN, JUILLET, AOUT, SEPTEMBRE, OCTOBRE,
                NOVEMBRE,DECEMBRE) ;
                // personnellement je pr�f�re mettre les constantes en majuscules
   const NOM_DU_MOIS : array [MOIS] of STRING  
             = ('janvier', 'f�vrier', 'mars', 'avril', 'mai', 'juin', 'juillet', 'ao�t',
                'septembre', 'octobre', 'novembre', 'd�cembre') ;  // j'ai ajout� les accents


   type ELEMENT = MOIS ;      // c'est un simple renommage
        ENSEMBLE = array[ELEMENT] of BOOLEAN ;

   ///////////////////////////////////////////////
   // DEUX OUTILS D'ENTREE-SORTIE POUR LES MOIS //
   ///////////////////////////////////////////////

   // contrainte d'utilisation:
   // l'utilisateur DOIT taper le mois en minuscule 
   // sans ajouter d'espace ni avant ni apr�s,
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

   procedure afficher(const x : ENSEMBLE) ;   // version all�g�e, celle du TP
   var i : ELEMENT ;                          // et je ne vais pas � la ligne apr�s
   begin
      for i := low(x) to high(x) do begin   // il faut utiliser low et high
         if x[i] then begin
            ecrire(i) ; write(' ') ; // � la fin on aura un espace mais on ne le voit pas
         end {if} ;
      end {for} ;
   end {afficher};

   procedure afficher_joli(const x : ENSEMBLE) ;   // version math�matique assez difficile
   var i,j : ELEMENT ;
   begin
      // je veux un affichage impeccable avec les accolades, les virgules mais sans une de
      // trop, donc
      write('{') ;  // la premi�re accolade
      // je cherche le premier �l�ment si il en a un
      i := low(ELEMENT) ;
      while (i < high(ELEMENT)) and not x[i] do begin    // remarquez, je m'arr�te quand je
         inc(i) ;                                        // suis sur high(ELEMENT)
      end {while} ;
      // ou bien i = high(ELEMENT) et x[i] est peut-�tre VRAI
      // ou bien i < high(ELEMENT) et x[i] est VRAI
      // De toute fa�on si x[i] est FAUX c'est l'ensemble vide, sinon i est le premier �l�ment
      if not x[i] then begin  // ensemble vide il ne reste qu'� fermer l'accolade
         write('}') ;
      end else begin // i est le premier �l�ment
         ecrire(i) ;
         // ensuite j'�cris les autres en les faisant pr�c�der de la virgule correspondante
         // sauf si i = high(ELEMENT) car succ(i) !!!
         if i < high(ELEMENT) then begin
            for j := succ(i) to high(x) do begin
               if x[j] then begin
                  write(', ') ; ecrire(j) ;
               end {if} ;
            end {for} ;
         end {if} ;
         // derri�re le dernier �l�ment je mets l'accolade
         write('}') ;
      end {if} ;
   end {afficher_joli};

   // fonction sans parametre dont le r�sultat est l'ensemble vide
   function partie_vide : ENSEMBLE;
   var e : ELEMENT ;
   begin
      // une premi�re id�e serait d'�crire
      // partie_vide := (FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,
      //                 FALSE,FALSE,FALSE,FALSE,FALSE,FALSE) ;
      // mais c'est refus� par le compilateur on peut d�clarer une constante de type tableau
      // en mettant sa valeur sous cette forme mais ce n'est pas une "valeur" qu'on peut
      // affecter � une variable (ou nom de fonction)
      // Qu'� cela ne tienne on peut d�clarer une constante PARTIE_VIDE
      // mais encore une fois ce serait maladroit car trop d�pendant du type ELEMENT (qui,
      // ici , sont des MOIS) au nombre de 12 mais qui pourrait �tre chang� par des LETTRES
      // au nombre de 26.
      // Donc il vaut mieux faire cette fonction partie_vide en utilisant une boucle
      for e := low(ELEMENT) to high(ELEMENT) do begin
         partie_vide[e] := FALSE ;
      end {for} ;
   end {partie_vide};

   // fonction sans param�tre dont le r�sultat est l'ensemble de tous
   //   les �l�ments du type ELEMENT.
   function partie_pleine : ENSEMBLE;
   var e : ELEMENT ;
   begin
      // On pourrait faire les m�mes remarques que pour partie_vide
      for e := low(ELEMENT) to high(ELEMENT) do begin
         partie_pleine[e] := TRUE ;
      end {for} ;
   end {partie_pleine};

   // fonction dont le r�sultat est l'ensemble des �l�ments qui
   //   appartiennent � a ou � b (ou les deux)
   function union(const a,b : ENSEMBLE): ENSEMBLE;
   var e : ELEMENT ;
   begin
      for e := low(ELEMENT) to high(ELEMENT) do begin
         union[e] := a[e] or b[e] ;
      end {for} ;
   end {union};

   // fonction dont le r�sultat est l'ensemble des �l�ments qui 
   //   appartiennent � a et � b 
   function intersection(const a,b:ENSEMBLE): ENSEMBLE;
   var e : ELEMENT ;
   begin
      for e := low(ELEMENT) to high(ELEMENT) do begin
         intersection[e] := a[e] and b[e] ;
      end {for} ;
   end {intersection};

   // fonction dont le r�sultat est l'ensemble des �l�ments de 
   // l'ensemble a qui n'appartiennent pas � b
   function difference(const a,b : ENSEMBLE): ENSEMBLE;
   var e : ELEMENT ;
   begin
      for e := low(ELEMENT) to high(ELEMENT) do begin
         difference[e] := a[e] and not b[e] ;
      end {for} ;
   end {difference};

   // fonction dont le r�sultat est le nombre d'�l�ments de 
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

   // fonction dont le r�sultat est l'ensemble des �l�ments 
   // de la partie_pleine qui n'appartiennent pas � a
   function complementaire(const a : ENSEMBLE): ENSEMBLE;
   begin
      complementaire := difference(partie_pleine,a) ;
   end {complementaire};

   // pr�dicat permettant de tester si x est un �l�ment de a 
   function appartient(const x : ELEMENT; const a : ENSEMBLE): BOOLEAN;
   begin
      appartient := a[x] ;
   end {appartient};

   // fonction dont le r�sultat est un ensemble contenant 
   // uniquement l'�l�ment x 
   function singleton(const x : ELEMENT) : ENSEMBLE;
   begin
      singleton := partie_vide ;
      singleton[x] := TRUE ;
   end {singleton};

   // fonction dont le r�sultat est un ensemble contenant tous les
   //   �l�ments de a sauf x  (il n'est pas n�cessaire que x 
   //   soit un �l�ment de a 
   function prive(const x : ELEMENT ; const a : ENSEMBLE):ENSEMBLE;
   begin
      prive := a ;
      prive[x] := FALSE ;
   end {prive};

   // fonction dont le r�sultat est un ensemble contenant tous 
   //  les �l�ments de a  et x (il n'est pas n�cessaire que 
   //  x ne soit pas un �l�ment de a)
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
   // totalement arbritraire, je choisis 5 �l�ments au hasard donc �ventuellement le m�me
   randomize ; // pour initialiser le g�n�rateur al�atoire
   t1 := partie_vide ;
   for i := 1 to 5 do begin
      t1[ELEMENT(random(12))] := TRUE ;    // ATTENTION d�pend du type ELEMENT
   end {for} ;

   // tests des proc�dures d'affichage
   writeln('tests des proc�dures d''affichage') ;
   afficher(t1) ; writeln ;
   afficher_joli(t1) ; writeln ;
   afficher(partie_vide) ; writeln ;
   afficher_joli(partie_vide) ; writeln ;
   afficher(partie_pleine) ; writeln ;
   afficher_joli(partie_pleine) ; writeln ;
   writeln ;

   // tests des 3 op�rations union, intersection, difference
   writeln('tests des 3 op�rations union, intersection, difference') ;
   // j'initialise t2 comme t1 mais en prenant 7 �l�ments au plus
   t2 := partie_vide ;
   for i := 1 to 5 do begin
      t2[ELEMENT(random(12))] := TRUE ;    // ATTENTION d�pend du type ELEMENT
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
   // pour les tests d'appartenance je vais choisir 3 �l�ments au hasard et regardez si ils
   // sont dans t2, ensuite je calculerai "leur singleton"
   writeln('tests de appartient et singleton') ;
   for i := 1 to 3 do begin
      e := ELEMENT(random(12)) ;    // ATTENTION d�pend du type ELEMENT
      write('appartient(') ; ecrire(e) ; write(', ') ; afficher_joli(t2) ; 
      writeln(') vaut ', appartient(e,t2)) ;
      write('singleton(') ; ecrire(e) ; write(') vaut ') ; afficher_joli(singleton(e)) ;
      writeln ;
   end {for} ;
   writeln ;

   // tests de prive et ajout
   // je fais la m�me chose qu'au dessus
   writeln('tests de prive et ajout') ;
   for i := 1 to 3 do begin
      e := ELEMENT(random(12)) ;    // ATTENTION d�pend du type ELEMENT
      write('prive(') ; ecrire(e) ; write(', ') ; afficher_joli(t2) ; 
      write(') vaut ') ; afficher_joli(prive(e,t2)) ; writeln ;
      write('ajout(') ; ecrire(e) ; write(', ') ; afficher_joli(t2) ; 
      write(') vaut ') ; afficher_joli(ajout(e,t2)) ; writeln ;
   end {for} ;
end.


RESULTATS

tests des proc�dures d'affichage
mars juillet d�cembre
{mars, juillet, d�cembre}
                                // rien n'est affich� pour la partie_vide ici
{}                              // c'est mieux maintenant
janvier f�vrier mars avril mai juin juillet ao�t septembre octobre novembre d�cembre
{janvier, f�vrier, mars, avril, mai, juin, juillet, ao�t, septembre, octobre, novembre, d�cembre}

tests des 3 op�rations union, intersection, difference
union({mars, juillet, d�cembre}, {f�vrier, mars, ao�t, octobre}) vaut {f�vrier, mars, juillet, ao�t, octobre, d�cembre}
intersection({mars, juillet, d�cembre}, {f�vrier, mars, ao�t, octobre}) vaut {mars}
difference({mars, juillet, d�cembre}, {f�vrier, mars, ao�t, octobre}) vaut {juillet, d�cembre}
tests de nombre et complementaire
nombre({mars, juillet, d�cembre} vaut 3
nombre({f�vrier, mars, ao�t, octobre} vaut 4
complementaire({mars, juillet, d�cembre} vaut {janvier, f�vrier, avril, mai, juin, ao�t, septembre, octobre, novembre}
complementaire({f�vrier, mars, ao�t, octobre} vaut {janvier, avril, mai, juin, juillet, septembre, novembre, d�cembre}

tests de appartient et singleton
appartient(septembre, {mars, avril, mai, juin, d�cembre}) vaut FALSE
singleton(septembre) vaut {septembre}
appartient(octobre, {mars, avril, mai, juin, d�cembre}) vaut FALSE
singleton(octobre) vaut {octobre}
appartient(d�cembre, {mars, avril, mai, juin, d�cembre}) vaut TRUE
singleton(d�cembre) vaut {d�cembre}

tests de prive et ajout
prive(ao�t, {mars, avril, mai, juin, d�cembre}) vaut {mars, avril, mai, juin, d�cembre}
ajout(ao�t, {mars, avril, mai, juin, d�cembre}) vaut {mars, avril, mai, juin, ao�t, d�cembre}
prive(mai, {mars, avril, mai, juin, d�cembre}) vaut {mars, avril, juin, d�cembre}
ajout(mai, {mars, avril, mai, juin, d�cembre}) vaut {mars, avril, mai, juin, d�cembre}
prive(juin, {mars, avril, mai, juin, d�cembre}) vaut {mars, avril, mai, d�cembre}
ajout(juin, {mars, avril, mai, juin, d�cembre}) vaut {mars, avril, mai, juin, d�cembre}
