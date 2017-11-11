{-------------------------------------------------------------------------------------------}
{                                        U_TABLEAU.pas                                      }
{ Christian Lasou, 17/03/08                                                                 }
{ Une unit� pour le TP d'�valuation des tris.                                               }
{ Elle n�cessite l'unit� U_ELEMENT, celle-ci devant d�clarer le type ELEMENT �gal au type   }
{ CARDINAL et d�finir les entr�es-sorties pour un ELEMENT et une fonction elementAleatoire  }
{ (On pourrait par la suite changer ELEMENT en prenant des CHAR par exemple.)               }
{-------------------------------------------------------------------------------------------}
unit U_TABLEAU_pour_etudiant ;

interface

uses U_ELEMENT;

type INDICE  = CARDINAL;
     TABLEAU = array of ELEMENT ; // attention ce sont des tableaux dynamiques pour pouvoir
                                  // faire des tableaux aussi grands que l'on veut

    /////////////////////////
    // LES ENTREES-SORTIES //
    /////////////////////////

    // Une proc�dure pour afficher un tableau
   procedure ecrireTableau(const t : TABLEAU) ;

   // Une proc�dure pour lire un tableau
   procedure lireTableau(out t : TABLEAU) ;

   /////////////////////////////
   // GENERATIONS DE TABLEAUX //
   /////////////////////////////

   // POUR UN TABLEAU QUELCONQUE
   // g�n�re un tableau de taille n
   // avec des �l�ments choisis al�atoirement entre 0 et m
   function genereTableau(const n,m : CARDINAL) : TABLEAU;

   // POUR UN TABLEAU TRIE (MAIS TRIVIAL)
   // g�n�re un tableau contenant les entiers de 0 � n-1 dans cet ordre
   function genereTableauTrieTrivial(const n : CARDINAL) : TABLEAU;

   // POUR UN TABLEAU TRIE NON TRIVIAL
   // g�n�re un tableau tri� quelconque de n nombres compris entre 0 et n*m
   function genereTableauTrie(const n,m : CARDINAL) : TABLEAU;

   // POUR UN TABLEAU SUPER-TRIE
   // Un tableau super-tri� est un tableau pour lequel une case est sup�rieure ou �gale �
   // la somme des cases pr�c�dentes (n'a de sens que pour des tableaux de nombres)
   // g�n�re un tableau super-tri� de n cases
   function genereTableauSuperTrie(const n : CARDINAL) : TABLEAU;

   // POUR UN TABLEAU ANTI-TRIE (C-A-D DANS L'AUTRE SENS) TRIVIAL
   // g�n�re un tableau contenant les entiers de n-1 � 0 dans cet ordre
   function genereTableauAntiTrieTrivial(const n : CARDINAL) : TABLEAU;

   // POUR UN TABLEAU ANTI-TRIE NON TRIVIAL
   // g�n�re un tableau anti-tri� quelconque de n nombres compris entre 0 et n*m
   function genereTableauAntiTrie(const n,m : CARDINAL) : TABLEAU;

   // FAIRE UNE "VRAIE" COPIE D'UN TABLEAU
   // renvoie une copie de t
   function copieTableau(const t : TABLEAU) : TABLEAU;

   ////////////////////////////////////////
   // INDICE DU "MILIEU" D'UN INTERVALLE //
   ////////////////////////////////////////

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
      end {for} ;
      writeln ;
   end {ecrireTableau} ;

   // Une proc�dure pour lire un tableau
   procedure lireTableau(out t : TABLEAU) ;
   var taille : CARDINAL;
       i : INDICE;
   begin
      readln(taille);
      setLength(t,taille);
      for i := low(t) to high(t) do begin
         lireElement(t[i]) ;
      end {for} ;
   end {lireTableau};

   // g�n�re un tableau de taille n �l�ments
   // avec des entiers choisis al�atoirement entre 0 et m
   function genereTableau(const n,m : CARDINAL) : TABLEAU ;
   var t : TABLEAU ;
       i : CARDINAL ;
   begin
      setLength(t,n) ;
      for i := low(t) to high(t) do begin
         t[i] := elementAleatoire(m) ;
      end {for} ;
      genereTableau := t ;
   end {genereTableau} ;

   // g�n�re un tableau contenant les entiers de 0 � n-1 dans cet ordre
   function genereTableauTrieTrivial(const n : CARDINAL) : TABLEAU ;
   var t : TABLEAU;
       k : CARDINAL;
   begin
      setLength(t,n);
      for k := low(t) to high(t) do begin
         t[k] := k;
      end {for};
      genereTableauTrieTrivial := t;
   end {genereTableauTrieTrivial};

   // g�n�re un tableau tri� quelconque de n nombres compris entre 0 et n*m
   function genereTableauTrie(const n,m : CARDINAL) : TABLEAU;
   var t : TABLEAU ;
       i : CARDINAL ;
   begin
      setLength(t,n) ;
      t[low(t)] := elementAleatoire(m) ;
      for i := succ(low(t)) to high(t) do begin

         (* A COMPLETER (une seule instruction) *)

      end {for} ;
      genereTableauTrie := t ;
   end {genereTableauTrie} ;

   // g�n�re un tableau super-tri� de n nombres
   function genereTableauSuperTrie(const n : CARDINAL) : TABLEAU;
   var t : TABLEAU ;
       choix,e,somme : ELEMENT ;
       i : CARDINAL ;
   begin
      setLength(t,n) ;
      // je choisis d'abord un element au hasard entre 0 et 5 
      // pour ne pas avoir des nombres trop grands
      choix := elementAleatoire(5) ;
      // je choisis la premi�re case
      t[low(t)] := elementAleatoire(choix) ;
      // Pour les autres

      (* A COMPLETER *)

      genereTableauSuperTrie := t ;
   end {genereTableauSuperTrie} ;

   // g�n�re un tableau contenant les entiers de n-1 � 0 dans cet ordre
   function genereTableauAntiTrieTrivial(const n : CARDINAL) : TABLEAU;
   var t : TABLEAU;
       k : INDICE;
   begin
      setLength(t,n);
      for k := low(t) to high(t) do begin
         t[k] := n-1-k;
      end {for};
      genereTableauAntiTrieTrivial := t;
   end {genereTableauAntiTrieTrivial};

   // g�n�re un tableau anti-tri� quelconque de n nombres compris entre 0 et n*m
   function genereTableauAntiTrie(const n,m : CARDINAL) : TABLEAU;
   var t : TABLEAU ;
       i : CARDINAL ;
   begin
      setLength(t,n) ;
      t[high(t)] := elementAleatoire(m) ;

      (* A COMPLETER *)

      genereTableauAntiTrie := t ;
   end {genereTableauAntiTrie} ;

   // retourne une copie de t
   function copieTableau(const t : TABLEAU) : TABLEAU;
   var t2 : TABLEAU;
       k : INDICE;
   begin
      setLength(t2,high(t)-low(t)+1);
      for k := low(t) to high(t) do  begin
         t2[k] := t[k];
      end {for};
      copieTableau := t2;
   end {copieTableau};

   // calcule le milieu de l'intervalle discret[a,b]
   // on a fait comme si ce n'�tait pas obligatoirement des CARDINAL
   function milieu(a,b : INDICE) : INDICE;
   begin
      milieu := INDICE((ord(a)+ord(b)) div 2);
   end {milieu};

end.
