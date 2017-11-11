{--------------------------------------------------------------------------------------------}
{-                                    td3_tableaux_cor.pas                                  -}
{- Christian Lasou, 06/05/09                                                                -}
{- Corrections des exercices du TD3 sur les tableaux                                        -}
{- Chaque procédure correspond à un exercice                                                -}
{--------------------------------------------------------------------------------------------}
program td3_tableaux_cor ;
{$X-}   // pour interdire l'usage de fonctions comme instructions

uses sysutils ;  // pour pouvoir utiliser le "temps"

//////////////////////
// RAPPELS DE COURS //
//////////////////////

// EN THÉORIE
// °°°°°°°°°°

// Un tableau (à une dimension) est une structure de donnée qui permet de regrouper des valeurs
// de même type, ces valeurs étant directement accessible grâce à une indexation.
// Voici une représentation théorique d'un tableau de 8 valeurs de type chaîne de caractères
// indexé (ou indicé) par des caractères.
//                    +------------------------------------------------------+
//                    | toto | zoo  | bibi |  pi  |  et  | momo | truc | bibi|
//                    +------------------------------------------------------+
//     les indices -->   C      D       E     F      G       H      I     J
// A priori les valeurs contenues dans le tableau peuvent être de n'importe quel type
// mais les indices doivent être absolument d'un type ordinal
// Les emplacements où se trouvent les valeurs dans le tableau s'appellent case
// dans notre exemple la case d'indice G contient la valeur et.
// On a representé notre tableau sous forme de 8 cases disposées en ligne mais bien sûr
// en mémoire ces emplacements peuvent très bien être n'importe où et pas obligatoirement
// contigües

// EN PRATIQUE EN PASCAL
//°°°°°°°°°°°°°°°°°°°°°°

// En Pascal la déclaration d'un type tableau se fait à l'aide du mot-clé array
// syntaxe :
//           type <NOM_TYPE> = array[<les indices>] of <TYPE_VALEURS> ;
// <les indices> peut être un intervalle d'un type connu     1..8  ou 'C'..'J'  ou
//          FEVRIER..OCTOBRE    (si on a déclaré auparavant un type MOIS
// mais ce peut être tout un type ordinal par exemple BOOLEAN (2 cases dans ce cas) ou
// CHAR ou JOUR (si on a déclaré un type JOUR)
// Voici quelques exemples :
   type TABLEAU_BOOLEAN = array[-7..12] of BOOLEAN ;  // tableau de 20 booléens
        TABLEAU_CHAINES = array['C'..'J'] of STRING ; // tableau de 8 chaînes de caractères
        JOUR =(LUNDI,MARDI,MERCREDI,JEUDI,VENDREDI,SAMEDI,DIMANCHE) ;
        TABLEAU_CARDINAL = array[JOUR] of CARDINAL ;  // tableau de 7 naturels
// On peut aussi se contenter de déclarer directement une variable de type tableau sans
// déclarer de type mais cette variable a un type anonyme auquel on ne peut se référer (par
// exemple lors d'un passage de paramètre pour une fonction ou procédure) et aucune autre
// variable n'aura le même type sauf si elle a été déclarée en même temps
// exemples :
   var t1 : array[2..7] of CHAR ;    // t1 et t2 ne sont pas de même type
       t2 : array[2..7] of CHAR ;    // et leur type est anonyme
       t3,t4 :array[-5..5] of STRING ;   // ici t3 et t4 sont de même type
// Quand on a déclaré un type tableau on peut bien sûr déclarer des variables et des constantes
// de ce type (contrairement aux déclarations de constantes de type simple où le type est fixé
// par la valeur, on doit pour les constantes de type tableau préciser le type avant la valeur)
// exemples :
   var tab_bool : TABLEAU_BOOLEAN ;
   const EXEMPLE : TABLEAU_CHAINES = ('toto','zoo','bibi','pi','et', 'momo', 'truc', 'bibi') ;
         // c'est le tableau donné en exemple dans la partie théorique

// La nécessité de justifier le type provient du fait qu'on pourrait avoir un autre type contenant
// 8 valeurs de type STRING mais avec des autres indices

// Que peut-on faire avec des tableaux ?
// On peut faire des affectations globales :
//       t3 := t4 ;     // on recopie toutes les valeurs de t4 dans t3
// il faut bien sûr que les deux tableaux soient de même type
//       t1 := t2 ;    serait refusé par le compilateur
// Par contre on ne peut pas faire de comparaison globale (certains langages autres que Pascal le
// permettent) :
//    if t3 = t4 then ... est refusé
// Evidemment, comme pour tout nouveau type, les entrées/sorties n'existent pas et doivent être
// réécrites :
// readln(t1)   ou  write(t1)  sont refusés
// Comme on l'a dit au début on a un accès direct à une valeur grâce à son indice, cette valeur
// ou plutôt case doit être considérée comme une variable du type des éléments du tableau
// La syntaxe de désignation de cette pseudo-variable (ou constante) est
//                              <nom_variable>[<nom_indice>]     (utilisation de crochets)
// Exemples :  t1[3] désigne la seconde case du tableau t1 (ou sa valeur)
//     l'affectation  t1[3] := 2*t1[3] consisterait à doubler la valeur contenue dans cette case
//  write(EXEMPLE['J'])   provoquerait l'affichage de la chaîne 'bibi' et bien sûr l'affectation
//    EXEMPLE['J'] := 'rien'     serait refusé car EXEMPLE est une constante



// ON PASSE MAINTENANT AUX EXERCICES DU TD

   // Chaque exercice fera l'objet d'une procédure

////////////////
// EXERCICE 1 //
////////////////

   procedure exercice_1 ;
   // Déclarer des tableaux

      // Question 1

      // Première option : mois en chiffres
      type MOIS1 = 1..12 ;
           T_BUDGET1 = array[MOIS1] of REAL ;

      var depensesVoiture1, depensesMaison1 : T_BUDGET1 ;

      // Seconde option : mois en lettres
      type MOIS2 = (JANVIER,FEVRIER,MARS,AVRIL,MAI,JUIN,JUILLET,
                    AOUT,SEPTEMBRE,OCTOBRE,NOVEMBRE,DECEMBRE) ;
           T_BUDGET2 = array[MOIS2] of REAL ;

      var depensesVoiture2, depensesMaison2 : T_BUDGET2 ;

      // Question 2
      // je fais 2 versions aussi mais remarquez que seuls les noms des types changent
      // donc en fait c'est bien la même procédure dans les deux cas

      procedure initialiserBudget1(out b : T_BUDGET1) ;
      var m : MOIS1 ;
      begin
         for m := low(b) to high(b) do begin
            b[m] := 0 ;
         end {for} ;
      end {initialiserBudget1} ;

      procedure initialiserBudget2(out b : T_BUDGET2) ;
      var m : MOIS2 ;
      begin
         for m := low(b) to high(b) do begin
            b[m] := 0 ;
         end {for} ;
      end {initialiserBudget2} ;

      // Question 3
      // même remarque que pour la question 2

      function budgetMoyen1(b : T_BUDGET1) : REAL ;
      var m : MOIS1 ;
          somme : REAL ;
      begin
         somme := 0 ;
         for m := low(b) to high(b) do begin
            somme := somme + b[m] ;
         end {for} ;
         budgetMoyen1 := somme/12 ;
      end {budgetMoyen1} ;

      function budgetMoyen2(b : T_BUDGET2) : REAL ;
      var m : MOIS2 ;
          somme : REAL ;
      begin
         somme := 0 ;
         for m := low(b) to high(b) do begin
            somme := somme + b[m] ;
         end {for} ;
         budgetMoyen2 := somme/12 ;
      end {budgetMoyen2} ;

      // pour tester ces fonctions je crée deux constantes de type T_BUDGET1 et T_BUDGET2

      const BUDGET1 : T_BUDGET1 = (100,20,50,23,47,58,120,49,57,14,11,89) ;
            BUDGET2 : T_BUDGET2 = (100,20,50,23,47,58,120,49,57,14,11,89) ;

      // Question 4

      const N = 5 ;          // N est le nombre d'octets d'un OBJET
      type BIT   = BOOLEAN ;   // on aurait aussi pû mettre 0..1
           OCTET = array[1..8] of BIT ;
           OBJET1 = array[1..N] of OCTET ;   // un tableau de N OCTETs
           OBJET2 = array[1..8*N] of BIT ;   // un tableau de 8*N BITs

   begin
      writeln('EXERCICE 1') ;
      writeln('question 2') ;
      writeln('vérifions qu''après initialiserBudget le budget est bien à 0') ;
      writeln('je le fais pour depensesVoiture1 et depenseVoiture2') ;
      initialiserBudget1(depensesVoiture1) ;
      initialiserBudget2(depensesVoiture2) ;
      writeln('maintenant depensesVoiture1[10] vaut ', depensesVoiture1[10]) ;
      writeln('et depensesVoiture2[MAI] vaut ', depensesVoiture2[MAI]) ;
      writeln('question 3') ;
      writeln('budgetMoyen1(BUDGET1) vaut ', budgetMoyen1(BUDGET1)) ;
      writeln('budgetMoyen2(BUDGET2) vaut ', budgetMoyen2(BUDGET2)) ;
      writeln('question 4') ;
      writeln('rien à faire si ce n''est que la validation des déclarations de types') ;
   end {exercice_1} ;

////////////////
// EXERCICE 2 //
////////////////

   procedure exercice_2 ;
   // Manipulations standards sur les tableaux

      // Les déclarations pour le type TABLEAU

      type INDICE  = -5..3 ;  // j'ai mis n'importe quoi
           ELEMENT = JOUR ;   // j'ai repris le type JOUR du début
           TABLEAU = array[INDICE] of ELEMENT ;

      ////////////////
      // Question 1 //
      ////////////////

      // La fonction max
      {+++++++++++++++++}

      function max(t : TABLEAU) : ELEMENT ;
      var res : ELEMENT ;
          i : INDICE ;
      begin
         res := t[low(t)] ;   // l'ELEMENT de la première case
         for i := succ(low(t)) to high(t) do begin
            if res < t[i] then begin
               res := t[i] ;
            end {if} ;
         end {for} ;
         max := res ;
      end {max} ;

      // La fonction secondMax
      {+++++++++++++++++++++++}
      // Ici c'est ambigüe selon qu'on accepte que secondMax peut être égal ou non à Max
      // de plus dans chacune des deux interprétations on a plusieurs solutions

      // Je prend la première interprétation : secondMax peut être égal à Max
      // (il suffit que max se trouve deux fois dans le tableau)

      // Voici une première solution
      function secondMax1(t : TABLEAU) : ELEMENT ;
      var m,res : ELEMENT ;
          i,j : INDICE ;
      begin
         // je cherche le max avec la fonction max
         m := max(t) ;
         // Ensuite je parcours le tableau t jusqu'au premier max
         i := low(t) ;
         while t[i] < m do begin
            inc(i) ;
         end {while} ;
         // i est l'indice du premier max
         // je cherche maintenant l'indice du second max en évitant le i
         if i = low(t) then begin   // je cherche dans la fin du tableau
            res := t[low(t)+1] ;
            for j := low(t)+2 to high(t) do begin
               if t[j] > res then begin
                  res := t[j] ;
               end {if} ;
            end {for} ;
         end else begin  // je cherche devant et derrière le i
            res := t[low(t)] ;
            for j := low(t)+1 to i-1 do begin
               if t[j] > res then begin
                  res := t[j] ;
               end {if} ;
            end {for} ;
            for j := i+1 to high(t) do begin
               if t[j] > res then begin
                  res := t[j] ;
               end {if} ;
            end {for} ;
         end {if} ;
         // le résultat c'est res
         secondMax1 := res ;
      end {secondMax1} ;

      // La première solution a l'inconvénient de deux parcours
      // le premier pour la recherche du max et le second pour le secondMax
      // Voici une seconde version où on ne fait qu'un parcours
      function secondMax2(t : TABLEAU) : ELEMENT ;
      var m,res : ELEMENT ;  // m sera le max et res le secondMax
          i : INDICE ;
      begin
         // je fixe m et res avec les deux premiers éléments de t
         if t[low(t)] < t[low(t)+1] then begin
            m := t[low(t)+1] ; res := t[low(t)] ;
         end else begin
            m := t[low(t)] ; res := t[low(t)+1] ;
         end {if} ;
         // Ensuite je parcours le reste du tableau t
         for i := low(t)+2 to high(t) do begin
            if t[i] > m then begin  // c'est le nouveau m et l'ancien m devient res
               res := m ; m := t[i] ;
            end else begin
               if t[i] > res then begin  // c'est le nouveau res mais m ne change pas
                  res := t[i] ;
               end {if} ;   // sinon rien à faire
            end {if} ;
         end {for} ;
         // le résultat c'est res
         secondMax2 := res ;
      end {secondMax2} ;

      // Je prend maintenant la seconde interprétation : secondMax ne peut pas être égal à Max
      // (même si max se trouve deux fois dans le tableau)

      // Voici une première solution
      function secondMax3(t : TABLEAU) : ELEMENT ;
      var m,res : ELEMENT ;
          i,j : INDICE ;
      begin
         // je cherche le max avec la fonction max
         m := max(t) ;
         // Ensuite je recherche le premier élément différent de max
         i := low(t) ;
         while (i <= high(t)) and (t[i] = m) do begin
            inc(i) ;
         end {while} ;
         // i est l'indice du premier élément < m ou i = hight(t)+1
         if i <= high(t) then begin
            res := t[i] ;
            for j := i+1 to high(t) do begin
               if (t[j] > res) and (t[j] < m) then begin
                  res := t[j] ;
               end {if} ;
            end {for} ;
         end {if} ;   // sinon il n'y a pas de secondMax
         // le résultat c'est res si il y a un second max
         secondMax3 := res ;
      end {secondMax3} ;

      // La première solution a l'inconvénient de deux parcours
      // le premier pour la recherche du max et le second pour le secondMax
      // Voici une seconde version où on ne fait qu'un parcours
      function secondMax4(t : TABLEAU) : ELEMENT ;
      var m,res : ELEMENT ;  // m sera le max et res le secondMax
          i,j : INDICE ;
      begin
         // je fixe m et res avec le premier élément de t
         // et le premier suivant différent
         i := low(t)+1 ;
         while (i <= high(t)) and (t[i] = t[low(t)]) do begin
            inc(i) ;
         end {while} ;
         if i <= high(t) then begin   // il y a un second max
            if t[low(t)] < t[i] then begin
               m := t[i] ; res := t[low(t)] ;
            end else begin
               m := t[low(t)] ; res := t[i] ;
            end {if} ;
            // Ensuite je parcours le reste du tableau t
            for j := i+1 to high(t) do begin
               if t[j] > m then begin  // c'est le nouveau m et l'ancien m devient res
                  res := m ; m := t[j] ;
               end else begin
                  if (t[j] > res) and (t[j] < m) then begin  // c'est le nouveau res mais m ne change pas
                     res := t[j] ;
                  end {if} ;   // sinon rien à faire
               end {if} ;
            end {for} ;
         end {if} ;   // sinon pas de second max
         // le résultat c'est res
         secondMax4 := res ;
      end {secondMax4} ;

      // La fonction miroir
      {++++++++++++++++++++}

      // Ici aussi il y a plusieurs manières de faire
      // en voici quelques-unes

      function miroir1(t : TABLEAU) : TABLEAU ;
      var i,j : INDICE ;
          res : TABLEAU ;  // un tableau auxiliaire
      begin
         j := high(t) ;    // j'utilise un indice auxiliaire
         for i := low(t) to high(t) do begin   // boucle ascendante
            res[i] := t[j] ;
            if j<> low(t) then begin 
               j := j-1 ;
            end {if} ;
         end {for} ;
         miroir1 := res ; // affectation finale unique
      end {miroir1} ;

      function miroir2(t : TABLEAU) : TABLEAU ;
      var i : INDICE ;  // un seul indice
      begin
         for i := high(t) downto low(t) do begin   // boucle descendante
            miroir2[i] := t[low(t)+high(t)-i] ;  // affectation finale par "morceau"
         end {for} ;
      end {miroir2} ;

      // Pour pouvoir tester mes fonctions j'ai besoin de procédures d'affichage pour
      // les types ELEMENT et TABLEAU

      procedure afficherELEMENT(const e : ELEMENT) ;    // remarquez le passage de paramètre
      begin
         case e of
            LUNDI    : write('lundi') ;
            MARDI    : write('mardi') ;
            MERCREDI : write('mercredi') ;
            JEUDI    : write('jeudi') ;
            VENDREDI : write('vendredi') ;
            SAMEDI   : write('samedi')      // jamais de ";" devant un "else"
         else  //  c'est obligatoirement DIMANCHE
            write('dimanche') ;
         end {case} ;
      end {afficherELEMENT} ;

      procedure afficherTABLEAU(const t : TABLEAU) ;
      // je fais quelquechose de simple
      var i : INDICE ;
      begin
         for i := low(t) to high(t) do begin
            afficherELEMENT(t[i]) ; write(' ') ;  // un espace pour séparer
         end {for} ;
      end {afficherTABLEAU} ;

      // Une constante pour tester mes fonctions
      // je préfère déclarer un constante typée plutôt qu'une variable que je devrais initialiser
      // et d'ailleurs j'en déclare 2
      // la première a deux samedi, la seconde un seul
      const TABLO1 : TABLEAU = (MARDI,MERCREDI,SAMEDI,MARDI,JEUDI,SAMEDI,LUNDI,LUNDI,MARDI) ;
            TABLO2 : TABLEAU = (MARDI,MERCREDI,MARDI,MARDI,JEUDI,SAMEDI,LUNDI,LUNDI,MARDI) ;

      procedure question_1 ;
      begin
         write('TABLO1 vaut : ') ; afficherTABLEAU(TABLO1) ; writeln ;
         write('TABLO2 vaut : ') ; afficherTABLEAU(TABLO2) ; writeln ;
         writeln('Pour la fonction Max') ;
         write('max(TABLO1) vaut : ') ; afficherELEMENT(max(TABLO1)) ; writeln ;
         write('max(TABLO2) vaut : ') ; afficherELEMENT(max(TABLO2)) ; writeln ;
         writeln('Pour la fonction secondMax') ;
         write('secondMax1(TABLO1) vaut : ') ; afficherELEMENT(secondMax1(TABLO1)) ; writeln ;
         write('secondMax1(TABLO2) vaut : ') ; afficherELEMENT(secondMax1(TABLO2)) ; writeln ;
         write('secondMax2(TABLO1) vaut : ') ; afficherELEMENT(secondMax2(TABLO1)) ; writeln ;
         write('secondMax2(TABLO2) vaut : ') ; afficherELEMENT(secondMax2(TABLO2)) ; writeln ;
         write('secondMax3(TABLO1) vaut : ') ; afficherELEMENT(secondMax3(TABLO1)) ; writeln ;
         write('secondMax3(TABLO2) vaut : ') ; afficherELEMENT(secondMax3(TABLO2)) ; writeln ;
         write('secondMax4(TABLO1) vaut : ') ; afficherELEMENT(secondMax4(TABLO1)) ; writeln ;
         write('secondMax4(TABLO2) vaut : ') ; afficherELEMENT(secondMax4(TABLO2)) ; writeln ;
         writeln('Pour la fonction miroir') ;
         write('mroir1(TABLO1) vaut : ') ; afficherTABLEAU(miroir1(TABLO1)) ; writeln ;
         write('mroir2(TABLO1) vaut : ') ; afficherTABLEAU(miroir2(TABLO1)) ; writeln ;
         write('mroir1(TABLO2) vaut : ') ; afficherTABLEAU(miroir1(TABLO2)) ; writeln ;
         write('mroir2(TABLO2) vaut : ') ; afficherTABLEAU(miroir2(TABLO2)) ; writeln ;
      end {question_1} ;

      ////////////////
      // Question 2 //
      ////////////////

      // La procédure retourner

      // Version 1 : en utilisant miroir
      procedure retourner1(var t : TABLEAU) ;    // remarquez le mode de passage du paramètre
      begin
         t := miroir2(t) ;   // j'ai pris miroir2
      end {retourner1} ;     // vous pouvez voir que c'est très court !!!

      // Version 2 : sans utiliser miroir
      // On remarque que "retourner" un tableau revient à faire une symétrie par rapport à son milieu
      // ici aussi on a plusieurs manières de s'yn prendre, en voici deux

      procedure retourner2_v1(var t : TABLEAU) ;
      var i,j : INDICE ;
          k : CARDINAL ;
          m : ELEMENT ;   // mémoire pour l'échange
      begin
         i := low(t) ; j := high(t) ;
         for k := 1 to length(t) div 2 do begin // échanger 2 cases symétriques
            // je fais l'échange
            m := t[i] ; t[i] := t[j] ; t[j] := m ;
            // je mets à jour i et j pour le tour suivant
            i := i+1 ; j := j-1 ;
         end {for} ;
      end {retourner2_v1} ;

      procedure retourner2_v2(var t : TABLEAU) ;
      var i,j : INDICE ;
          k : CARDINAL ;
          m : ELEMENT ;   // mémoire pour l'échange
      begin
         for i := low(t) to (low(t)+high(t)) div 2 do begin // échanger 2 cases symétriques
            // je fais l'échange
            m := t[i] ; t[i] := t[low(t)+high(t)-i] ; t[low(t)+high(t)-i] := m ;
         end {for} ;
      end {retourner2_v2} ;

      // Quelle est la version la plus efficace 1 ou 2
      // Si la taille du tableau est n
      // Avec la version 1 qui utilise miroir on fait n affectations d'éléments dans la fonction
      // miroir, et n affectations dans t := miroir(t) donc 2*n affectations en tout
      // Avec la version 2 (symétrie) chaque échange coûte 3 affectations mais on fait n/2 échanges
      // donc en tout 1,5*n affectations ce qui est moins que 2*n
      // La seconde version est donc meilleure

      procedure question_2 ;
      var t : TABLEAU ;
      begin
         writeln('Pour la procedure retourner1') ;
         t := TABLO1 ;
         write('avant retourner1(t), t vaut : ') ; afficherTABLEAU(t) ; writeln ;
         retourner1(t) ;
         write('après retourner1(t), t vaut : ') ; afficherTABLEAU(t) ; writeln ;
         writeln('Pour la procedure retourner2_v1') ;
         t := TABLO1 ;
         write('avant retourner2_v1(t), t vaut : ') ; afficherTABLEAU(t) ; writeln ;
         retourner2_v1(t) ;
         write('après retourner2_v1(t), t vaut : ') ; afficherTABLEAU(t) ; writeln ;
         writeln('Pour la procedure retourner2_v2') ;
         t := TABLO1 ;
         write('avant retourner2_v2(t), t vaut : ') ; afficherTABLEAU(t) ; writeln ;
         retourner2_v2(t) ;
         write('après retourner2_v2(t), t vaut : ') ; afficherTABLEAU(t) ; writeln ;
      end {question_2} ;

   begin
      writeln('EXERCICE 2') ;
      writeln('question 1') ;
      question_1 ;
      writeln('question 2') ;
      question_2 ;
   end {exercice_2} ;

///////////////////////////////////////
// EXERCICE 3 : CRIBLE D'ÉRATHOSTÈNE //
///////////////////////////////////////

   procedure exercice_3 ;
   // Le but est de trouver un algorithme efficace pour voir si un naturel est premier ou non
   // Donnons d'abord des algorithmes simples

      // Première version : je pars de la définition (sans réfléchir)
      // Un naturel est premier si et seulement si il a deux diviseurs exactement 1 et lui-même
      // (en particulier 1 n'est pas premier)
      // Donc si je peux trouver un diviseur de n entre 2 et n-1 alors n n'est pas premier
      function premier_1(n : CARDINAL) : BOOLEAN ;
      var d : CARDINAL ;
      begin
         // pour 1 et 2 je traite à part
         case n of
            1 : premier_1 := FALSE ;
            2 : premier_1 := TRUE ;
         else
            d := 2 ;
            while (n mod d <> 0) and (d < n-1) do begin
               d := d+1 ;
            end {while} ;
            premier_1 := (n mod d <> 0) ;
         end {case} ;
      end {premier_1} ;

      // Seconde version : je pars de la définition (en réfléchissant)
      // Si je peux trouver un diviseur de n entre 2 et n-1 alors il y en a au moins un
      // entre 2 et p  (avec p = racine carrée de n), donc on peut limiter notre boucle
      // à d*d <= n au lieu de d < n-1
      function premier_2(n : CARDINAL) : BOOLEAN ;
      var d : CARDINAL ;
      begin
         // pour 1 et 2 je traite à part
         case n of
            1 : premier_2 := FALSE ;
            2 : premier_2 := TRUE ;
         else
            d := 2 ;
            while (n mod d <> 0) and (d*d <= n) do begin
               d := d+1 ;
            end {while} ;
            premier_2 := (n mod d <> 0) ;
         end {case} ;
      end {premier_2} ;

      // Troisième version : en fait on peut limiter les tests aux nombres premiers
      // si n n'est pas divisible par 2 ce n'est pas utile de regarder si il est 
      // divisible par un autre nombre pair, même chose si il n'est pas divisible
      // par 3 il n'est pas nécessaire de voir sdi il'est par un autre mutiple de 3
      // En fait un nombre peut être premier si il est du type 6k+1 ou 6k+5
      // car 6k, 6k+2, 6k+3, 6k+4 ne peuvent pas être premiers donc sur 6 nombres
      // on ne fait que 2 tests
      // La suite des nombres premiers est
      // 2, 3, 5,7, 11, 13, 17, 19, 23, (25), 29, 31, (35), 37, 41, 43, 47 etc
      // on voit bien qu'à partie de 5 on augmente alternativement de 2 puis de 4
      // et encore dans certains cas ça ne marche pas (25 et 35)
      function premier_3(n : CARDINAL) : BOOLEAN ;
      var d : CARDINAL ;
          plus2 : BOOLEAN ;  // permettra de voir si il faut augmenter de 2 ou 4
      begin
         // pour 1, 2, 3 et 5 je traite à part
         case n of
            1 : premier_3 := FALSE ;
            2 : premier_3 := TRUE ;
            3 : premier_3 := TRUE ;
            5 : premier_3 := TRUE ;
         else
            if n mod 2 = 0 then begin
               premier_3 := FALSE ;
            end else begin
               if n mod 3 = 0 then begin
                  premier_3 := FALSE ;
               end else begin
                  d := 5 ; plus2 := TRUE ;
                  while (n mod d <> 0) and (d*d <= n) do begin
                     if plus2 then begin
                        d := d+2 ; plus2 := FALSE ;
                     end else begin 
                        d := d+4 ; plus2 := TRUE ;
                     end {if} ;
                  end {while} ;
                  premier_3 := (n mod d <> 0) ;
               end {if} ;
            end {if} ;
         end {case} ;
      end {premier_3} ;

      // Il existe encore des algorithmes beaucoup plus puissants basés
      // sur des tests probabilistes mais je n'en parle pas car trop
      // compliqués pour nous (si ça vous intéresse faites une recherche
      // sur test de Rabin)

      // Je passe au crible d'Érathostène
      procedure Erathostene ;
      // je cherche tous les nombres premiers entre 2 et N
      // je sais que 1 n'est pas premier

         // Je définis N
         const N = 10000 ;

         // la structure de donnée
         type TAB_PREMIERS = array[2..N] of BOOLEAN ;  // TRUE <=> premiers

         // Initialisation du tableau
         procedure initialiser(out t : TAB_PREMIERS) ;
         var i : 2..N ;
         begin
            for i := 2 to N do begin
               t[i] := TRUE ;     // aucun nombre n'est barré
            end {for} ;
         end {initialiser} ;

         // traitement d'un nombre non barré (donc premier)
         procedure traiterNombre(var t : TAB_PREMIERS ; const p : CARDINAL) ;
         // C.U. p n'est pas barré (t[p] vaut TRUE)
         var j : CARDINAL ;
         begin
            j := p*p ;   // le premier multiple que je barre est p²
            while j <= N do begin
               t[j] := FALSE ;
               j := j+p ;    // c'est le multiple suivant
            end {while} ;
         end {traiterNombre} ;

         // traitement complet du tableau
         procedure traiterTout(var t : TAB_PREMIERS) ;
         // Je suppose que t a été initialisé avant
         // sinon il faudra mettre t en sortie (out) et mettre l'initialisation
         // comme première instruction
         var i : 2..N ;
         begin
            for i := 2 to N do begin
               if t[i] then begin   // i est premier
                  traiterNombre(t,i) ;
               end {if} ; // sinon rien à faire
            end {for} ;
         end {traiterTout} ;

         procedure afficherPremiers(const t : TAB_PREMIERS) ;
         var i : 2..N ;
         begin
            for i := 2 to N do begin
               if t[i] then begin   // i est premier
                  write(i, ' ') ;
               end {if} ;
            end {for} ;
         end {afficherPremiers} ;

         var premiers : TAB_PREMIERS ;

      begin
         // initialisation
         initialiser(premiers) ;
         // calcul des nombres premiers
         traiterTout(premiers) ;
         // affichage
   //      afficherPremiers(premiers) ;   // en commentaire pour comparer avec premier_3
      end {Erathostène} ;

      var i,j : CARDINAL ;
          b : BOOLEAN ;
          deb, fin : TDateTime ;

   begin
(*      writeln('EXERCICE 3') ;
      // tests de premier_1
      writeln('// tests de premier_1') ;
      writeln('premier_1(1) vaut ', premier_1(1)) ;
      writeln('premier_1(2) vaut ', premier_1(2)) ;
      writeln('premier_1(17) vaut ', premier_1(17)) ;
      writeln('premier_1(21) vaut ', premier_1(21)) ;
      writeln('premier_1(21773) vaut ', premier_1(21773)) ;
      writeln('premier_1(21777) vaut ', premier_1(21777)) ;

      // tests de premier_2
      writeln('// tests de premier_2') ;
      writeln('premier_2(1) vaut ', premier_2(1)) ;
      writeln('premier_2(2) vaut ', premier_2(2)) ;
      writeln('premier_2(17) vaut ', premier_2(17)) ;
      writeln('premier_2(21) vaut ', premier_2(21)) ;
      writeln('premier_2(21773) vaut ', premier_2(21773)) ;
      writeln('premier_2(21777) vaut ', premier_2(21777)) ;

      // Comparaison entre premier_1 et premier_2
      writeln('// Comparaison entre premier_1 et premier_2') ;
      writeln('je calcule 10000 fois premier_1(21773) et premier_2(21773)') ;
      writeln('pour premier_1(21773)') ;
      for i := 1 to 10000 do begin
         b := premier_1(21773) ;
      end {for} ;
      writeln('fini') ;
      writeln('pour premier_2(21773)') ;
      for i := 1 to 10000 do begin
         b := premier_2(21773) ;
      end {for} ;
      writeln('fini') ;
      writeln('on voit bien que premier_2 est beaucoup plus rapide que premier_1') ;

      // tests de premier_3
      writeln('// tests de premier_3') ;
      writeln('premier_3(1) vaut ', premier_3(1)) ;
      writeln('premier_3(2) vaut ', premier_3(2)) ;
      writeln('premier_3(3) vaut ', premier_3(3)) ;
      writeln('premier_3(4) vaut ', premier_3(4)) ;
      writeln('premier_3(5) vaut ', premier_3(5)) ;
      writeln('premier_3(17) vaut ', premier_3(17)) ;
      writeln('premier_3(21) vaut ', premier_3(21)) ;
      writeln('premier_3(21773) vaut ', premier_3(21773)) ;
      writeln('premier_3(21777) vaut ', premier_3(21777)) ;
      writeln('premier_3(217777) vaut ', premier_3(217777)) ;
      writeln('premier_3(2177827) vaut ', premier_3(2177827)) ;

      // Comparaison entre premier_2 et premier_3
      writeln('// Comparaison entre premier_2 et premier_3') ;
      writeln('je calcule 1000000 fois premier_2(2177827) et premier_3(2177827)') ;
      writeln('pour premier_2(2177827)') ;            // Pour tester je vais utiliser
      deb := time ;  // je marque l'heure de début    // Les outils de mesure du temps
      for i := 1 to 1000000 do begin                  // qui se trouvent dans sysutils
         b := premier_2(2177827) ;                    // time est une fonction qui
      end {for} ;                                     // renvoie l'heure de type TDateTime
      fin := time ;  // je marque l'heure de début    // TimeToStr convertit en chaîne
      writeln('fini en ', TimeToStr(fin-deb)) ;       // un temps
      deb := time ;  // je marque l'heure de début
      writeln('pour premier_3(2177827)') ;
      for i := 1 to 1000000 do begin
         b := premier_3(2177827) ;
      end {for} ;
      fin := time ;  // je marque l'heure de début
      writeln('fini en ', TimeToStr(fin-deb)) ;
      writeln('on voit bien que premier_3 est plus rapide que premier_2') ;

      // test de Erathostene
      writeln('// test de Erathostene') ;
      Erathostene ;
*)
      // Comparaison entre premier_3 et Erathostene
      writeln('// Comparaison entre premier_3 et Erathostene') ;
      writeln('je calcule 10000 fois tous les nombres premiers entre 2 et 10000') ;
      writeln('avec premier_3') ;
      deb := time ;  // je marque l'heure de début
      for i := 1 to 10000 do begin // je calcule les nombres premiers de 1 à 10000
         for j := 1 to 10000 do begin
            b := premier_3(j) ;
         end {for} ;
      end {for} ;
      fin := time ;  // je marque l'heure de début
      writeln('fini en ', TimeToStr(fin-deb)) ;
      writeln('je calcule 10000 fois tous les nombres premiers entre 2 et 10000') ;
      writeln('avec Erathostene mais sans affichage') ;
      deb := time ;  // je marque l'heure de début
      for i := 1 to 10000 do begin // je calcule les nombres premiers de 1 à 10000
         Erathostene
      end {for} ;
      fin := time ;  // je marque l'heure de début
      writeln('fini en ', TimeToStr(fin-deb)) ;
      writeln('on voit bien que Erathostene est plus efficace que premier_3') ;

   end {exercice_3} ;

BEGIN 

//   exercice_1 ;
//   exercice_2 ;
   exercice_3 ;
//   exercice_6 ;
//   exercice_7 ;

END.

RESULTAT

EXERCICE 1
question 2
vérifions qu'après initialiserBudget le budget est bien à 0
je le fais pour depensesVoiture1 et depenseVoiture2
maintenant depensesVoiture1[10] vaut  0.000000000000000E+000
et depensesVoiture2[MAI] vaut  0.000000000000000E+000
question 3
budgetMoyen1(BUDGET1) vaut  5.316666666666666E+001
budgetMoyen2(BUDGET2) vaut  5.316666666666666E+001
question 4
rien à faire si ce n'est que la validation des déclarations de types

EXERCICE 2
question 1
TABLO1 vaut : mardi mercredi samedi mardi jeudi samedi lundi lundi mardi
TABLO2 vaut : mardi mercredi mardi mardi jeudi samedi lundi lundi mardi
Pour la fonction Max
max(TABLO1) vaut : samedi
max(TABLO2) vaut : samedi
Pour la fonction secondMax
secondMax1(TABLO1) vaut : samedi
secondMax1(TABLO2) vaut : jeudi
secondMax2(TABLO1) vaut : samedi
secondMax2(TABLO2) vaut : jeudi
secondMax3(TABLO1) vaut : jeudi
secondMax3(TABLO2) vaut : jeudi
secondMax4(TABLO1) vaut : jeudi
secondMax4(TABLO2) vaut : jeudi
Pour la fonction miroir
mroir1(TABLO1) vaut : mardi lundi lundi samedi jeudi mardi samedi mercredi mardi
mroir2(TABLO1) vaut : mardi lundi lundi samedi jeudi mardi samedi mercredi mardi
mroir1(TABLO2) vaut : mardi lundi lundi samedi jeudi mardi mardi mercredi mardi
mroir2(TABLO2) vaut : mardi lundi lundi samedi jeudi mardi mardi mercredi mardi
question 2
Pour la procedure retourner1
avant retourner1(t), t vaut : mardi mercredi samedi mardi jeudi samedi lundi lundi mardi
après retourner1(t), t vaut : mardi lundi lundi samedi jeudi mardi samedi mercredi mardi
Pour la procedure retourner2_v1
avant retourner2_v1(t), t vaut : mardi mercredi samedi mardi jeudi samedi lundi lundi mardi
après retourner2_v1(t), t vaut : mardi lundi lundi samedi jeudi mardi samedi mercredi mardi
Pour la procedure retourner2_v2
avant retourner2_v2(t), t vaut : mardi mercredi samedi mardi jeudi samedi lundi lundi mardi
après retourner2_v2(t), t vaut : mardi lundi lundi samedi jeudi mardi samedi mercredi mardi

EXERCICE 3
// tests de premier_1
premier_1(1) vaut FALSE
premier_1(2) vaut TRUE
premier_1(17) vaut TRUE
premier_1(21) vaut FALSE
premier_1(21773) vaut TRUE
premier_1(21777) vaut FALSE
// tests de premier_2
premier_2(1) vaut FALSE
premier_2(2) vaut TRUE
premier_2(17) vaut TRUE
premier_2(21) vaut FALSE
premier_2(21773) vaut TRUE
premier_2(21777) vaut FALSE
// Comparaison entre premier_1 et premier_2
je calcule 10000 fois premier_1(21773) et premier_2(21773)
pour premier_1(21773)
fini
pour premier_2(21773)
fini
on voit bien que premier_2 est beaucoup plus rapide que premier_1
// tests de premier_3
premier_3(1) vaut FALSE
premier_3(2) vaut TRUE
premier_3(3) vaut TRUE
premier_3(4) vaut FALSE
premier_3(5) vaut TRUE
premier_3(17) vaut TRUE
premier_3(21) vaut FALSE
premier_3(21773) vaut TRUE
premier_3(21777) vaut FALSE
premier_3(217777) vaut FALSE
premier_3(2177827) vaut TRUE
// Comparaison entre premier_2 et premier_3
je calcule 1000000 fois premier_2(2177827) et premier_3(2177827)
pour premier_2(2177827)
fini en 00:00:27
pour premier_3(2177827)
fini en 00:00:09
on voit bien que premier_3 est plus rapide que premier_2
// test de Erathostene
2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 101 103 107 109 113 127 131 137 139 149 151 157 163 167 173 179 181 191 193 197 199 211 223 227 229 233 239 241 251 257 263 269 271 277 281 283 293 307 311 313 317 331 337 347 349 353 359 367 373 379 383 389 397 401 409 419 421 431 433 439 443 449 457 461 463 467 479 487 491 499 503 509 521 523 541 547 557 563 569 571 577 587 593 599 601 607 613 617 619 631 641 643 647 653 659 661 673 677 683 691 701 709 719 727 733 739 743 751 757 761 769 773 787 797 809 811 821 823 827 829 839 853 857 859 863 877 881 883 887 907 911 919 929 937 941 947 953 967 971 977 983 991 997 1009 1013 1019 1021 1031 1033 1039 1049 1051 1061 1063 1069 1087 1091 1093 1097 1103 1109 1117 1123 1129 1151 1153 1163 1171 1181 1187 1193 1201 1213 1217 1223 1229 1231 1237 1249 1259 1277 1279 1283 1289 1291 1297 1301 1303 1307 1319 1321 1327 1361 1367 1373 1381 1399 1409 1423 1427 1429 1433 1439 1447 1451 1453 1459 1471 1481 1483 1487 1489 1493 1499 1511 1523 1531 1543 1549 1553 1559 1567 1571 1579 1583 1597 1601 1607 1609 1613 1619 1621 1627 1637 1657 1663 1667 1669 1693 1697 1699 1709 1721 1723 1733 1741 1747 1753 1759 1777 1783 1787 1789 1801 1811 1823 1831 1847 1861 1867 1871 1873 1877 1879 1889 1901 1907 1913 1931 1933 1949 1951 1973 1979 1987 1993 1997 1999 2003 2011 2017 2027 2029 2039 2053 2063 2069 2081 2083 2087 2089 2099 2111 2113 2129 2131 2137 2141 2143 2153 2161 2179 2203 2207 2213 2221 2237 2239 2243 2251 2267 2269 2273 2281 2287 2293 2297 2309 2311 2333 2339 2341 2347 2351 2357 2371 2377 2381 2383 2389 2393 2399 2411 2417 2423 2437 2441 2447 2459 2467 2473 2477 2503 2521 2531 2539 2543 2549 2551 2557 2579 2591 2593 2609 2617 2621 2633 2647 2657 2659 2663 2671 2677 2683 2687 2689 2693 2699 2707 2711 2713 2719 2729 2731 2741 2749 2753 2767 2777 2789 2791 2797 2801 2803 2819 2833 2837 2843 2851 2857 2861 2879 2887 2897 2903 2909 2917 2927 2939 2953 2957 2963 2969 2971 2999 3001 3011 3019 3023 3037 3041 3049 3061 3067 3079 3083 3089 3109 3119 3121 3137 3163 3167 3169 3181 3187 3191 3203 3209 3217 3221 3229 3251 3253 3257 3259 3271 3299 3301 3307 3313 3319 3323 3329 3331 3343 3347 3359 3361 3371 3373 3389 3391 3407 3413 3433 3449 3457 3461 3463 3467 3469 3491 3499 3511 3517 3527 3529 3533 3539 3541 3547 3557 3559 3571 3581 3583 3593 3607 3613 3617 3623 3631 3637 3643 3659 3671 3673 3677 3691 3697 3701 3709 3719 3727 3733 3739 3761 3767 3769 3779 3793 3797 3803 3821 3823 3833 3847 3851 3853 3863 3877 3881 3889 3907 3911 3917 3919 3923 3929 3931 3943 3947 3967 3989 4001 4003 4007 4013 4019 4021 4027 4049 4051 4057 4073 4079 4091 4093 4099 4111 4127 4129 4133 4139 4153 4157 4159 4177 4201 4211 4217 4219 4229 4231 4241 4243 4253 4259 4261 4271 4273 4283 4289 4297 4327 4337 4339 4349 4357 4363 4373 4391 4397 4409 4421 4423 4441 4447 4451 4457 4463 4481 4483 4493 4507 4513 4517 4519 4523 4547 4549 4561 4567 4583 4591 4597 4603 4621 4637 4639 4643 4649 4651 4657 4663 4673 4679 4691 4703 4721 4723 4729 4733 4751 4759 4783 4787 4789 4793 4799 4801 4813 4817 4831 4861 4871 4877 4889 4903 4909 4919 4931 4933 4937 4943 4951 4957 4967 4969 4973 4987 4993 4999 5003 5009 5011 5021 5023 5039 5051 5059 5077 5081 5087 5099 5101 5107 5113 5119 5147 5153 5167 5171 5179 5189 5197 5209 5227 5231 5233 5237 5261 5273 5279 5281 5297 5303 5309 5323 5333 5347 5351 5381 5387 5393 5399 5407 5413 5417 5419 5431 5437 5441 5443 5449 5471 5477 5479 5483 5501 5503 5507 5519 5521 5527 5531 5557 5563 5569 5573 5581 5591 5623 5639 5641 5647 5651 5653 5657 5659 5669 5683 5689 5693 5701 5711 5717 5737 5741 5743 5749 5779 5783 5791 5801 5807 5813 5821 5827 5839 5843 5849 5851 5857 5861 5867 5869 5879 5881 5897 5903 5923 5927 5939 5953 5981 5987 6007 6011 6029 6037 6043 6047 6053 6067 6073 6079 6089 6091 6101 6113 6121 6131 6133 6143 6151 6163 6173 6197 6199 6203 6211 6217 6221 6229 6247 6257 6263 6269 6271 6277 6287 6299 6301 6311 6317 6323 6329 6337 6343 6353 6359 6361 6367 6373 6379 6389 6397 6421 6427 6449 6451 6469 6473 6481 6491 6521 6529 6547 6551 6553 6563 6569 6571 6577 6581 6599 6607 6619 6637 6653 6659 6661 6673 6679 6689 6691 6701 6703 6709 6719 6733 6737 6761 6763 6779 6781 6791 6793 6803 6823 6827 6829 6833 6841 6857 6863 6869 6871 6883 6899 6907 6911 6917 6947 6949 6959 6961 6967 6971 6977 6983 6991 6997 7001 7013 7019 7027 7039 7043 7057 7069 7079 7103 7109 7121 7127 7129 7151 7159 7177 7187 7193 7207 7211 7213 7219 7229 7237 7243 7247 7253 7283 7297 7307 7309 7321 7331 7333 7349 7351 7369 7393 7411 7417 7433 7451 7457 7459 7477 7481 7487 7489 7499 7507 7517 7523 7529 7537 7541 7547 7549 7559 7561 7573 7577 7583 7589 7591 7603 7607 7621 7639 7643 7649 7669 7673 7681 7687 7691 7699 7703 7717 7723 7727 7741 7753 7757 7759 7789 7793 7817 7823 7829 7841 7853 7867 7873 7877 7879 7883 7901 7907 7919 7927 7933 7937 7949 7951 7963 7993 8009 8011 8017 8039 8053 8059 8069 8081 8087 8089 8093 8101 8111 8117 8123 8147 8161 8167 8171 8179 8191 8209 8219 8221 8231 8233 8237 8243 8263 8269 8273 8287 8291 8293 8297 8311 8317 8329 8353 8363 8369 8377 8387 8389 8419 8423 8429 8431 8443 8447 8461 8467 8501 8513 8521 8527 8537 8539 8543 8563 8573 8581 8597 8599 8609 8623 8627 8629 8641 8647 8663 8669 8677 8681 8689 8693 8699 8707 8713 8719 8731 8737 8741 8747 8753 8761 8779 8783 8803 8807 8819 8821 8831 8837 8839 8849 8861 8863 8867 8887 8893 8923 8929 8933 8941 8951 8963 8969 8971 8999 9001 9007 9011 9013 9029 9041 9043 9049 9059 9067 9091 9103 9109 9127 9133 9137 9151 9157 9161 9173 9181 9187 9199 9203 9209 9221 9227 9239 9241 9257 9277 9281 9283 9293 9311 9319 9323 9337 9341 9343 9349 9371 9377 9391 9397 9403 9413 9419 9421 9431 9433 9437 9439 9461 9463 9467 9473 9479 9491 9497 9511 9521 9533 9539 9547 9551 9587 9601 9613 9619 9623 9629 9631 9643 9649 9661 9677 9679 9689 9697 9719 9721 9733 9739 9743 9749 9767 9769 9781 9787 9791 9803 9811 9817 9829 9833 9839 9851 9857 9859 9871 9883 9887 9901 9907 9923 9929 9931 9941 9949 9967 9973

// Comparaison entre premier_3 et Erathostene
je calcule 10000 fois tous les nombres premiers entre 2 et 10000
avec premier_3
fini en 00:00:13
je calcule 10000 fois tous les nombres premiers entre 2 et 10000
avec Erathostene mais sans affichage
fini en 00:00:02
on voit bien que Erathostene est plus efficace que premier_3
