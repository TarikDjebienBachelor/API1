{--------------------------------------------------------------------------------------------}
{-                                     td2_param_cor.pas                                    -}
{- Christian Lasou, 17/01/09                                                                -}
{- Corrections des exercices du TD2 sur les passages de param�tres                          -}
{- Chaque proc�dure correspond � un exercice                                                -}
{--------------------------------------------------------------------------------------------}
program td1_cor_ordinaux ;
{$X-}

//////////////////////
// RAPPELS DE COURS //
//////////////////////

// EN THEORIE
// ����������

// 3 passages de param�tres : en entr�e, en sortie et en entr�e-sortie
//        en entr�e : le param�tre est une valeur et on ne peut la modifier
//                    (cette valeur peut �tre le r�sultat d'une expression ou la valeur
//                    d'une variable)
//        en sortie : le param�tre doit �tre une variable qui n'a pas une valeur d�termin�e et
//                    � laquelle on va donner une valeur 
//        en entr�e-sortie : le param�tre doit �tre une variable qui a une valeur initiale et
//                    � laquelle on va donner une valeur qui peut d�pendre de cette valeur
//                    initiale

// EN PRATIQUE EN PASCAL
//����������������������

// 4 possibilit�s
//        en entr�e : avec le mot-cl� "const" impossibilit� de modifier la valeur
//                    sans le mot-cl�s on peut modifier la valeur mais � la fin la modification
//                    n'est pas prise en compte et on revient � la valeur initiale
//        en sortie : on doit utiliser le mot-cl� "out", dans ce cas la valeur initiale doit
//                    �tre consid�r�e comme ind�termin�e et on doit donner au param�tre une 
//                    valeur
//        en entr�e-sortie : on doit utiliser le mot-cle "var", dans ce la valeur initiale du 
//                    param�tre est celle juste avant l'entr�e dans la proc�dure et est sens�e 
//                    �tre modifi�e par la proc�dure              

// EXEMPLES
// ��������

// Voici trois proc�dures pour tester les 3 (4) modes de passages

   procedure tester_entree ;

      // une proc�dure sans le mot-cle "const"
      procedure  sans_const(n : CARDINAL) ;
      begin
         writeln('n vaut ', n) ;
         n := 5 ;
         writeln('n vaut ', n) ;
         writeln('le double de n vaut ', 2*n) ;
      end {sans_const} ; 

      // la m�me avec le mot-cle "const"
      procedure  avec_const(const n : CARDINAL) ;
      begin
         writeln('n vaut ', n) ;
         n := 5 ;                  // cette ligne sera refus�e par le compilateur
         writeln('n vaut ', n) ;   // mettez-la ensuite en commentaire
         writeln('le double de n vaut ', 2*n) ;
      end {avec_const} ; 

      var nb : CARDINAL ;

   begin
      writeln('proc�dure tester_entree') ;
      // je donne une valeur � nb
      nb := 2 ;
      writeln('nb vaut ',nb) ;
      // 3 appels de la proc�dure sans_const
      writeln('on entre dans sans_const(17)') ; 
      sans_const(17) ;  // ici on n'utilise pas nb
      writeln('on sort de sans_const(17)') ; 
      writeln('on entre dans sans_const(nb)') ; 
      sans_const(nb) ;
      writeln('apr�s sans_const(nb), nb vaut ',nb) ;
      writeln('on entre dans sans_const(2*nb+7)') ; 
      sans_const(2*nb+7) ; // ici j'utilise une expression 
      writeln('apr�s sans_const(2*nb+7), nb vaut ',nb) ;
      // 3 appels de la proc�dure avec_const
      // ici on aura pas de surprise puisque n := 5 a �t� mis en commentaire
      writeln('on entre dans avec_const(17)') ; 
      avec_const(17) ;  // ici on n'utilise pas nb
      writeln('on sort de avec_const(17)') ; 
      writeln('on entre dans avec_const(nb)') ; 
      avec_const(nb) ;
      writeln('apr�s avec_const(nb), nb vaut ',nb) ;
      writeln('on entre dans avec_const(2*nb+7)') ; 
      avec_const(2*nb+7) ; // ici j'utilise une expression 
      writeln('apr�s avec_const(2*nb+7), nb vaut ',nb) ;
   end {tester_entree} ;

   procedure tester_sortie ;

      // une proc�dure correcte avec un param�tre en sortie
      procedure avec_out(out n : CARDINAL) ;
      begin
         writeln('voyons ce que vaut n a priori') ;
         writeln('n vaut ', n) ;
         writeln('choisissez maintenant une nouvelle valeur pour n') ;
         write('n = ') ; readln(n) ;
         writeln('maintenant n vaut ', n) ;
         writeln('on quitte la proc�dure avec_out') ;
      end {avec_out} ;
 
      // la m�me proc�dure mais incorrecte car on a oubli� le out
      // ATTENTION �a passe le cap de la compilation
      procedure sans_out(n : CARDINAL) ;
      begin
         writeln('voyons ce que vaut n a priori') ;
         writeln('n vaut ', n) ;
         writeln('choisissez maintenant une nouvelle valeur pour n') ;
         write('n = ') ; readln(n) ;
         writeln('maintenant n vaut ', n) ;
         writeln('on quitte la proc�dure sans_out') ;
      end {sans_out} ;
 
      var nb : CARDINAL ;

   begin
      writeln('proc�dure tester_sortie') ;
      writeln('pour la proc�dure avec_out') ;
      // je donne une valeur � nb
      nb := 2 ;
      writeln('avant d''entrer dans avec_out nb vaut ',nb) ;
      writeln('on essaie d''entrer dans avec_out(17)') ; 
      avec_out(17) ;  // c'est refus� le param�tre doit �tre une variable 
      writeln('on est sorti de avec_out(17) puisqu''on n''y est pas entr� !!!') ; 
      writeln('on entre dans avec_out(nb)') ; 
      avec_out(nb) ;
      writeln('apr�s avec_out(nb), nb vaut ',nb) ;
      writeln('on essaie d''entrer dans avec_out(2*nb+7)') ;  
      avec_out(2*nb+7) ; // refus� pour la m�me raison 
      writeln('pour la proc�dure sans_out') ;
      nb := 2 ;
      writeln('avant d''entrer dans sans_out nb vaut ',nb) ;
      writeln('on essaie d''entrer dans sans_out(17)') ; 
      sans_out(17) ;  // c'est accept� 
      writeln('on est sorti de sans_out(17)') ;
      writeln('apr�s sans_out(nb), nb vaut ',nb,', normal on n''y a pas touch�') ;
      writeln('on entre dans sans_out(nb)') ; 
      sans_out(nb) ;
      writeln('apr�s sans_out(nb), nb vaut ',nb,', normal n �tait en entr�e sans const') ;
      writeln('on entre dans sans_out(2*nb+7)') ;  
      sans_out(2*nb+7) ; // c'est accept�
      writeln('apr�s sans_out(2*nb+7), nb vaut ',nb,', normal pour la m�me raison') ;       
   end {tester_sortie} ;

   procedure tester_entree_sortie ;

      // une proc�dure correcte avec un param�tre en entree_sortie
      procedure avec_var(var n : CARDINAL) ;
      begin
         writeln('voyons ce que vaut n a priori') ;
         writeln('n vaut ', n) ;
         writeln('choisissez maintenant une nouvelle valeur pour n') ;
         write('n = ') ; readln(n) ;
         writeln('maintenant n vaut ', n) ;
         writeln('on quitte la proc�dure avec_var') ;
      end {avec_out} ;
 
      // la m�me proc�dure mais incorrecte car on a oubli� le var
      // ATTENTION �a passe le cap de la compilation
      procedure sans_var(n : CARDINAL) ;
      begin
         writeln('voyons ce que vaut n a priori') ;
         writeln('n vaut ', n) ;
         writeln('choisissez maintenant une nouvelle valeur pour n') ;
         write('n = ') ; readln(n) ;
         writeln('maintenant n vaut ', n) ;
         writeln('on quitte la proc�dure sans_var') ;
      end {sans_var} ;
 
      var nb : CARDINAL ;

   begin
      writeln('proc�dure tester_entree_sortie') ;
      writeln('pour la proc�dure avec_var') ;
      // je donne une valeur � nb
      nb := 2 ;
      writeln('avant d''entrer dans avec_var nb vaut ',nb) ;
      writeln('on essaie d''entrer dans avec_var(17)') ; 
      avec_var(17) ;  // c'est refus� le param�tre doit �tre une variable 
      writeln('on est sorti de avec_var(17) puisqu''on n''y est pas entr� !!!') ; 
      writeln('on entre dans avec_var(nb)') ; 
      avec_var(nb) ;
      writeln('apr�s avec_var(nb), nb vaut ',nb) ;
      writeln('on essaie d''entrer dans avec_var(2*nb+7)') ;  
      avec_var(2*nb+7) ; // refus� pour la m�me raison 
      writeln('pour la proc�dure sans_var') ;
      nb := 2 ;
      writeln('avant d''entrer dans sans_var nb vaut ',nb) ;
      writeln('on essaie d''entrer dans sans_var(17)') ; 
      sans_var(17) ;  // c'est accept� 
      writeln('on est sorti de sans_var(17)') ;
      writeln('apr�s sans_var(nb), nb vaut ',nb,', normal on n''y a pas touch�') ;
      writeln('on entre dans sans_var(nb)') ; 
      sans_var(nb) ;
      writeln('apr�s sans_var(nb), nb vaut ',nb,', normal n �tait en entr�e sans const') ;
      writeln('on entre dans sans_var(2*nb+7)') ;  
      sans_var(2*nb+7) ; // c'est accept�
      writeln('apr�s sans_var(2*nb+7), nb vaut ',nb,', normal pour la m�me raison') ;       
   end {tester_entree_sortie} ;

// ON PASSE MAINTENANT AUX EXERCICES DU TD PROPREMENT DIT

   // Chaque exercice fera l'objet d'une proc�dure

   procedure exercice_1 ;

      procedure question_1 ;

         // je d�clare la proc�dure p en prenant un exemple
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
         // je donne des valeurs initiales � x, y, z et t 
         x := TRUE ; y := FALSE ; z := 7 ; t := 13 ;
         // maintenant j'�cris les instructions propos�es pour voir si elles sont valides et
         // si elles sont refus�es par le compilateur je mettrai pourquoi derri�re en commentaire
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
         // if f(z) then begin    // f(z) n'est pas un bool�en 
         //   writeln('9 est correct') ;
         // end {if} ;
         // 10
         // f(z) ;  // accept� mais refus� avec la directive {$X-} 
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
         // l'�nonc� est ambig�e 
         // ou bien on part � chaque fois des valeurs initiales x vaut 1, 
         // y vaut2 et z vaut 3
         // ou bien on part des ces 3 valeurs mais les instructions sont ensuite
         // encha�n�es et bien s�r on obtient pas les m�mes r�sultats
         // On va bien s�r voir les deux options
         // La premi�re : on initialise x, y et z avant chaque appel de p
         writeln('On initialise x, y et z avant chaque appel � p') ;
         x := 1 ; y := 2 ; z := 3 ;
         writeln('avant p(x,y), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         p(x,y) ;
         writeln('apr�s p(x,y), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         x := 1 ; y := 2 ; z := 3 ;
         writeln('avant p(y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         p(y,z) ;
         writeln('apr�s p(y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         x := 1 ; y := 2 ; z := 3 ;
         writeln('avant p(x+y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         p(x+y,z) ;
         writeln('apr�s p(x+y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         // La seconde : on initialise x, y et z une seule fois avant le
         // premier appel de p
         writeln('On initialise x, y et z une seule fois') ;
         x := 1 ; y := 2 ; z := 3 ;
         writeln('avant p(x,y), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         p(x,y) ;
         writeln('apr�s p(x,y), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         writeln('avant p(y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         p(y,z) ;
         writeln('apr�s p(y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         writeln('avant p(x+y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
         p(x+y,z) ;
         writeln('apr�s p(x+y,z), x vaut ',x,', y vaut ',y,' et z vaut ',z) ;
      end {question_2} ;

   begin
      writeln('exercice_1') ;
      question_1 ;
      question_2 ;
   end {exercice_1} ;

   procedure exercice_2 ;

      type JOUR = (LUNDI,MARDI,MERCREDI,JEUDI,VENDREDI,SAMEDI,DIMANCHE) ;

      procedure LireJour_v1(out j : JOUR) ;
      // une saisie � l'aide d'un nombre 1 pour LUNDI, 2 pour MARDI etc
      var n : CARDINAL; 
      begin
         readln(n) ;
         j := JOUR(n-1) ;
      end {LireJour_v1} ;

      procedure LireJour_v2(out j : JOUR) ;
      // saisie � l'aide d'une chaine de caract�re en minuscules
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
      writeln('saisie � l''aide d''un naturel') ;
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

