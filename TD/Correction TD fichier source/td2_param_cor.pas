{--------------------------------------------------------------------------------------------}
{-                                     td2_param_cor.pas                                    -}
{- Christian Lasou, 17/01/09                                                                -}
{- Corrections des exercices du TD2 sur les passages de paramètres                          -}
{- Chaque procédure correspond à un exercice                                                -}
{--------------------------------------------------------------------------------------------}
program td1_cor_ordinaux ;
{$X-}

//////////////////////
// RAPPELS DE COURS //
//////////////////////

// EN THEORIE
// °°°°°°°°°°

// 3 passages de paramètres : en entrée, en sortie et en entrée-sortie
//        en entrée : le paramètre est une valeur et on ne peut la modifier
//                    (cette valeur peut être le résultat d'une expression ou la valeur
//                    d'une variable)
//        en sortie : le paramètre doit être une variable qui n'a pas une valeur déterminée et
//                    à laquelle on va donner une valeur 
//        en entrée-sortie : le paramètre doit être une variable qui a une valeur initiale et
//                    à laquelle on va donner une valeur qui peut dépendre de cette valeur
//                    initiale

// EN PRATIQUE EN PASCAL
//°°°°°°°°°°°°°°°°°°°°°°

// 4 possibilités
//        en entrée : avec le mot-clé "const" impossibilité de modifier la valeur
//                    sans le mot-clés on peut modifier la valeur mais à la fin la modification
//                    n'est pas prise en compte et on revient à la valeur initiale
//        en sortie : on doit utiliser le mot-clé "out", dans ce cas la valeur initiale doit
//                    être considérée comme indéterminée et on doit donner au paramètre une 
//                    valeur
//        en entrée-sortie : on doit utiliser le mot-cle "var", dans ce la valeur initiale du 
//                    paramètre est celle juste avant l'entrée dans la procédure et est sensée 
//                    être modifiée par la procédure              

// EXEMPLES
// °°°°°°°°

// Voici trois procédures pour tester les 3 (4) modes de passages

   procedure tester_entree ;

      // une procédure sans le mot-cle "const"
      procedure  sans_const(n : CARDINAL) ;
      begin
         writeln('n vaut ', n) ;
         n := 5 ;
         writeln('n vaut ', n) ;
         writeln('le double de n vaut ', 2*n) ;
      end {sans_const} ; 

      // la même avec le mot-cle "const"
      procedure  avec_const(const n : CARDINAL) ;
      begin
         writeln('n vaut ', n) ;
         n := 5 ;                  // cette ligne sera refusée par le compilateur
         writeln('n vaut ', n) ;   // mettez-la ensuite en commentaire
         writeln('le double de n vaut ', 2*n) ;
      end {avec_const} ; 

      var nb : CARDINAL ;

   begin
      writeln('procédure tester_entree') ;
      // je donne une valeur à nb
      nb := 2 ;
      writeln('nb vaut ',nb) ;
      // 3 appels de la procédure sans_const
      writeln('on entre dans sans_const(17)') ; 
      sans_const(17) ;  // ici on n'utilise pas nb
      writeln('on sort de sans_const(17)') ; 
      writeln('on entre dans sans_const(nb)') ; 
      sans_const(nb) ;
      writeln('après sans_const(nb), nb vaut ',nb) ;
      writeln('on entre dans sans_const(2*nb+7)') ; 
      sans_const(2*nb+7) ; // ici j'utilise une expression 
      writeln('après sans_const(2*nb+7), nb vaut ',nb) ;
      // 3 appels de la procédure avec_const
      // ici on aura pas de surprise puisque n := 5 a été mis en commentaire
      writeln('on entre dans avec_const(17)') ; 
      avec_const(17) ;  // ici on n'utilise pas nb
      writeln('on sort de avec_const(17)') ; 
      writeln('on entre dans avec_const(nb)') ; 
      avec_const(nb) ;
      writeln('après avec_const(nb), nb vaut ',nb) ;
      writeln('on entre dans avec_const(2*nb+7)') ; 
      avec_const(2*nb+7) ; // ici j'utilise une expression 
      writeln('après avec_const(2*nb+7), nb vaut ',nb) ;
   end {tester_entree} ;

   procedure tester_sortie ;

      // une procédure correcte avec un paramètre en sortie
      procedure avec_out(out n : CARDINAL) ;
      begin
         writeln('voyons ce que vaut n a priori') ;
         writeln('n vaut ', n) ;
         writeln('choisissez maintenant une nouvelle valeur pour n') ;
         write('n = ') ; readln(n) ;
         writeln('maintenant n vaut ', n) ;
         writeln('on quitte la procédure avec_out') ;
      end {avec_out} ;
 
      // la même procédure mais incorrecte car on a oublié le out
      // ATTENTION ça passe le cap de la compilation
      procedure sans_out(n : CARDINAL) ;
      begin
         writeln('voyons ce que vaut n a priori') ;
         writeln('n vaut ', n) ;
         writeln('choisissez maintenant une nouvelle valeur pour n') ;
         write('n = ') ; readln(n) ;
         writeln('maintenant n vaut ', n) ;
         writeln('on quitte la procédure sans_out') ;
      end {sans_out} ;
 
      var nb : CARDINAL ;

   begin
      writeln('procédure tester_sortie') ;
      writeln('pour la procédure avec_out') ;
      // je donne une valeur à nb
      nb := 2 ;
      writeln('avant d''entrer dans avec_out nb vaut ',nb) ;
      writeln('on essaie d''entrer dans avec_out(17)') ; 
      avec_out(17) ;  // c'est refusé le paramètre doit être une variable 
      writeln('on est sorti de avec_out(17) puisqu''on n''y est pas entré !!!') ; 
      writeln('on entre dans avec_out(nb)') ; 
      avec_out(nb) ;
      writeln('après avec_out(nb), nb vaut ',nb) ;
      writeln('on essaie d''entrer dans avec_out(2*nb+7)') ;  
      avec_out(2*nb+7) ; // refusé pour la même raison 
      writeln('pour la procédure sans_out') ;
      nb := 2 ;
      writeln('avant d''entrer dans sans_out nb vaut ',nb) ;
      writeln('on essaie d''entrer dans sans_out(17)') ; 
      sans_out(17) ;  // c'est accepté 
      writeln('on est sorti de sans_out(17)') ;
      writeln('après sans_out(nb), nb vaut ',nb,', normal on n''y a pas touché') ;
      writeln('on entre dans sans_out(nb)') ; 
      sans_out(nb) ;
      writeln('après sans_out(nb), nb vaut ',nb,', normal n était en entrée sans const') ;
      writeln('on entre dans sans_out(2*nb+7)') ;  
      sans_out(2*nb+7) ; // c'est accepté
      writeln('après sans_out(2*nb+7), nb vaut ',nb,', normal pour la même raison') ;       
   end {tester_sortie} ;

   procedure tester_entree_sortie ;

      // une procédure correcte avec un paramètre en entree_sortie
      procedure avec_var(var n : CARDINAL) ;
      begin
         writeln('voyons ce que vaut n a priori') ;
         writeln('n vaut ', n) ;
         writeln('choisissez maintenant une nouvelle valeur pour n') ;
         write('n = ') ; readln(n) ;
         writeln('maintenant n vaut ', n) ;
         writeln('on quitte la procédure avec_var') ;
      end {avec_out} ;
 
      // la même procédure mais incorrecte car on a oublié le var
      // ATTENTION ça passe le cap de la compilation
      procedure sans_var(n : CARDINAL) ;
      begin
         writeln('voyons ce que vaut n a priori') ;
         writeln('n vaut ', n) ;
         writeln('choisissez maintenant une nouvelle valeur pour n') ;
         write('n = ') ; readln(n) ;
         writeln('maintenant n vaut ', n) ;
         writeln('on quitte la procédure sans_var') ;
      end {sans_var} ;
 
      var nb : CARDINAL ;

   begin
      writeln('procédure tester_entree_sortie') ;
      writeln('pour la procédure avec_var') ;
      // je donne une valeur à nb
      nb := 2 ;
      writeln('avant d''entrer dans avec_var nb vaut ',nb) ;
      writeln('on essaie d''entrer dans avec_var(17)') ; 
      avec_var(17) ;  // c'est refusé le paramètre doit être une variable 
      writeln('on est sorti de avec_var(17) puisqu''on n''y est pas entré !!!') ; 
      writeln('on entre dans avec_var(nb)') ; 
      avec_var(nb) ;
      writeln('après avec_var(nb), nb vaut ',nb) ;
      writeln('on essaie d''entrer dans avec_var(2*nb+7)') ;  
      avec_var(2*nb+7) ; // refusé pour la même raison 
      writeln('pour la procédure sans_var') ;
      nb := 2 ;
      writeln('avant d''entrer dans sans_var nb vaut ',nb) ;
      writeln('on essaie d''entrer dans sans_var(17)') ; 
      sans_var(17) ;  // c'est accepté 
      writeln('on est sorti de sans_var(17)') ;
      writeln('après sans_var(nb), nb vaut ',nb,', normal on n''y a pas touché') ;
      writeln('on entre dans sans_var(nb)') ; 
      sans_var(nb) ;
      writeln('après sans_var(nb), nb vaut ',nb,', normal n était en entrée sans const') ;
      writeln('on entre dans sans_var(2*nb+7)') ;  
      sans_var(2*nb+7) ; // c'est accepté
      writeln('après sans_var(2*nb+7), nb vaut ',nb,', normal pour la même raison') ;       
   end {tester_entree_sortie} ;

// ON PASSE MAINTENANT AUX EXERCICES DU TD PROPREMENT DIT

   // Chaque exercice fera l'objet d'une procédure

   procedure exercice_1 ;

      procedure question_1 ;

         // je déclare la procédure p en prenant un exemple
         procedure p(const x : CARDINAL ; out y : BOOLEAN) ;
         begin
             y := (x = 5) ;   
         end {p} ;

         // idem pour la fonction f
         function f(const x : CARDINAL) : CARDINAL ;
         begin
            f := 2*x+1 ;
         end {f} ;

         var x, y : BOOLEAN ;
             z, t : CARDINAL ;
             a : CARDINAL ;  // pour l'instruction 5

      begin
         writeln('question_1') ;
         // je donne des valeurs initiales à x, y, z et t 
         x := TRUE ; y := FALSE ; z := 7 ; t := 13 ;
         // maintenant j'écris les instructions proposées pour voir si elles sont valides et
         // si elles sont refusées par le compilateur je mettrai pourquoi derrière en commentaire
         // 1
         p(z,x) ;
         // 2
         // p(1,TRUE) ;     // TRUE n'est pas une variable
         // 3
         p(2*z,x) ;
         // 4
         // p(z,x and y) ;  // x and y n'est pas une variable
         // 5
         // a := p(z,x) ;   // p(z,x) n'est pas une valeur    
         // 6
         // f(z) := t ;     // f(z) n'est pas une variable
         // 7
         z := f(t) ;
         // 8
         z := f(2*z) ;
         // 9
         // if f(z) then begin    // f(z) n'est pas un booléen 
         //   writeln('9 est correct') ;
         // end {if} ;
         // 10
         // f(z) ;  // accepté mais refusé avec la directive {$X-} 
         // 11
         p(f(z), x) ;
         // 12
         // z := f(p(z,x)) ;  // p(z,x) n'est pas une valeur
      end {question_1} ;

      procedure question_2 ;

         procedure p(const x : INTEGER ; var y : INTEGER) ;
            var z : INTEGER ;
         begin
            z := x+y ;
            y := z-2*y ;
         end {p} ;

         var x, y, z : INTEGER ;

      begin
         writeln('question 2') ;
         // l'énoncé est ambigüe 
         // ou bien on part à chaque fois des valeurs initiales x vaut 1, 
         // y vaut2 et z vaut 3
         // ou bien on part des ces 3 valeurs mais les instructions sont ensuite
         // enchaînées et bien sûr on obtient pas les mêmes résultats
         // On va bien sûr voir les deux options
         // La première : on initialise x, y et z avant chaque appel de p
         writeln('On initialise x, y et z avant chaque appel à p') ;
         x := 1 ; y := 2 ; z := 3 ;
         writeln('avant p(x,y), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         p(x,y) ;
         writeln('après p(x,y), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         x := 1 ; y := 2 ; z := 3 ;
         writeln('avant p(y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         p(y,z) ;
         writeln('après p(y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         x := 1 ; y := 2 ; z := 3 ;
         writeln('avant p(x+y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         p(x+y,z) ;
         writeln('après p(x+y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         // La seconde : on initialise x, y et z une seule fois avant le
         // premier appel de p
         writeln('On initialise x, y et z une seule fois') ;
         x := 1 ; y := 2 ; z := 3 ;
         writeln('avant p(x,y), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         p(x,y) ;
         writeln('après p(x,y), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         writeln('avant p(y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         p(y,z) ;
         writeln('après p(y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         writeln('avant p(x+y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         p(x+y,z) ;
         writeln('après p(x+y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
      end {question_2} ;

   begin
      writeln('exercice_1') ;
      question_1 ;
      question_2 ;
   end {exercice_1} ;

   procedure exercice_2 ;

      type JOUR = (LUNDI,MARDI,MERCREDI,JEUDI,VENDREDI,SAMEDI,DIMANCHE) ;

      procedure LireJour_v1(out j : JOUR) ;
      // une saisie à l'aide d'un nombre 1 pour LUNDI, 2 pour MARDI etc
      var n : CARDINAL; 
      begin
         readln(n) ;
         j := JOUR(n-1) ;
      end {LireJour_v1} ;

      procedure LireJour_v2(out j : JOUR) ;
      // saisie à l'aide d'une chaine de caractère en minuscules
      var s : STRING ; 
      begin
         readln(s) ;
         if s = 'lundi' then begin
         end else begin
            if s = 'mardi' then begin
         end else begin
         if then begin
         end else begin
         if then begin
         end else begin
         if then begin
         end else begin
         if then begin
         end else begin
         end {if} ;
         end {if} ;
         end {if} ;
         end {if} ;
         end {if} ;
         end {if} ;
      end {LireJour_v2} ;

      procedure EcrireJour(const j : JOUR) ;
      begin
         case j of
            LUNDI    : write('LUNDI') ;
            MARDI    : write('MARDI') ;
            MERCREDI : write('MERCREDI') ;
            JEUDI    : write('JEUDI') ;
            VENDREDI : write('VENDREDI') ;
            SAMEDI   : write('SAMEDI') ;
            DIMANCHE : write('DIMANCHE') ;
         end {case} ;
      end {EcrireJour} ;

      var j : JOUR ;

   begin
      writeln('exercice_2') ;
      writeln('saisie à l''aide d''un naturel') ;
      write('choisissez un jour (1 pour LUNDI, 2 pour MARDI etc.) : ') ;
      LireJour_v1(j) ;
      write('vous avez choisi ') ; EcrireJour(j) ; writeln ;
   end {exercice_2} ;

BEGIN
   
   tester_entree ;
   tester_sortie ;

   exercice_1 ;
//   exercice_2 ;
//   exercice_3_et_4 ;
//   exercice_6 ;
//   exercice_7 ;

END.

RESULTAT

