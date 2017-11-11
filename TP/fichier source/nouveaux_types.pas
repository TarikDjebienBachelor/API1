{--------------------------------------------------------------------------------------------}
{-                                     nouveaux_types.pas                                   -}
{- Christian Lasou, 28/02/08                                                                -}
{- Déclarez des nouveaux types : intervalle et types énumérés                               -}
{- Les problèmes                                                                            -}
{--------------------------------------------------------------------------------------------}
program nouveaux_types ;

   // RAPPELS DE COURS
   // On peut déclarer des nouveaux types
   // Ces nouveaux types peuvent contenir
   //     - soit des valeurs déjà existantes dans un autre type
   //       et dans ce cas on déclare un intervalle de ces valeurs
   //       (ce nouveau type est alors plutôt un "sous-type")
   //       Voici deux exemples :

   type LETTRE  = 'A'..'Z' ;    // Le type LETTRE est un "sous-type" du type CHAR
        CHIFFRE = 0..9 ;        // Le type CHIFFRE est un "sous-type" de CARDINAL

   //     - soit de "vraies" nouvelles valeurs et on construit ainsi un vrai nouveau type
   //       Quelques exemples :

   type JOUR    = (LUNDI,MARDI,MERCREDI,JEUDI,VENDREDI,SAMEDI,DIMANCHE) ;
        COULEUR = (INDIGO,BLEU,VERT,JAUNE,ORANGE,ROUGE) ;

   // ATTENTION : ce sont bien de nouvelles valeurs et non des chaînes de caractères
   //                   LUNDI  n'est pas  'LUNDI'
   // et en particulier on ne peut pas écrire  write(j) si j est une variable de type JOUR
   // Pour la suite j'écris donc deux procédures d'affichage pour les valeurs de type JOUR
   // et pour les valeurs de type COULEUR

   procedure afficher_jour(const j : JOUR) ;
   begin
      case j of
         LUNDI    : write('lundi') ;
         MARDI    : write('mardi') ;
         MERCREDI : write('mercredi') ;
         JEUDI    : write('jeudi') ;
         VENDREDI : write('vendredi') ;
         SAMEDI   : write('samedi') ;
         DIMANCHE : write('dimanche') ;
      end {case} ;
   end {afficher_jour} ;

   procedure afficher_couleur(const c : COULEUR) ;
   begin
      case c of
         INDIGO : write('indigo') ;
         BLEU   : write('bleu') ;
         VERT   : write('vert') ;
         JAUNE  : write('jaune') ;
         ORANGE : write('orange') ;
         ROUGE  : write('rouge') ;
      end {case} ;
   end {afficher_couleur} ;

   // Les outils prédéfinis : low, high, ord, <nom_type>, pred, succ, inc, dec
   // Comme pour les types ordinaux prédéfinis (CARDINAL, INTEGER, CHAR, BOOLEAN)
   // ces outils existent mais comment fonctionnent-ils ? (TRES MAL !!!)

   procedure tester_low_et_high ;
   begin
      writeln('tester low et high') ;
      writeln('low(LETTRE) vaut ',low(LETTRE)) ;
      writeln('high(LETTRE) vaut ',high(LETTRE)) ;
      writeln('low(CHIFFRE) vaut ',low(CHIFFRE)) ;
      writeln('high(CHIFFRE) vaut ',high(CHIFFRE)) ;
      write('low(JOUR) vaut ') ; afficher_jour(low(JOUR)) ; writeln ;
      write('high(JOUR) vaut ') ; afficher_jour(high(JOUR)) ; writeln ;
      write('low(COULEUR) vaut ') ; afficher_couleur(low(COULEUR)) ; writeln ;
      write('high(COULEUR) vaut ') ; afficher_couleur(high(COULEUR)) ; writeln ;
      writeln ;
   end {tester_low_et_high} ;

   procedure tester_ord_et_reciproque ;
   begin
      writeln('tester ord et <reciproque>') ;
      writeln('ord(low(LETTRE)) vaut ',ord(low(LETTRE))) ;      // ATTENTION
      writeln('ord(high(LETTRE)) vaut ',ord(high(LETTRE))) ;    // regardez les résultats
      writeln('ord(low(CHIFFRE)) vaut ',ord(low(CHIFFRE))) ;    // pour ord on garde le ord
      writeln('ord(high(CHIFFRE)) vaut ',ord(high(CHIFFRE))) ;  // du type d'origine pour
      writeln('ord(low(JOUR)) vaut ',ord(low(JOUR))) ;          // un type intervalle
      writeln('ord(high(JOUR)) vaut ',ord(high(JOUR))) ;        // heureusement sinon on 
      writeln('ord(low(COULEUR)) vaut ', ord(low(COULEUR))) ;   // aurait 2 valeurs pour
      writeln('ord(high(COULEUR)) vaut ', ord(high(COULEUR))) ; // ord('A') si 'A' est LETTRE
      writeln ;                                                 // ou si 'A' est CHAR
      writeln('LETTRE(68)) vaut ',LETTRE(68)) ;  // ATTENTION : si ça correspond à une lettre
      writeln('LETTRE(52)) vaut ',LETTRE(52)) ;  // le résultat est correct sinon ...
      writeln('CHIFFRE(7)) vaut ',CHIFFRE(7)) ;  // en fait ça s'applique au type d'origine
      writeln('CHIFFRE(73)) vaut ',CHIFFRE(73)) ;
      write('JOUR(5) vaut ') ; afficher_jour(JOUR(5)) ; writeln ; // Ici c'est plus vicieux
      write('JOUR(12) vaut ') ; afficher_jour(JOUR(12)) ; writeln ;  // car il ne teste pas 
      write('COULEUR(5)) vaut ') ; afficher_couleur(COULEUR(5)) ; writeln ;// les débordements
      write('COULEUR(12)) vaut ') ; afficher_couleur(COULEUR(12)) ; writeln ;// et dans ce cas
      writeln ;                                                          // la réponse est ???
   end {tester_ord_et_reciproque} ;

   procedure tester_pred_succ_dec_et_inc ;
   var l : LETTRE ;
       c : CHIFFRE ;
       j : JOUR ;
       co : COULEUR ; 
   begin
      writeln('tester pred') ;
      writeln('pred(''F'')) vaut ',pred('F')) ;  // ATTENTION ça marche mais encore une fois
      writeln('pred(low(LETTRE)) vaut ',pred(low(LETTRE))) ; // c'est sur le type d'origine 
      writeln('pred(7) vaut ',pred(7)) ;                     // et non le sous-type
      writeln('pred(low(CHIFFRE)) vaut ',pred(low(CHIFFRE))) ;
      write('pred(MERCREDI) vaut ') ; afficher_jour(pred(MERCREDI)) ; writeln ;
  //    write('pred(low(JOUR)) vaut ') ; afficher_jour(pred(low(JOUR))) ;// REFUSE à la compil
      write('pred(VERT) vaut ') ; afficher_couleur(pred(VERT)) ; writeln ;
  //    write('pred(low(COULEUR)) vaut ') ; afficher_couleur(pred(low(COULEUR))) ; // REFUSE
      writeln ;                                                                 // à la compil
      writeln('tester succ') ;
      writeln('succ(''F'')) vaut ',succ('F')) ;  // ATTENTION ça marche mais encore une fois
      writeln('succ(high(LETTRE)) vaut ',succ(high(LETTRE))) ; // c'est sur le type d'origine 
      writeln('succ(7) vaut ',succ(7)) ;                     // et non le sous-type
      writeln('succ(high(CHIFFRE)) vaut ',succ(high(CHIFFRE))) ;
      write('succ(MERCREDI) vaut ') ; afficher_jour(succ(MERCREDI)) ; writeln ;
   // write('succ(high(JOUR)) vaut ') ; afficher_jour(succ(high(JOUR))) ;// REFUSE à la compil
      write('succ(VERT) vaut ') ; afficher_couleur(succ(VERT)) ; writeln ;
   //   write('succ(high(COULEUR)) vaut ') ; afficher_couleur(succ(high(COULEUR))) ; // REFUSE
      writeln ;                                                                 // à la compil
      writeln('tester dec') ;
      // cette fois j'ai besoin de variables pour les décrémenter
      l := 'F' ;
      writeln('avant dec(l), l vaut ',l) ;
      dec(l) ;
      writeln('après dec(l), l vaut ',l) ;
      l := low(LETTRE) ; ;
      writeln('avant dec(l), l vaut ',l) ;
    //  dec(l) ;  // ici erreur à l'exécution car l n'est plus une LETTRE, c'est rassurant
    //  writeln('après dec(l), l vaut ',l) ;
      c := 7 ;
      writeln('avant dec(c), c vaut ',c) ;
      dec(c) ;
      writeln('après dec(c), c vaut ',c) ;
      c := low(CHIFFRE) ; ;
      writeln('avant dec(c), c vaut ',c) ;
      dec(c) ;  // par contre ici pas d'erreur à l'exécution mais résultat faux et donc pas
      writeln('après dec(c), c vaut ',c) ; // de cohérence dans les comportements !!!
      j := MERCREDI ;
      write('avant dec(j), j vaut ') ; afficher_jour(j) ; writeln ;
      dec(j) ;
      write('après dec(j), j vaut ') ; afficher_jour(j) ; writeln ;
      j := low(JOUR) ; ;
      write('avant dec(j), j vaut ') ; afficher_jour(j) ; writeln ;
    //  dec(j) ;  // ici erreur à l'exécution car j n'est plus un JOUR, c'est rassurant
    //  writeln('après dec(j), j vaut ') ; afficher_jour(j) ;
      co := VERT ;
      write('avant dec(co), co vaut ') ; afficher_couleur(co) ; writeln ;
      dec(co) ;
      write('après dec(co), co vaut ') ; afficher_couleur(co) ; writeln ;
      co := low(COULEUR) ; ;
      write('avant dec(co), co vaut ') ; afficher_couleur(co) ; writeln ;
    //  dec(co) ;  // ici erreur à l'exécution car co n'est plus une COULEUR, c'est rassurant
    //  writeln('après dec(co), co vaut ') ; afficher_couleur(co) ;
      writeln ;
      writeln('tester inc') ;
      l := 'F' ;
      writeln('avant inc(l), l vaut ',l) ;
      inc(l) ;
      writeln('après inc(l), l vaut ',l) ;
      l := high(LETTRE) ; ;
      writeln('avant inc(l), l vaut ',l) ;
    //  inc(l) ;  // ici erreur à l'exécution car l n'est plus une LETTRE, c'est rassurant
    //   writeln('après inc(l), l vaut ',l) ;
      c := 7 ;
      writeln('avant inc(c), c vaut ',c) ;
      inc(c) ;
      writeln('après inc(c), c vaut ',c) ;
      c := high(CHIFFRE) ; ;
      writeln('avant inc(c), c vaut ',c) ;
      inc(c) ;  // par contre ici pas d'erreur à l'exécution mais résultat faux et donc pas
      writeln('après inc(c), c vaut ',c) ; // de cohérence dans les comportements !!!
      j := MERCREDI ;
      write('avant inc(j), j vaut ') ; afficher_jour(j) ; writeln ;
      inc(j) ;
      write('après inc(j), j vaut ') ; afficher_jour(j) ; writeln ;
      j := high(JOUR) ; ;
      write('avant inc(j), j vaut ') ; afficher_jour(j) ; writeln ;
    //  inc(j) ;  // ici erreur à l'exécution car j n'est plus un JOUR, c'est rassurant
    //  writeln('après dec(j), j vaut ') ; afficher_jour(j) ;
      co := VERT ;
      write('avant inc(co), co vaut ') ; afficher_couleur(co) ; writeln ;
      inc(co) ;
      write('après inc(co), co vaut ') ; afficher_couleur(co) ; writeln ;
      co := high(COULEUR) ; ;
      write('avant inc(co), co vaut ') ; afficher_couleur(co) ; writeln ;
    //   inc(co) ;  // ici erreur à l'exécution car co n'est plus une COULEUR, c'est rassurant
    //   writeln('après dec(co), co vaut ') ; afficher_couleur(co) ;
      writeln ;
   end {tester_pred_succ_dec_et_inc} ;

   // Je terminerai enfin par une "curiosité" qui a de quoi nous interpeler
   // c'est la non-cohérence entre la comparaison entre 2 élément d'un sous-type dans un
   // test et dans un "case"

   procedure tester_if_et_case ;

   var l : LETTRE ;
       c : CHIFFRE ;

   begin
      writeln('tester if avec le type LETTRE') ;
      l := 'G' ;
      writeln('l = ''G'' vaut ',l = 'G') ;
      // maintenant je fais un "if"
      if l = 'G' then writeln(l,' vaut ''G''') 
                 else writeln(l,' ne vaut pas ''G''') ;
      writeln('tester if avec le type CHIFFRE') ;
      c := 7 ;
      writeln('c = 7 vaut ',c = 7) ;
      // maintenant je fais un "if"
      if c = 7 then writeln(c,' vaut 7') 
               else writeln(c,' ne vaut pas 7') ;
      writeln ;
      writeln('tester case avec le type LETTRE') ;
      l := 'G' ;
      writeln('l = ''G'' vaut ',l = 'G') ;
      // maintenant je fais un case
      case l of
         'A'..'F' : writeln(l,' est avant ''G''') ;
         'G'      : writeln(l,' vaut ''G''') ;
         'H'..'Z' : writeln(l,' est après ''G''') ; 
      else
         writeln(l,' n''est pas dans l''intervalle ''A''..''Z''') ;
      end {case} ;
      writeln('tester case avec le type CHIFFRE') ;
      c := 7 ;
      writeln('c = 7 vaut ',c = 7) ;
      // maintenant je fais un case
      case c of
         0..6 : writeln(c,' est avant 7') ;
         7    : writeln(c,' vaut 7') ;
         8..9 : writeln(c,' est après 7') ; 
      else
         writeln(c,' n''est pas dans l''intervalle 0..9') ;
      end {case} ;
   end {tester_case} ;

   var l : LETTRE ;

BEGIN

   tester_low_et_high ;
   tester_ord_et_reciproque ;
   tester_pred_succ_dec_et_inc ;
   tester_if_et_case ;
END.

RESULTAT

tester low et high
low(LETTRE) vaut A
high(LETTRE) vaut Z
low(CHIFFRE) vaut 0
high(CHIFFRE) vaut 9
low(JOUR) vaut lundi
high(JOUR) vaut dimanche
low(COULEUR) vaut indigo
high(COULEUR) vaut rouge


tester ord et <reciproque>
ord(low(LETTRE)) vaut 65
ord(high(LETTRE)) vaut 90
ord(low(CHIFFRE)) vaut 0
ord(high(CHIFFRE)) vaut 9
ord(low(JOUR)) vaut 0
ord(high(JOUR)) vaut 6
ord(low(COULEUR)) vaut 0
ord(high(COULEUR)) vaut 5

LETTRE(68)) vaut D
LETTRE(52)) vaut 4          // bizarre
CHIFFRE(7)) vaut 7
CHIFFRE(73)) vaut 73        // idem
JOUR(5) vaut samedi
JOUR(12) vaut               // pas de réponse
COULEUR(5)) vaut rouge
COULEUR(12)) vaut           // idem

tester pred
pred('F')) vaut E
pred(low(LETTRE)) vaut @    // pred se comporte comme sur CHAR
pred(7) vaut 6
pred(low(CHIFFRE)) vaut -1  // pred se comporte comme sur INTEGER
pred(MERCREDI) vaut mardi
pred(VERT) vaut bleu


tester succ
succ('F')) vaut G
succ(high(LETTRE)) vaut [    // succ se comporte comme sur CHAR
succ(7) vaut 8
succ(high(CHIFFRE)) vaut 10  // succ se comporte comme sur INTEGER (ou CARDINAL)
succ(MERCREDI) vaut jeudi
succ(VERT) vaut jaune

tester dec
avant dec(l), l vaut F
après dec(l), l vaut E
avant dec(l), l vaut A
Runtime error 201 at $08048F1E        // normal si l est LETTRE, l ne peut valoir pred('A')
  $08048F1E  TESTER_PRED_SUCC_DEC_ET_INC,  line 132 of nouveaux_types.pas
  $0804962F  main,  line 201 of nouveaux_types.pas

avant dec(c), c vaut 7
après dec(c), c vaut 6
avant dec(c), c vaut 0
après dec(c), c vaut -1         // par contre ici pas d'eereur et mon CHIFFRE c vaut -1 !!!!
avant dec(j), j vaut mercredi
après dec(j), j vaut mardi
avant dec(j), j vaut lundi
Runtime error 201 at $08049117     // normal j ne peut pas valoir pred(LUNDI)
  $08049117  TESTER_PRED_SUCC_DEC_ET_INC,  line 148 of nouveaux_types.pas
  $0804962F  main,  line 201 of nouveaux_types.pas

avant dec(co), co vaut vert
après dec(co), co vaut bleu
avant dec(co), co vaut indigo
Runtime error 201 at $080491FF    // normal
  $080491FF  TESTER_PRED_SUCC_DEC_ET_INC,  line 156 of nouveaux_types.pas
  $0804962F  main,  line 201 of nouveaux_types.pas

tester inc
avant inc(l), l vaut F
après inc(l), l vaut G
avant inc(l), l vaut Z
Runtime error 201 at $08049319    // normal
  $08049319  TESTER_PRED_SUCC_DEC_ET_INC,  line 166 of nouveaux_types.pas
  $0804962F  main,  line 201 of nouveaux_types.pas

avant inc(c), c vaut 7
après inc(c), c vaut 8
avant inc(c), c vaut 9
après inc(c), c vaut 10  // ICI ce n'est pas normal car 10 n'est pas un CHIFFRE !!!
avant inc(j), j vaut mercredi
après inc(j), j vaut jeudi
avant inc(j), j vaut dimanche
Runtime error 201 at $08049512   // normal
  $08049512  TESTER_PRED_SUCC_DEC_ET_INC,  line 182 of nouveaux_types.pas
  $0804962F  main,  line 201 of nouveaux_types.pas

avant inc(co), co vaut vert
après inc(co), co vaut jaune
avant inc(co), co vaut rouge
Runtime error 201 at $080495FA  // normal
  $080495FA  TESTER_PRED_SUCC_DEC_ET_INC,  line 190 of nouveaux_types.pas
  $0804962F  main,  line 201 of nouveaux_types.pas


tester if avec le type LETTRE
l = 'G' vaut TRUE
G vaut 'G'                           // pour le "if"
tester if avec le type CHIFFRE       // tout marche correctement
c = 7 vaut TRUE
7 vaut 7

tester case avec le type LETTRE
l = 'G' vaut TRUE                         // ici le test vaut VRAI
G n'est pas dans l'intervalle 'A'..'Z'    // ici non puisqu'il passe par le "else"
tester case avec le type CHIFFRE
c = 7 vaut TRUE                           // ici c'est correct 
7 vaut 7                                  // dans les 2 cas


