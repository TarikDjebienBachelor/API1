{--------------------------------------------------------------------------------------------}
{-                                          tris.pas                                        -}
{- Christian Lasou, 17/03/08                                                                -}
{- Squelette pour l'implantation des tris                                                   -}
{--------------------------------------------------------------------------------------------} 
program tris ;

uses U_ELEMENT, U_TABLEAU ;

   // Une proc�dure d'�change utile pour les deux premiers tris
   procedure echanger({???} x,y : ELEMENT) ;
   var m : ELEMENT ;   // pour m�moriser l'ancienne valeur de x
   begin
      m := x ; x := y ; y := m ;
   end {echanger} ;

   //////////////////////
   // Le tri s�lection //
   //////////////////////

   // La fonction donnant l'indice du minimum de t[a..b] 
   function ind_min(t : TABLEAU ; a,b : INDICE) : INDICE ;
   var i,k : INDICE ;
       m : ELEMENT ;
   begin

      (* A COMPLETER *)

   end {ind_min} ;

   // la proc�dure de tri
   procedure trier_select({???} t : TABLEAU) ;
   var k,i : INDICE ;
   begin

      (* A COMPLETER *)

   end {trier_select} ;

   //////////////////////
   // Le tri insertion //
   //////////////////////

   // La proc�dure d'insertion
   procedure inserer({???} t : TABLEAU ; {???} k : INDICE) ;
   // t[a..k-1] �tant suppos�e tri�e, on y ins�re t[k] afin d'obtenir t[a..k] tri�e
   var i : INDICE ;
   begin

      (* A COMPLETER *)

   end {inserer} ;

   //la proc�dure de tri
   procedure trier_insert({???} t : TABLEAU) ;
   var k : INDICE ;
   begin

      (* A COMPLETER *)

   end {trier_insert} ;

   ///////////////////
   // Le tri fusion //
   ///////////////////

   // La proc�dure de fusion
   procedure fusionner({???} t : TABLEAU ; {???} a,b,c : INDICE) ;
   // fusionne dans t les deux tranches t[a..b] et t[b+1..c] qui sont suppos�es tri�es
   // pour obtenir le tableau t[a..c] tri�
   var aux : TABLEAU ; // copie de t
       i,j,k : INDICE ;
   begin

      (* A COMPLETER *)

   end {fusionner} ;

   // la proc�dure de tri
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
   writeln('apr�s trier_select(t)') ;
   write('t vaut ') ; ecrireTableau(t) ;
   writeln ;

   // test de trier_insert
   writeln('// test de trier_insert') ;
   t := genereTableau(20,10) ;
   write('t vaut ') ; ecrireTableau(t) ;
   trier_insert(t) ;
   writeln('apr�s trier_insert(t)') ;
   write('t vaut ') ; ecrireTableau(t) ;
   writeln ;

   // test de trier_fusion_rec
   writeln('// test de trier_fusion_rec') ;
   t := genereTableau(20,10) ;
   write('t vaut ') ; ecrireTableau(t) ;
   trier_fusion_rec(t,low(t),high(t)) ;
   writeln('apr�s trier_fusion_rec(t,low(t),high(t))') ;
   write('t vaut ') ; ecrireTableau(t) ;
   writeln ;



end.

RESULTATS

// test de trier_select
t vaut 1 1 5 9 7 2 2 9 3 0 5 6 10 0 5 1 10 9 2 4
apr�s trier_select(t)
t vaut 0 0 1 1 1 2 2 2 3 4 5 5 5 6 7 9 9 9 10 10

// test de trier_insert
t vaut 5 8 0 5 8 8 4 3 6 5 1 9 4 0 1 4 3 1 7 10
apr�s trier_insert(t)
t vaut 0 0 1 1 1 3 3 4 4 4 5 5 5 6 7 8 8 8 9 10

// test de trier_fusion_rec
t vaut 6 3 9 2 4 0 3 10 6 9 6 1 2 2 1 0 3 3 6 1
apr�s trier_fusion_rec(t,low(t),high(t))
t vaut 0 0 1 1 1 2 2 2 3 3 3 3 4 6 6 6 6 9 9 10

