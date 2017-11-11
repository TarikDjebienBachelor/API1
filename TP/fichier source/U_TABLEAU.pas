{------------------------------------------------------------------------------------------}
{                                        U_TABLEAU.pas                                     }
{ API1, 13/02/07                                                                           }
{ Une unit� pour le TP d'�valuation des tris.                                              }
{ Elle n�cessite l'unit� U_ELEMENT, celle-ci devant d�clarer le type ELEMENT �gal au type  }
{ CARDINAL.                                                                                }
{------------------------------------------------------------------------------------------}
unit U_TABLEAU;


interface

uses U_ELEMENT;

type
   
   INDICE  = CARDINAL;
   TABLEAU = array of ELEMENT ;
   
   
   // Une proc�dure pour afficher un tableau
   procedure ecrireTableau(const t : TABLEAU) ;
   
   // Une proc�dure pour lire un tableau
   procedure lireTableau(out t : TABLEAU) ;

   
   // g�n�re un tableau de taille $n$
   // avec des �l�ments choisis al�atoirement entre 0 et $m$
   function genereTableau(const n,m : CARDINAL) : TABLEAU;

   // g�n�re un tableau contenant les entiers de 0 � $n-1$ dans cet ordre
   // ($\forall k\in \lID[0,n-1\rID\ \  t[k]=k$) 
   function genereTableauTrie(const n : CARDINAL) : TABLEAU;
   
   // g�n�re un tableau contenant les entiers de $n-1$ � 0 dans cet ordre
   // ($\forall k\in \lID[0,n-1\rID\ \  t[k]=n-1-k$)
   function genereTableauAntiTrie(const n : CARDINAL) : TABLEAU;
   
   
   // retourne une copie de t
   function copieTableau(const t : TABLEAU) : TABLEAU;
   
   
   // calcule le milieu de l'intervalle discret[a,b]
   function milieu(a,b : INDICE) : INDICE;
   


implementation

   // pour afficher un tableau � une dimension
   procedure ecrireTableau(const t : TABLEAU) ;
   var i : INTEGER ;
   begin
      for i := Low(t) to High(t) do begin 
         ecrireElement(t[i]) ;          
         write(' ');
      end (*for*) ;
      writeln ;
   end (*ecrireTableau*) ;
   
   // Une proc�dure pour lire un tableau
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
   
   // g�n�re un tableau de taille $n$ �l�ments
   // avec des entiers choisis al�atoirement entre 0 et $m$
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
   
   // g�n�re un tableau contenant les entiers de 0 � $n-1$ dans cet ordre
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
   
   // g�n�re un tableau contenant les entiers de $n-1$ � 0 dans cet ordre
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
