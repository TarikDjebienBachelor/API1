{--------------------------------------------------------------------------------------------}
{-                                          tris.pas                                        -}
{- Christian Lasou, 17/03/08                                                                -}
{- Squelette pour l'implantation des tris                                                   -}
{--------------------------------------------------------------------------------------------} 
program tris ;

uses U_ELEMENT, U_TABLEAU ;

   // Une procédure d'échange utile pour les deux premiers tris
   procedure echanger({???} x,y : ELEMENT) ;
   var m : ELEMENT ;   // pour mémoriser l'ancienne valeur de x
   begin
      m := x ; x := y ; y := m ;
   end {echanger} ;

   //////////////////////
   // Le tri sélection //
   //////////////////////

   // La fonction donnant l'indice du minimum de t[a..b] 
   function ind_min(t : TABLEAU ; a,b : INDICE) : INDICE ;
   var i,k : INDICE ;
       m : ELEMENT ;
   begin

      (* A COMPLETER *)

   end {ind_min} ;

   // la procédure de tri
   procedure trier_select({???} t : TABLEAU) ;
   var k,i : INDICE ;
   begin

      (* A COMPLETER *)

   end {trier_select} ;

   //////////////////////
   // Le tri insertion //
   //////////////////////

   // La procédure d'insertion
   procedure inserer({???} t : TABLEAU ; {???} k : INDICE) ;
   // t[a..k-1] étant supposée triée, on y insère t[k] afin d'obtenir t[a..k] triée
   var i : INDICE ;
   begin

      (* A COMPLETER *)

   end {inserer} ;

   //la procédure de tri
   procedure trier_insert({???} t : TABLEAU) ;
   var k : INDICE ;
   begin

      (* A COMPLETER *)

   end {trier_insert} ;

   ///////////////////
   // Le tri fusion //
   ///////////////////

   // La procédure de fusion
   procedure fusionner({???} t : TABLEAU ; {???} a,b,c : INDICE) ;
   // fusionne dans t les deux tranches t[a..b] et t[b+1..c] qui sont supposées triées
   // pour obtenir le tableau t[a..c] trié
   var aux : TABLEAU ; // copie de t
       i,j,k : INDICE ;
   begin

      (* A COMPLETER *)

   end {fusionner} ;

   // la procédure de tri
   procedure trier_fusion_rec({???} t : TABLEAU ; {???} a,b : INDICE) ;
   var m : INDICE ;
   begin

      (* A COMPLETER *)

   end {trier_fusion_rec} ;

var t : TABLEAU;

begin

   // test des 3 tris

   // test de trier_select
   writeln('// test de trier_select') ;
   t := genereTableau(20,10) ;
   write('t vaut ') ; ecrireTableau(t) ;
   trier_select(t) ;
   writeln('après trier_select(t)') ;
   write('t vaut ') ; ecrireTableau(t) ;
   writeln ;

   // test de trier_insert
   writeln('// test de trier_insert') ;
   t := genereTableau(20,10) ;
   write('t vaut ') ; ecrireTableau(t) ;
   trier_insert(t) ;
   writeln('après trier_insert(t)') ;
   write('t vaut ') ; ecrireTableau(t) ;
   writeln ;

   // test de trier_fusion_rec
   writeln('// test de trier_fusion_rec') ;
   t := genereTableau(20,10) ;
   write('t vaut ') ; ecrireTableau(t) ;
   trier_fusion_rec(t,low(t),high(t)) ;
   writeln('après trier_fusion_rec(t,low(t),high(t))') ;
   write('t vaut ') ; ecrireTableau(t) ;
   writeln ;



end.

RESULTATS

// test de trier_select
t vaut 1 1 5 9 7 2 2 9 3 0 5 6 10 0 5 1 10 9 2 4
après trier_select(t)
t vaut 0 0 1 1 1 2 2 2 3 4 5 5 5 6 7 9 9 9 10 10

// test de trier_insert
t vaut 5 8 0 5 8 8 4 3 6 5 1 9 4 0 1 4 3 1 7 10
après trier_insert(t)
t vaut 0 0 1 1 1 3 3 4 4 4 5 5 5 6 7 8 8 8 9 10

// test de trier_fusion_rec
t vaut 6 3 9 2 4 0 3 10 6 9 6 1 2 2 1 0 3 3 6 1
après trier_fusion_rec(t,low(t),high(t))
t vaut 0 0 1 1 1 2 2 2 3 3 3 3 4 6 6 6 6 9 9 10

