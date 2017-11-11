{------------------------------------------------------------------------------------------}
{                                        U_TABLEAU.pas                                     }
{ API1, 13/02/07                                                                           }
{ Une unité pour le TP d'évaluation des tris.                                              }
{ Elle nécessite l'unité U_ELEMENT, celle-ci devant déclarer le type ELEMENT égal au type  }
{ CARDINAL.                                                                                }
{------------------------------------------------------------------------------------------}
unit U_TABLEAU;


interface

uses U_ELEMENT;

type
   
   INDICE  = CARDINAL;
   TABLEAU = array of ELEMENT ;
   
   
   // Une procédure pour afficher un tableau
   procedure ecrireTableau(const t : TABLEAU) ;
   
   // Une procédure pour lire un tableau
   procedure lireTableau(out t : TABLEAU) ;

   
   // génère un tableau de taille $n$
   // avec des éléments choisis aléatoirement entre 0 et $m$
   function genereTableau(const n,m : CARDINAL) : TABLEAU;

   // génère un tableau contenant les entiers de 0 à $n-1$ dans cet ordre
   // ($\forall k\in \lID[0,n-1\rID\ \  t[k]=k$) 
   function genereTableauTrie(const n : CARDINAL) : TABLEAU;
   
   // génère un tableau contenant les entiers de $n-1$ à 0 dans cet ordre
   // ($\forall k\in \lID[0,n-1\rID\ \  t[k]=n-1-k$)
   function genereTableauAntiTrie(const n : CARDINAL) : TABLEAU;
   
   
   // retourne une copie de t
   function copieTableau(const t : TABLEAU) : TABLEAU;
   
   
   // calcule le milieu de l'intervalle discret[a,b]
   function milieu(a,b : INDICE) : INDICE;
   


implementation

   // pour afficher un tableau à une dimension
   procedure ecrireTableau(const t : TABLEAU) ;
   var i : INTEGER ;
   begin
      for i := Low(t) to High(t) do begin 
         ecrireElement(t[i]) ;          
         write(' ');
      end (*for*) ;
      writeln ;
   end (*ecrireTableau*) ;
   
   // Une procédure pour lire un tableau
   procedure lireTableau(out t : TABLEAU) ;
   var
      taille : CARDINAL;
      i : INDICE;
   begin
      readln(taille);
      setLength(t,taille);
      for i := low(t) to high(t) do
         read(t[i]);
   end {lireTableau};
   
   // génère un tableau de taille $n$ éléments
   // avec des entiers choisis aléatoirement entre 0 et $m$
   function genereTableau(const n,m : CARDINAL) : TABLEAU;
   var
      t : TABLEAU;
      i : CARDINAL ;
   begin
      setLength(t,n) ;
      for i := low(t) to high(t) do begin  
         t[i] := random(m+1) ;           
      end {for} ;
      genereTableau := t;
   end (*genereTableau*) ;
   
   // génère un tableau contenant les entiers de 0 à $n-1$ dans cet ordre
   // ($\forall k\in \lID[0,n-1\rID\ \  t[k]=k$) 
   function genereTableauTrie(const n : CARDINAL) : TABLEAU;
   var
      t : TABLEAU;
      k : CARDINAL;
   begin
      setLength(t,n);
      for k := low(t) to high(t) do
      begin
         t[k] := k;
      end {for};
      genereTableauTrie := t;
   end {genereTableauTrie};
   
   // génère un tableau contenant les entiers de $n-1$ à 0 dans cet ordre
   // ($\forall k\in \lID[0,n-1\rID\ \  t[k]=n-1-k$)
   function genereTableauAntiTrie(const n : CARDINAL) : TABLEAU;
   var
      t : TABLEAU;
      k : INDICE;
   begin
      setLength(t,n);
      for k := low(t) to high(t) do
      begin
         t[k] := n-1-k;
      end {for};
      genereTableauAntiTrie := t;
   end {genereTableauAntiTrie};
   

   
   // retourne une copie de t
   function copieTableau(const t : TABLEAU) : TABLEAU;
   var
      t2 : TABLEAU;
      k : INDICE;
   begin
      setLength(t2,high(t)-low(t)+1);
      for k := low(t) to high(t) do
      begin
         t2[k] := t[k];
      end {for};
      copieTableau := t2;
   end {copieTableau};


   // calcule le milieu de l'intervalle discret[a,b]
   function milieu(a,b : INDICE) : INDICE;
   begin
      milieu := INDICE((ord(a)+ord(b)) div 2);
   end {milieu};
   
initialization
      randomize();
end.
