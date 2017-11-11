{--------------------------------------------------------------------------------------------}
{-                                   cor_TD1_ORDINAUX.pas                                   -}
{- Christian Lasou, 06/02/08                                                                -}
{- Corrections des exercices du TD1 sur les types ordinaux                                  -}
{- Chaque proc�dure correspond � un exercice                                                -}
{--------------------------------------------------------------------------------------------}
program cor_TD1_ORDINAUX ;

// RAPPELS DE COURS

// TYPE ORDINAL : TOTALEMENT ORDONN�
//                EXISTENCE D'UN PLUS PETIT ET UN PLUS GRAND �L�MENT
//                CHAQUE �L�MENT A UN SUCCESSEUR (SAUF LE PLUS GRAND) ET UN PR�D�CESSEUR (SAUF
//                   LE PLUS PETIT)

// EXEMPLES : BOOLEAN, CARDINAL, INTEGER, CHAR
// REAL ET STRING NE SONT PAS DES TYPES ORDINAUX

// FONCTIONS ET PROC�DURES SUR LES TYPES ORDINAUX

// low : un type ordinal -----> la plus petite valeur de ce type
// high : un type ordinal ----> la plus grande valeur de ce type

// les comparateurs =, <>, <, <=, >, >=

// pred : une valeur d'un type ordinal ----> la valeur suivante si elle existe
// succ : une valeur d'un type ordinal ----> la valeur pr�c�dente si elle existe

// ord : une valeur de type ordinal ---> son rang ordinal dans le type
// si la valeur est un entier, on obtient le m�me nombre
// ord(125) = 125
// ord('A') = 65

// le nom du type permet d'avoir la fonction r�ciproque de ord
// exemple : CHAR : n ----> le caract�re c tel que ord(c) = n

// enfin on a deux proc�dures : inc et dec
// l'instruction  inc(e) ;  �quivaut � l'instruction  e := succ(e) ;
// l'instruction  dec(e) ;  �quivaut � l'instruction  e := pred(e) ;

// NOUVEAUX TYPES

// LES INTERVALLES (� partir d'un type existant)
// si on a un type T on peut cr�er un nouveau type (disons plut�t sous-type) en d�finissant
// un intervalle entre deux valeurs de ce type T
//          syntaxe   type <nom> = <valeur 1>..<valeur 2> ;
// remarquez les deux points .. et il faut que <valeur 1> soit inf�rieure � <valeur 2> 
// Des exemples :
  
  type MOIS = 1..12 ;  // mois repr�sent�s par leur num�ro
       MAJUSCULE = 'A'..'Z' ;
       MINUSCULE = 'a'..'z' ;
       CHIFFRE = '0'..'9' ; // les caract�res chiffres
       
// On doit mettre "type" mais ce n'est pas un nouveau type car si je calcule ord(c) avec
// c de type MAJUSCULE et c valant 'A' j'obtiens 65 comme pour 'A' en tant que CHAR
// que vaut low(MAJUSCULE) ? high(MAJUSCULE) ? 
// Si une variable c vaut 'Z', inc(c) d�clenche-t-il une erreur ?

// UN VRAI NOUVEAU TYPE
// on peut cr�er un nouveau type (cette fois un vrai) en disant quelles sont les nouvelles
// valeurs d�finies ; je dis bien nouvelles valeurs car ce ne peut �tre des valeurs d�j�
// existantes. L'ordre d'�num�ration de ces nouvelles valeurs d�finit la relation d'ordre
// <= sur ce type,
//          syntaxe   type <nom> = (<valeur 1>,<valeur 2>,<valeur3>,<valeur4>) ;
// il faut absolument d�clarer toutes les nouvelles valeurs, pas question d'utiliser des ...
// ou un "etc" 
// Des exemples :
  type JOUR = (LUNDI,MARDI,MERCREDI,JEUDI,VENDREDI,SAMEDI,DIMANCHE) ;

// ATTENTION : ce ne sont pas des cha�nes de caract�res LUNDI <> 'LUNDI'

// On a bien s�r encore les fonctions low et high.
// ord donne le rang de la valeur (en d�marrant � 0) ord(LUNDI) = 0
// la fonction r�ciproque est le nom du type   JOUR(2) = MERCREDI
// On a aussi les fonctions pred, succ, et les proc�dures inc et dec avec les m�mes
// restrictions
// ATTENTION je n'ai aucun outil de manipulation pour un type nouveau ainsi, sauf l'affec-
// tation et la relation d'ordre et en particulier si je veux faire des entr�es-sorties
// (affichage et lecture au clavier) je dois �crire les proc�dures correspondantes :
// afficherJour et lireJour

   procedure exercice_1 ;

      // Pour l'exercice je d�clare d'abord les nouveaux types CHIFFRE et LETTRE
      type CHIFFRE_BIS = 0..9 ;  // ici les chiffres sont des nombres
           LETTRE = 'A'..'Z' ;   // c'est le m�me type que MAJUSCULE
   begin
      writeln('Exercice 1') ;
      writeln('Les valeurs extr�males sont :') ;
      writeln('low(CARDINAL) = ',low(CARDINAL),' et high(CARDINAL) = ',high(CARDINAL)) ;
      writeln('low(INTEGER) = ',low(INTEGER),' et high(INTEGER) = ',high(INTEGER)) ;
      writeln('low(BOOLEAN) = ',low(BOOLEAN),' et high(BOOLEAN) = ',high(BOOLEAN)) ;
      writeln('low(CHAR) = ',low(CHAR),' et high(CHAR) = ',high(CHAR)) ;
      writeln('low(CHIFFRE) = ',low(CHIFFRE),' et high(CHIFFRE) = ',high(CHIFFRE)) ;
      writeln('low(CHIFFRE_BIS) = ',low(CHIFFRE_BIS),' et high(CHIFFRE_BIS) = ',high(CHIFFRE_BIS)) ;
      writeln('low(LETTRE) = ',low(LETTRE),' et high(LETTRE) = ',high(LETTRE)) ;
      writeln('low(MAJUSCULE) = ',low(MAJUSCULE),' et high(MAJUSCULE) = ',high(MAJUSCULE)) ;
      writeln('low(MINUSCULE) = ',low(MINUSCULE),' et high(MINUSCULE) = ',high(MINUSCULE)) ;
      writeln ;
   end {exercice_1} ;

   procedure exercice_2 ;
   // je vais faire mieux :
   // D'abord �crire succ et pred en utilisant inc et dec 
   // (pour �viter les confusions je les appelle succ_bis et pred_bis)
   // Ensuite je ferai le contraire, c'est-�-dire �crire inc et dec en utilisant succ et pred
   // (ici aussi je les appelerai inc_bis et dec_bis)
   // Et en plus encore je r��crirais les 4, en les appelant succ_ter, pred_ter, inc_ter et dec_ter
   // en utilisant les fonctions ord et sa r�ciproque qui a comme nom le m�me nom que le type
   // Pour le faire il faut que je choisisse un type, je prend le type CHAR

      function succ_bis(c : CHAR) : CHAR ;
      var c_aux : CHAR ;
      begin
         c_aux := c ;    // pour pouvoir modifier c_aux
         inc(c_aux) ;
         succ_bis := c_aux ;
      end {succ_bis} ;

      function pred_bis(c : CHAR) : CHAR ;
      var c_aux : CHAR ;
      begin
         c_aux := c ;    // pour pouvoir modifier c_aux
         dec(c_aux) ;
         pred_bis := c_aux ;
      end {pred_bis} ;

      procedure inc_bis(var c : CHAR) ;
      begin
         c := succ(c) ;    // beaucoup plus simple, non ?
      end {inc_bis} ;

      procedure dec_bis(var c : CHAR) ;
      begin
         c := pred(c) ;    // beaucoup plus simple, non ?
      end {dec_bis} ;

      function succ_ter(c : CHAR) : CHAR ;
      begin
         succ_ter := CHAR(ord(c)+1) ;
      end {succ_ter} ;

      function pred_ter(c : CHAR) : CHAR ;
      begin
         pred_ter := CHAR(ord(c)-1) ;
      end {pred_ter} ;

      procedure inc_ter(var c : CHAR) ;
      begin
         c := CHAR(ord(c)+1) ;    // beaucoup plus simple, non ?
      end {inc_ter} ;

      procedure dec_ter(var c : CHAR) ;
      begin
         c := CHAR(ord(c)-1) ;    // beaucoup plus simple, non ?
      end {dec_ter} ;

      var c : CHAR ;

   begin
      writeln('Exercice 2') ;
      writeln('succ_bis(''F'') vaut ', succ_bis('F')) ;
      writeln('succ_bis(high(CHAR)) vaut ', succ_bis(high(CHAR))) ;
      writeln('pred_bis(''F'') vaut ', pred_bis('F')) ;
      writeln('pred_bis(low(CHAR)) vaut ', pred_bis(low(CHAR))) ;
      c := 'T' ;
      write('avant inc_bis(c), c vaut ',c) ;
      inc_bis(c) ; writeln(' et apr�s inc_bis(c), c vaut ',c) ;
      c := high(CHAR) ;
      write('avant inc_bis(c), c vaut ',c) ;
      inc_bis(c) ; writeln(' et apr�s inc_bis(c), c vaut ',c) ;
      c := 'T' ;
      write('avant dec_bis(c), c vaut ',c) ;
      dec_bis(c) ; writeln(' et apr�s dec_bis(c), c vaut ',c) ;
      c := low(CHAR) ;
      write('avant dec_bis(c), c vaut ',c) ;
      dec_bis(c) ; writeln(' et apr�s dec_bis(c), c vaut ',c) ;
      writeln('succ_ter(''F'') vaut ', succ_ter('F')) ;
      writeln('succ_ter(high(CHAR)) vaut ', succ_ter(high(CHAR))) ;
      writeln('pred_ter(''F'') vaut ', pred_ter('F')) ;
      writeln('pred_ter(low(CHAR)) vaut ', pred_ter(low(CHAR))) ;
      c := 'T' ;
      write('avant inc_ter(c), c vaut ',c) ;
      inc_ter(c) ; writeln(' et apr�s inc_ter(c), c vaut ',c) ;
      c := high(CHAR) ;
      write('avant inc_ter(c), c vaut ',c) ;
      inc_ter(c) ; writeln(' et apr�s inc_ter(c), c vaut ',c) ;
      c := 'T' ;
      write('avant dec_ter(c), c vaut ',c) ;
      dec_ter(c) ; writeln(' et apr�s dec_ter(c), c vaut ',c) ;
      c := low(CHAR) ;
      write('avant dec_ter(c), c vaut ',c) ;
      dec_ter(c) ; writeln(' et apr�s dec_ter(c), c vaut ',c) ;
      writeln ;
   end {exercice_2} ;

   procedure exercice_3_et_4 ;
   // Une procedure afficherJour pour afficher la valeur d'une valeur de type JOUR, qui n'est
   // pas, rappelons-le, une cha�ne de caract�res et que "Pascal" ne sait donc pas afficher a
   // priori.
   // Bien que le type JOUR ait d�j� �t� d�clar� auparavant je le red�clare pour rendre
   // autonome ma proc�dure exercice_3 ; �a ne pose aucun probl�me puisque cette fois-ci ma
   // d�claration est locale � la proc�dure exercice_3 et d'ailleurs je vais d�clarer ce type
   // jour dans une autre langue pour m'amuser

      type JOUR = (MONDAY,TUESDAY,WENESDAY,THURSDAY,FRIDAY,SATURDAY,SUNDAY) ;

   // Voici une premi�re version de la proc�dure afficherJour qui utilise les valeurs
   // explicites du type JOUR

      procedure afficherJour_v1(const j : JOUR) ;    // remarquez le passage de param�tre
      begin
         case j of
            MONDAY   : write('lunes') ;
            TUESDAY  : write('martes') ;
            WENESDAY : write('miercoles') ;
            THURSDAY : write('jueves') ;
            FRIDAY   : write('viernes') ;
            SATURDAY : write('sabado')      // jamais de ";" devant un "else"
         else  //  c'est obligatoirement SUNDAY
            write('domingo') ;
         end {case} ;
      end {afficherJour_v1} ;

   // Voici une seconde version qui est meilleure car elle n'utilise pas les valeurs
   // explicites du type JOUR et donc si je d�cide de les changer pour les mettre en italien
   // par exemple ma proc�dure continuera de fonctionner parfaitement

      procedure afficherJour_v2(const j : JOUR) ;    // remarquez le passage de param�tre
      begin
         case ord(j) of
            0 : write('lunes') ;
            1 : write('martes') ;
            2 : write('miercoles') ;
            3 : write('jueves') ;
            4 : write('viernes') ;
            5 : write('sabado')      // jamais de ";" devant un "else"
         else  //  c'est obligatoirement 6
            write('domingo') ;
         end {case} ;
      end {afficherJour_v2} ;

      var d : JOUR ;

      procedure lireJour(out j : JOUR) ; // remarquez le passage de param�tre en sortie 
      // l'utilisateur va taper une cha�ne de caract�res correspondant � un certain jour dans
      // une certaine langue (je choisis le fran�ais ;-)
      var s : STRING ;
      begin
         readln(s) ;
         // pour d�terminer la valeur de j � partir de celle de s je ne peux malheureusement
         // pas utiliser un "case" comme dans afficherJour car les valeurs possibles de s
         // sont des "STRING" et donc pas d'un type ORDINAL, d'o� l'obligation d'utiliser des
         // "if" imbriqu�s ou non.
         // Comme il y a une seule "action" � faire � chaque fois (j := <la bonne valeur>) je
         // peux ne pas mettre de "begin...end" et adopter une indentation plus lisible
         if s = 'lundi' then j := MONDAY      // pas de ";" devant un "else"
         else if s = 'mardi'    then j := TUESDAY
         else if s = 'mercredi' then j := WENESDAY
         else if s = 'jeudi'    then j := THURSDAY
         else if s = 'vendredi' then j := FRIDAY
         else if s = 'samedi'   then j := SATURDAY
         else j := SUNDAY ;
      end {lireJour} ;

      // Voici enfin la fonction jourSuivant qui g�n�ralise la fonction pr�d�finie succ qui
      // ne marche pas pour le dernier jour de la semaine alors qu'en r�alit� on sait
      // qu'apr�s le dernier jour de la semaine on a le premier jour de la semaine
      // Remarquez que je n'utilise pas les valeurs explicites du type JOUR mais les
      // fonctions low et high, ce qui rend ma fonction jourSuivant correcte m�me si je
      // choisis de les mettre dans une autre langue.
      function jourSuivant(j : JOUR) : JOUR ;
      begin
         if j = high(JOUR) then begin
            jourSuivant := low(JOUR) ;
         end else begin
            jourSuivant := succ(j) ;
         end {if} ;
      end {jourSuivant} ;

   begin
      writeln('Exercice 3 et 4') ;
      // pour tester afficherJour je peux tout bonnement le faire pour un jour particulier
      // que je choisis dans mon programme
      afficherJour_v1(TUESDAY) ; writeln ;
      // je peux aussi d�clarer une variable j de type JOUR, lui donner une valeur et
      // afficher le r�sultat d'une expression de type JOUR qui calcule un JOUR � partir de
      // cette valeur
      d := FRIDAY ;
      afficherJour_v1(pred(d)) ; writeln ;
      // je peux enfin demander � l'utilisateur d'entrer une valeur pour j et l'afficher mais
      // attention dans ce cas pas question d'utiliser l'instruction "readln" pour saisir
      // cette valeur, car les valeurs du type jour ne sont pas des cha�nes de caract�res,
      // donc le mieux est d'�crire une proc�dure de saisie d'une telle valeur, je l'appelle
      // lireJour voir la d�claration au dessus
      writeln('Quel jour choisissez-vous (en fran�ais) ?') ;
      lireJour(d) ;
      afficherJour_v2(d) ; writeln ;
      write('jourSuivant(') ; afficherJour_v2(d) ; write(') vaut ') ;
      afficherJour_v2(jourSuivant(d)) ; writeln ;
      write('jourSuivant(SUNDAY) vaut ') ;
      afficherJour_v2(jourSuivant(SUNDAY)) ; writeln ; writeln ;
   end {exercice_3_et_4} ;

   // procedure exercice_5 ;
   // JE NE LA FAIS PAS CAR ELLE EST DANS LE TP1

   procedure exercice_6 ;
      // je rappelle le type CHIFFRE
      type CHIFFRE = '0'..'9' ; // les caract�res chiffres

      function valeur_chiffre_v1(c : CHIFFRE) : CARDINAL ;
      // premi�re version avec un case
      begin
         case c of
            '0' : valeur_chiffre_v1 := 0 ;
            '1' : valeur_chiffre_v1 := 1 ;
            '2' : valeur_chiffre_v1 := 2 ;
            '3' : valeur_chiffre_v1 := 3 ;
            '4' : valeur_chiffre_v1 := 4 ;
            '5' : valeur_chiffre_v1 := 5 ;
            '6' : valeur_chiffre_v1 := 6 ;
            '7' : valeur_chiffre_v1 := 7 ;
            '8' : valeur_chiffre_v1 := 8 ;
            '9' : valeur_chiffre_v1 := 9 ;
         end {case} ;
      end {valeur_chiffre_v1} ;

      function valeur_chiffre_v2(c : CHIFFRE) : CARDINAL ;
      // seconde version avec la fonction ord
      begin
         valeur_chiffre_v2 := ord(c)-ord('0') ;
      end {valeur_chiffre_v2} ;

      var ch : CHIFFRE ;

   begin
      writeln('Exercice 6') ;
      write('votre chiffre : ') ; readln(ch) ;
      writeln('valeur_chiffre_v1(''',ch,''') vaut ',valeur_chiffre_v1(ch)) ;
      writeln('valeur_chiffre_v2(''',ch,''') vaut ',valeur_chiffre_v2(ch)) ;
      writeln ;
   end {exercice_6} ;

   procedure exercice_7 ;
      // Le code de C�sar
      // A -> D, B -> E, C -> F, ..., V -> Y, W -> Z, X -> A, Y -> B, Z -> C

      // je rappelle le type LETTRE
      type LETTRE = 'A'..'Z' ;   // c'est le m�me type que MAJUSCULE

      // la fonction de codage d'une LETTRE

      // Au d�part j'ai pens� faire le truc suivant :

      function code_v1_bad(l : LETTRE) : LETTRE ;
      // premi�re version avec un case
      begin
         case l of
             // pas de probl�me pour les lettres entre 'A' et 'W', on d�cale de 3
            'A'..'W' : code_v1_bad := LETTRE(ord(l)+3) ;
             // traitement particulier pour les 3 derni�res lettres
            'X' : code_v1_bad := 'A' ;
            'Y' : code_v1_bad := 'B' ;
            'Z' : code_v1_bad := 'C'
         end {case} ;
      end {code_v1_bad} ;

      // malheureusement �a "fonctionne" mal
      // pour voir ce qu'il se passe j'ai mis des affichages tests et introduit une variable
      // res pour ne faire qu'� la fin l'affectation "code_v1 := res"
      // voici la version pour d�boguage

      function code_v1_debog(l : LETTRE) : LETTRE ;
      // premi�re version avec un case
      var res : LETTRE ;
      begin
         writeln('���',l) ; res := 'R' ;
         writeln(l='B') ;
         writeln(l='Y') ;
         case l of
             // pas de probl�me pour les lettres entre 'A' et 'W', on d�cale de 3
            'A'..'W' : res := LETTRE(ord(l)+3) ;
             // traitement particulier pour les 3 derni�res lettres
            'X' : res := 'A' ;
            'Y' : res := 'B' ;
            'Z' : res := 'C'
         else writeln('autre choix') ; 
         end {case} ;
         writeln('%%%', res) ;
         code_v1_debog := res ;
      end {code_v1_debog} ;

      // Manifestement il y a un probl�me au niveau du typage
      // l est du type LETTRE, quand je teste l='B' il ne r�le pas et r�pond correctement
      // mais dans le "case"  le test l='B' ou l='Y' ne r�pond plus correctement puisque je
      // passe par le "else"
      // Donc je supprime le type LETTRE et utilise le type CHAR
      // CONCLUSION : ENCORE UNE BIZARRERIE DE PASCAL !!!
      // Logiquement LETTRE qui est un type intervalle de CHAR, donc en r�alit� un "sous-type"
      // de CHAR devrait "h�riter" du type CHAR et ne devrait �tre qu'un "garde-fou" au niveau
      // des valeurs pour ne pas d�border, en particulier les tests d'�galit� entre LETTRE et
      // CHAR devraient fonctionner, et la "fonction" (ou forme sp�ciale) ord devrait donner
      // le m�me r�sultat pour un CHAR et une LETTRE

      function code_v1(l : CHAR) : CHAR ;   // Cette fois �a marche
      // premi�re version avec un case
      begin
         case l of
             // pas de probl�me pour les lettres entre 'A' et 'W', on d�cale de 3
            'A'..'W' : code_v1 := CHAR(ord(l)+3) ;
             // traitement particulier pour les 3 derni�res lettres
            'X' : code_v1 := 'A' ;
            'Y' : code_v1 := 'B' ;
            'Z' : code_v1 := 'C'
         end {case} ;
      end {code_v1} ;

      function code_v2(l : LETTRE) : LETTRE ;
      // seconde version sans case en utilisant un "mod"
      begin
         code_v2 := LETTRE((ord(l)-ord('A')+3) mod 26 + ord('A')) ;
         // explications :
         // ord(l)-ord('A') me donne un nombre entre 0 et 25
         // quand j'ajoute 3 j'obtiens un nombre entre 3 et 28
         // en prenant le modulo 26, de 3 � 25 �a ne change pas, mais 26 donne 0
         // 27 donne 1 et 28 donne 2
         // j'ajoute alors ord('A') et j'obtiens l'ord du caract�re souhait�
      end {code_v2} ;

      // La fonction qui renvoie le message cod�

      function message_code_v1(s : STRING) : STRING ;
      var resultat : STRING ;
          i : CARDINAL ;
      begin
         resultat := s ;
         for i := 1 to length(s) do begin
            resultat[i] := code_v2(s[i]) ;    // j'utilise code_v2
         end {for} ;
         message_code_v1 := resultat ;
      end {message_code_v1};

      function message_code_v1bis(s : STRING) : STRING ;
      var // resultat : STRING ;    puis-je me passer de resultat ?
          i : CARDINAL ;
      begin
         message_code_v1bis := s ;
         for i := 1 to length(s) do begin
            message_code_v1bis[i] := code_v2(s[i]) ;    // j'utilise code_v2
         end {for} ;
      end {message_code_v1};

      function message_code_v2(s : STRING) : STRING ;   // je la pr�f�re 
      var resultat : STRING ;
          i : CARDINAL ;
      begin
         resultat := '' ;
         for i := 1 to length(s) do begin
            resultat := resultat+code_v2(s[i]) ;    // j'utilise code_v2
         end {for} ;
         message_code_v2 := resultat ;
      end {message_code_v1};

      // SI ON VEUT POUVOIR METTRE DES ESPACES OU PONCTUATION

      function message_code(s : STRING) : STRING ;   // je la pr�f�re 
      var resultat : STRING ;
          i : CARDINAL ;
      begin
         resultat := '' ;
         for i := 1 to length(s) do begin
            if ('A' <= s[i]) and (s[i] <= 'Z') then begin // c'est une lettre
              resultat := resultat+code_v2(s[i]) ;    // j'utilise code_v2
            end else begin  // ce n'est pas une lettre donc il ne change pas
              resultat := resultat+s[i] ;    // j'utilise code_v2
            end {if} ;
         end {for} ;
         message_code := resultat ;
      end {message_code_v1};

      var l : LETTRE ;
          message : STRING ;

   begin
      writeln('Exercice 7') ;
      writeln('tests de code_v1 et code_v2 : ') ; 
      writeln ;
      writeln('D''abord pour code_v1_bad et code_v1_debog (pour voir)') ;
      writeln('code_v1_bad(''B'') vaut ',code_v1_bad('B')) ;
      writeln('code_v1_bad(''Y'') vaut ',code_v1_bad('Y')) ;
      writeln('code_v1_debog(''B'') vaut ',code_v1_debog('B')) ;
      writeln('code_v1_debog(''Y'') vaut ',code_v1_debog('Y')) ;
      writeln ;
      writeln('Maintenant pour code_v1 et code_v2') ;
      writeln('code_v1(''B'') vaut ',code_v1('B')) ;
      writeln('code_v2(''B'') vaut ',code_v2('B')) ;
      writeln('code_v1(''Y'') vaut ',code_v1('Y')) ;
      writeln('code_v2(''Y'') vaut ',code_v2('Y')) ;
      writeln ;
      writeln('codage d''un message (premi�re version)') ;
      writeln('Votre message (en majuscules sans espace ni ponctuation) ?') ;
      readln(message) ;
      writeln(message_code_v1(message)) ;
      writeln(message_code_v1bis(message)) ;
      writeln(message_code_v2(message)) ;
      writeln ;
      writeln('codage d''un message (seconde version)') ;
      writeln('Votre message (en majuscules, �ventuellement avec espaces et ponctuation) ?') ;
      readln(message) ;
      writeln(message_code(message)) ;
   end {exercice_7} ;


BEGIN

//   exercice_1 ;
//   exercice_2 ;
//   exercice_3_et_4 ;
//   exercice_6 ;
   exercice_7 ;

END.

RESULTAT

Exercice 1
Les valeurs extr�males sont :
low(CARDINAL) = 0 et high(CARDINAL) = 4294967295
low(INTEGER) = -2147483648 et high(INTEGER) = 2147483647
low(BOOLEAN) = FALSE et high(BOOLEAN) = TRUE
low(CHAR) =  et high(CHAR) = �
low(CHIFFRE) = 0 et high(CHIFFRE) = 9             // remarquez qu'� l'affichage il n'y a
low(CHIFFRE_BIS) = 0 et high(CHIFFRE_BIS) = 9     // aucune diff�rence
low(LETTRE) = A et high(LETTRE) = Z
low(MAJUSCULE) = A et high(MAJUSCULE) = Z     // normal LETTRE = MAJUSCULE
low(MINUSCULE) = a et high(MINUSCULE) = z

Exercice 2
succ_bis('F') vaut G
succ_bis(high(CHAR)) vaut
pred_bis('F') vaut E
pred_bis(low(CHAR)) vaut �
avant inc_bis(c), c vaut T et apr�s inc_bis(c), c vaut U
avant inc_bis(c), c vaut � et apr�s inc_bis(c), c vaut
avant dec_bis(c), c vaut T et apr�s dec_bis(c), c vaut S
avant dec_bis(c), c vaut  et apr�s dec_bis(c), c vaut �
succ_ter('F') vaut G
succ_ter(high(CHAR)) vaut
pred_ter('F') vaut E
pred_ter(low(CHAR)) vaut �
avant inc_ter(c), c vaut T et apr�s inc_ter(c), c vaut U
avant inc_ter(c), c vaut � et apr�s inc_ter(c), c vaut
avant dec_ter(c), c vaut T et apr�s dec_ter(c), c vaut S
avant dec_ter(c), c vaut  et apr�s dec_ter(c), c vaut �

Exercice 3 et 4
martes
jueves
Quel jour choisissez-vous (en fran�ais) ?
mercredi
miercoles
jourSuivant(miercoles) vaut jueves
jourSuivant(SUNDAY) vaut lunes

Exercice 6
votre chiffre : 8
valeur_chiffre_v1('8') vaut 8
valeur_chiffre_v2('8') vaut 8

Exercice 7
tests de code_v1 et code_v2 :

D'abord pour code_v1_bad et code_v1_debog (pour voir)
code_v1_bad('B') vaut x         CA NE MARCHE PAS
code_v1_bad('Y') vaut           IDEM
code_v1_debog('B') vaut ���B    
TRUE
FALSE
autre choix                      ON PASSE DANS LE "ELSE"
%%%R
R                                LE RESULTAT EST TOUJOURS R
code_v1_debog('Y') vaut ���Y
FALSE
TRUE
autre choix                      IDEM
%%%R
R

Maintenant pour code_v1 et code_v2
code_v1('B') vaut E
code_v2('B') vaut E
code_v1('Y') vaut B
code_v2('Y') vaut B

codage d'un message (premi�re version)
Votre message (en majuscules sans espace ni ponctuation) ?
ALLEZ
DOOHC
DOOHC
DOOHC

codage d'un message (seconde version)
Votre message (en majuscules, �ventuellement avec espaces et ponctuation) ?
ALLEZ LES BLEUS, BRAVO
DOOHC OHV EOHXV, EUDYR


