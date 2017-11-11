{-------------------------------------------------------------------------------------------}
{                                        U_TABLEAU.pas                                      }
{ Christian Lasou, 17/03/08                                                                 }
{ Une unité pour le TP d'évaluation des tris.                                               }
{ Elle nécessite l'unité U_ELEMENT, celle-ci devant déclarer le type ELEMENT égal au type   }
{ CARDINAL et définir les entrées-sorties pour un ELEMENT et une fonction elementAleatoire  }
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

    // Une procédure pour afficher un tableau
   procedure ecrireTableau(const t : TABLEAU) ;

   // Une procédure pour lire un tableau
   procedure lireTableau(out t : TABLEAU) ;

   /////////////////////////////
   // GENERATIONS DE TABLEAUX //
   /////////////////////////////

   // POUR UN TABLEAU QUELCONQUE
   // génère un tableau de taille n
   // avec des éléments choisis aléatoirement entre 0 et m
   function genereTableau(const n,m : CARDINAL) : TABLEAU;

   // POUR UN TABLEAU TRIE (MAIS TRIVIAL)
   // génère un tableau contenant les entiers de 0 à n-1 dans cet ordre
   function genereTableauTrieTrivial(const n : CARDINAL) : TABLEAU;

   // POUR UN TABLEAU TRIE NON TRIVIAL
   // génère un tableau trié quelconque de n nombres compris entre 0 et n*m
   function genereTableauTrie(const n,m : CARDINAL) : TABLEAU;

   // POUR UN TABLEAU SUPER-TRIE
   // Un tableau super-trié est un tableau pour lequel une case est supérieure ou égale à
   // la somme des cases précédentes (n'a de sens que pour des tableaux de nombres)
   // génère un tableau super-trié de n cases
   function genereTableauSuperTrie(const n : CARDINAL) : TABLEAU;

   // POUR UN TABLEAU ANTI-TRIE (C-A-D DANS L'AUTRE SENS) TRIVIAL
   // génère un tableau contenant les entiers de n-1 à 0 dans cet ordre
   function genereTableauAntiTrieTrivial(const n : CARDINAL) : TABLEAU;

   // POUR UN TABLEAU ANTI-TRIE NON TRIVIAL
   // génère un tableau anti-trié quelconque de n nombres compris entre 0 et n*m
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

   // pour afficher un tableau à une dimension
   procedure ecrireTableau(const t : TABLEAU) ;
   var i : INTEGER ;
   begin
      for i := Low(t) to High(t) do begin
         ecrireElement(t[i]) ;
         write(' ');
      end {for} ;
      writeln ;
   end {ecrireTableau} ;

   // Une procédure pour lire un tableau
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

   // génère un tableau de taille n éléments
   // avec des entiers choisis aléatoirement entre 0 et m
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

   // génère un tableau contenant les entiers de 0 à n-1 dans cet ordre
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

   // génère un tableau trié quelconque de n nombres compris entre 0 et n*m
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

   // génère un tableau super-trié de n nombres
   function genereTableauSuperTrie(const n : CARDINAL) : TABLEAU;
   var t : TABLEAU ;
       choix,e,somme : ELEMENT ;
       i : CARDINAL ;
   begin
      setLength(t,n) ;
      // je choisis d'abord un element au hasard entre 0 et 5 
      // pour ne pas avoir des nombres trop grands
      choix := elementAleatoire(5) ;
      // je choisis la première case
      t[low(t)] := elementAleatoire(choix) ;
      // Pour les autres

      (* A COMPLETER *)

      genereTableauSuperTrie := t ;
   end {genereTableauSuperTrie} ;

   // génère un tableau contenant les entiers de n-1 à 0 dans cet ordre
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

   // génère un tableau anti-trié quelconque de n nombres compris entre 0 et n*m
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
   // on a fait comme si ce n'était pas obligatoirement des CARDINAL
   function milieu(a,b : INDICE) : INDICE;
   begin
      milieu := INDICE((ord(a)+ord(b)) div 2);
   end {milieu};

end.
