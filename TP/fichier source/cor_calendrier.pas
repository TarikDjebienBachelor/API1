{--------------------------------------------------------------------------------------------}
{-                                    cor_calendrier.pas                                    -}
{- Christian Lasou, 03/03/08                                                                -}
{- Correction du TP2                                                                        -}
{- OBJET :                                                                                  -}
{-   1) types ordinaux                                                                      -}
{-   2) instruction Case.                                                                   -}
{-   3) mode de passage des param�tres (peu)                                                -}
{--------------------------------------------------------------------------------------------}
// 
program calendrier;

   type
      ANNEE       = 1532..9999;
        {1532 d�but du calendrier gr�gorien...}
        {pr�parons le bug de l'an 10000}
      NUMERO_MOIS = 1..12;
      MOIS        = (JANVIER,FEVRIER,MARS,AVRIL,MAI,JUIN,JUILLET,AOUT,SEPTEMBRE,OCTOBRE,
                     NOVEMBRE,DECEMBRE) ;
                    // personnellement je pr�f�re mettre les constantes en majuscules

   //------------------------
   // PROCEDURE : afficher_mois
   // OBJET :
   //   provoque l'affichage du mois
   //   pass� en param�tre. on ne souhaite
   //   pas qu'il y ait de retour � la ligne
   //   apr�s cet affichage.
   // EXEMPLE DE COMPORTEMENT ATTENDU :
   //   { X = janvier}
   //   afficher_mois(X); {affiche : janvier)
   // CONTRAINTE D'UTILISATION :
   //   aucune.
   procedure afficher_mois(const m:MOIS);  // m est une donn�e donc const
   begin
      case m of
         JANVIER   : write('janvier') ;
         FEVRIER   : write('f�vrier') ;
         MARS      : write('mars') ;
         AVRIL     : write('avril') ;
         MAI       : write('mai') ;
         JUIN      : write('juin') ;
         JUILLET   : write('juillet') ;
         AOUT      : write('ao�t') ;
         SEPTEMBRE : write('septembre') ;
         OCTOBRE   : write('octobre') ;
         NOVEMBRE  : write('novembre') ;
         DECEMBRE  : write('d�cembre') ;
      end {case} ;
   end {afficher_mois};
   //------------------------

   //------------------------
   // FONCTION : mois_suivant
   // OBJET :
   //   calcule le mois  qui suit un mois donn�.
   // EXEMPLE DE COMPORTEMENT ATTENDU :
   //   mois_suivant(decembre) vaut janvier
   //   mois_suivant(janvier) vaut fevrier
   // CONTRAINTE D'UTILISATION :
   //   aucune.
   function mois_suivant(const A:MOIS) : MOIS ; // pour une fonction et pour nous ce sera
   // var res:MOIS;  // on peut s'en passer     // toujours const et d'ailleurs moi je ne le
   begin                                        // mets pas
      if A = high(MOIS) then begin     // pr�f�rable � DECEMBRE (si on change les mois !!!)
         mois_suivant := low(MOIS) ;   // apr�s le dernier on a de nouveau le premier
      end else begin                   // succ fait tr�s bien les choses
         mois_suivant := succ(A) ;
      end {if} ;
      // mois_suivant:=res;
   end {mois_suivant};
   //------------------------

   //------------------------
   // PROCEDURE : passer_au_mois_suivant
   // OBJET :
   //   calcule le mois  qui suit un mois donn�.
   // EXEMPLE DE COMPORTEMENT ATTENDU :
   //   {X = decembre}
   //   passer_au_mois_suivant(X)
   //   {X = janvier}
   //   passe_au_mois_suivant(X)
   //   {X = fevrier}
   // CONTRAINTE D'UTILISATION :
   //   aucune.
   procedure passer_au_mois_suivant(var A:MOIS); // ic A est donn�e et r�sultat
   begin
      A := mois_suivant(A) ; // il suffit d'utiliser la fonction mois_suivant
   end {passer_au_mois_suivant};
   //------------------------


   //------------------------
   // FONCTION : mois_precedent
   // OBJET :
   //   calcule le mois  qui precede un mois donn�.
   // EXEMPLE DE COMPORTEMENT ATTENDU :
   //   mois_precedent(decembre) vaut novembre
   //   mois_precedent(janvier) vaut decembre
   // CONTRAINTE D'UTILISATION :
   //   aucune.
   function mois_precedent(const A:MOIS):MOIS;   // VOIR mois_suivant !!!
   // var res:MOIS;
   begin
      if A = low(MOIS) then begin
         mois_precedent := high(MOIS) ; // avant le premier c'est le dernier
      end else begin                    // pred fait tr�s bien les choses
         mois_precedent := pred(A) ;
      end {if} ;
      // mois_precedent:=res;
   end {mois_precedent};
   //------------------------

   //------------------------
   // FONCTION : numero_de_mois
   // OBJET :
   //   calcule le numero du mois
   // EXEMPLE DE COMPORTEMENT ATTENDU :
   //   numero_de_mois(janvier) vaut 1
   //   numero_de_mois(fevrier) vaut 2
   // CONTRAINTE D'UTILISATION :
   //   aucune.
   function numero_de_mois(const m:MOIS):NUMERO_MOIS;
   // var res : NUMERO_MOIS;  // inutile aussi
   begin
      numero_de_mois := ord(m)+1 ;
      // numero_de_mois:=res;
   end {numero_de_mois};
   //------------------------

   //------------------------
   // FONCTION : mois_de_numero
   // OBJET :
   //   calcule le mois � partir de son numero.
   // EXEMPLE DE COMPORTEMENT ATTENDU :
   //   mois_de_numero(1) vaut janvier
   //   mois_de_numero(2) vaut fevrier
   // CONTRAINTE D'UTILISATION :
   //   aucune.
   function mois_de_numero(const n:NUMERO_MOIS):MOIS;
   // var res:MOIS;   // idem
   begin
      mois_de_numero := MOIS(n-1) ;
      // mois_de_numero:=res;
   end {mois_de_numero};
   //------------------------

   //------------------------
   // PROCEDURE : lire_numero
   // OBJET :
   //   lit au clavier un entier entre
   //   1 et 12. et affecte le parametre
   //   avec le mois qui correspond � ce
   //   num�ro.
   // EXEMPLE DE COMPORTEMENT ATTENDU :
   //    { m = ?? }
   //    lire_numero(m); {l'utilisateur entre la valeur 1}
   //    { m = janvier}
   //    lire_numero(m); {l'utilisateur entre la valeur 3}
   //    { m = mars}
   // CONTRAINTE D'UTILISATION :
   //   Le num�ro entr� par l'utilisateur doit �tre
   //   un entier compris entre 1 et 12 au sens large.
   //   ( une exception risque de se d�clencher sinon)
   procedure lire_numero(out m: MOIS);   // cette fois m est r�sultat
   var n:NUMERO_MOIS;
   begin
      readln(n) ;
      m := mois_de_numero(n) ;
   end {lire_numero};
   //------------------------

   //------------------------
   // PROCEDURE : lire_mois
   // OBJET :
   //   lit au clavier une chaine de caractere  
   //   correspondant � un nom de mois. et affecte le parametre
   //   avec le mois qui correspond.
   // EXEMPLE DE COMPORTEMENT ATTENDU :
   //    { m = ?? }
   //    lire_mois(m); {l'utilisateur entre la valeur janvier}
   //    { m = janvier}
   //    lire_numero(m); {l'utilisateur entre la valeur mars}
   //    { m = mars}
   // CONTRAINTE D'UTILISATION :
   //   La donn�e entr�e par l'utilisateur doit �tre
   //   une chaine en minuscule repr�sentant un mois.
   //   (sinon le contenu de la variable m est indetermin�)
   procedure lire_mois(out m: MOIS);  // m est r�sultat
   var s : STRING ;
   begin
      readln(s) ;
         if      s = 'janvier'   then m := JANVIER      // pas de ";" devant un "else"
         else if s = 'f�vrier'   then m := FEVRIER
         else if s = 'mars'      then m := MARS         // remarquez la pr�sentation en
         else if s = 'avril'     then m := AVRIL        // colonnes pour plus de clart�
         else if s = 'mai'       then m := MAI
         else if s = 'juin'      then m := JUIN
         else if s = 'juillet'   then m := JUILLET
         else if s = 'ao�t'      then m := AOUT
         else if s = 'septembre' then m := SEPTEMBRE
         else if s = 'octobre'   then m := OCTOBRE
         else if s = 'novembre'  then m := NOVEMBRE
         else if s = 'd�cembre'  then m := DECEMBRE ;
   end {lire_mois};
   //------------------------

   //------------------------
   // FONCTION : longueur_normale
   // OBJET :
   //   calcule le nombre de jour d'un mois
   //   en supposant que l'ann�e en cours n'est pas
   //   bissextile.
   // EXEMPLE DE COMPORTEMENT ATTENDU :
   //   longueur_normale(janvier) vaut 31
   //   longueur_normale(fevrier) vaut 28
   //   longueur_normale(mars) vaut 31
   // CONTRAINTE D'UTILISATION :
   //   aucune.
   function longueur_normale(const m:MOIS):CARDINAL;
   // var res : CARDINAL;
   begin
      case m of
         FEVRIER                       : longueur_normale := 28 ;
         AVRIL,JUIN,SEPTEMBRE,NOVEMBRE : longueur_normale := 30 
         else                            longueur_normale := 31 ;
      end {case} ;
   end {longueur_normale};
   //------------------------


   //------------------------
   // FONCTION : est_divisible
   // OBJET :
   //   predicat permmettant de d�terminer
   //   si un entier est divisible par second entier
   // EXEMPLE DE COMPORTEMENT ATTENDU :
   //   est_divisible(3,4) vaut false
   //   est_divisible(24,4) vaut true
   // CONTRAINTE D'UTILISATION :
   //   le second entier doit �tre non nul !
   function est_divisible(const a,b:CARDINAL):BOOLEAN;
   begin
      est_divisible:=(a mod b )=0;
   end {est_divisible};
   //------------------------

   //------------------------
   // FONCTION : est_bissextile
   // OBJET :
   //   pr�dicat permettant de determiner
   //   si une ann�e est bissextile.
   // REGLE :
   //  sont bissextiles : 
   //   - les ann�es multiples de 400 ;
   //   - les ann�es multiples de 4 qui ne sont pas multiples de 100.
   //  les autres ann�es ne sont pas bissextile.
   // EXEMPLE DE COMPORTEMENT ATTENDU :
   //   est_bissextile(2008) vaut true
   //   est_bissextile(2006) vaut false
   //   est_bissextile(2100) vaut false
   //   est_bissextile(2000) vaut true
   // CONTRAINTE D'UTILISATION :
   //   aucune.
   function est_bissextile(const a:ANNEE ):BOOLEAN;
   begin
      est_bissextile :=      est_divisible(a,400) 
                         or (est_divisible(a,4) and not est_divisible(a,100));
   end {est_bissextile};
   //------------------------

   var  m:MOIS;

BEGIN

   // tests.
   // test exhaustif de la procedure afficher_mois
   writeln('voici la liste des mois s�par�s par des virgules et termin�e par un point : ');
   for m := low(MOIS) to pred(high(MOIS)) do
   begin
      afficher_mois(m);write(',');
   end {for};
   afficher_mois(high(MOIS));
   writeln('.');

   // test exhaustif de la fonction longueur_normale
   writeln('voici le test de la fonction longueur_normale');
   for m := low(MOIS) to high(MOIS) do
   begin
      afficher_mois(m); writeln(' : ',longueur_normale(m) );
   end {for};

   // autres tests � compl�ter.

   // test de lire_numero
   writeln('voici le test de la proc�dure lire_numero');
   write('tapez le num�ro d''un mois (entre 1 et 12) : ') ; lire_numero(m) ; 
   write('vous avez choisi le mois de ') ; afficher_mois(m) ; writeln ;

   // test de lire_mois
   writeln('voici le test de la proc�dure lire_mois');
   write('tapez le nom d''un mois (avec les accents) : ') ; lire_mois(m) ; 
   write('vous avez choisi le mois de ') ; afficher_mois(m) ; writeln ;

END.

RESULTATS

voici la liste des mois s�par�s par des virgules et termin�e par un point :
janvier,f�vrier,mars,avril,mai,juin,juillet,ao�t,septembre,octobre,novembre,d�cembre.
voici le test de la fonction longueur_normale
janvier : 31
f�vrier : 28
mars : 31
avril : 30
mai : 31
juin : 30
juillet : 31
ao�t : 31
septembre : 30
octobre : 31
novembre : 30
d�cembre : 31
voici le test de la proc�dure lire_numero
tapez le num�ro d'un mois (entre 1 et 12) : 4    // c'est l'utilisateur qui a tap� 4
vous avez choisi le mois de avril
voici le test de la proc�dure lire_mois
tapez le nom d'un mois (avec les accents) : ao�t  // c'est l'utilisateur qui a tap� ao�t
vous avez choisi le mois de ao�t
