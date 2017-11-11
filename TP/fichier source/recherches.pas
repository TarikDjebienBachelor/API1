{--------------------------------------------------------------------------------------------}
{-                                   recherches.pas                                         -}
{- Christian Lasou, 18/03/08                                                                -}
{- Squelette pour l'implantation des recherches                                             -}
{--------------------------------------------------------------------------------------------} 
program recherches ;

uses U_ELEMENT, U_TABLEAU ;

   //////////////////////////////////////////////////////////
   // La recherche séquentielle dans un tableau quelconque //
   //////////////////////////////////////////////////////////

   // Le prédicat est_dans_seq
   function est_dans_seq(e : ELEMENT ; t : TABLEAU) : BOOLEAN ;
   var i : INDICE ;
   begin
      i := low(t) ;
      while (i < high(t)) and (t[i] <> e) do begin
         inc(i) ;
      end {while} ;
      { (i < high(t) et t[i] = e) ou 
        (i = high(t) et (t[i] = e ou t[i] <> e)) }
      est_dans_seq := (t[i] = e) ;
   end {est_dans_seq} ;

   // La procédure rechercher_seq qui en plus du résultat booléen donne l'indice d'une
   // case où se trouve l'élément recherché si on l'a trouvé
   procedure rechercher_seq(const e : ELEMENT ; const t : TABLEAU ;
                            out trouve : BOOLEAN ; out ind : INDICE) ;
   begin
      ind := low(t) ;
      while (ind < high(t)) and (t[ind] <> e) do begin
         inc(ind) ;
      end {while} ;
      { (ind < high(t) et t[ind] = e) ou 
        (ind = high(t) et (t[ind] = e ou t[ind] <> e)) }
      trouve := (t[ind] = e) ;     // ATTENTION si trouve est faux t[ind] <> e
   end {rechercher_seq} ;

   ////////////////////////////////////////////////////
   // La recherche séquentielle dans un tableau trié //
   ////////////////////////////////////////////////////

   // Le prédicat est_dans_seq_trie
   function est_dans_seq_trie(e : ELEMENT ; t : TABLEAU) : BOOLEAN ;
   var i : INDICE ;
   begin
      i := low(t) ;
      while (i < high(t)) and (t[i] < e) do begin
         inc(i) ;
      end {while} ;
      { (i < high(t) et t[i] >= e) ou 
        (i = high(t) et (t[i] = e ou t[i] > e ou t[i] < e)) }
      est_dans_seq_trie := (t[i] = e) ;
   end {est_dans_seq_trie} ;

   // La procédure rechercher_seq_trie qui en plus du résultat booléen donne l'indice d'une
   // case où se trouve l'élément recherché si on l'a trouvé
   procedure rechercher_seq_trie(const e : ELEMENT ; const t : TABLEAU ;
                                 out trouve : BOOLEAN ; out ind : INDICE) ;
   begin
      ind := low(t) ;
      while (ind < high(t)) and (t[ind] < e) do begin
         inc(ind) ;
      end {while} ;
      { (ind < high(t) et t[ind] >= e) ou 
        (ind = high(t) et (t[ind] = e ou t[ind] > e ou t[ind] < e)) }
      trouve := (t[ind] = e) ;     // ATTENTION si trouve est faux t[ind] <> e
   end {rechercher_seq_trie} ;

   //////////////////////////////////////////////////////
   // La recherche dichotomique (dans un tableau trié) //
   //////////////////////////////////////////////////////

   // Le prédicat est_dans_dicho
   function est_dans_dicho(e : ELEMENT ; t : TABLEAU) : BOOLEAN ;
   var k,l,m : INDICE ;
       trouve : BOOLEAN ;
   begin
      k := low(t) ; l := high(t) ; trouve := FALSE ; 
      while (k <= l) and not trouve do begin
         m := milieu(k,l) ;
         if t[m] = e then begin
            trouve := TRUE ;
         end else begin  // on n'a pas trouvé
            if t[m] < e then begin //on cherche dans la fin du tableau
              k := succ(m) ;
            end else begin // on cherche dans le début
              l := pred(m) ;
            end {if} ;
         end {if} ;
      end {while} ;
      est_dans_dicho := trouve ;
   end {est_dans_dicho} ;

   // La procédure rechercher_dicho qui en plus du résultat booléen donne l'indice d'une
   // case où se trouve l'élément recherché si on l'a trouvé
   procedure rechercher_dicho(const e : ELEMENT ; const t : TABLEAU ;
                              out trouve : BOOLEAN ; out ind : INDICE) ;
   var k,l : INDICE ;
   begin
      k := low(t) ; l := high(t) ; trouve := FALSE ; 
      while (k <= l) and not trouve do begin
         ind := milieu(k,l) ;
         if t[ind] = e then begin
            trouve := TRUE ;
         end else begin  // on n'a pas trouvé
            if t[ind] < e then begin //on cherche dans la fin du tableau
              k := succ(ind) ;
            end else begin // on cherche dans le début
              l := pred(ind) ;
            end {if} ;
         end {if} ;
      end {while} ;
   end {rechercher_dicho} ;

var t : TABLEAU ;
    e : ELEMENT ;
    trouve : BOOLEAN ;
    ind : INDICE ;
    i : CARDINAL ;

begin

   // test de la recherche séquentielle dans un tableau quelconque
   writeln('// test de la recherche séquentielle dans un tableau quelconque') ;
   t := genereTableau(30,100) ;  // t est un tableau de 30 nombres entre 0 et 100
   write('t vaut ') ; ecrireTableau(t) ;
   for i := 1 to 5 do begin   // je cherche 5 éléments au hasard pour avoir succès et échec
      e := elementAleatoire(100) ;  // e est un nombre entre 0 et 100
      write('e vaut ') ; ecrireElement(e) ; writeln ;
      writeln('est_dans_seq(e,t) vaut ', est_dans_seq(e,t)) ;
      writeln('après rechercher_seq(e,t,trouve,ind)') ;
      rechercher_seq(e,t,trouve,ind) ;
      writeln('trouve vaut ',trouve,' et ind vaut ',ind) ;
   end {for} ;
   writeln ;

   // test de la recherche séquentielle dans un tableau trié
   writeln('// test de la recherche séquentielle dans un tableau trié') ;
   t := genereTableauTrie(30,3) ;  // t est un tableau de 30 nombres entre 0 et 30*3
   write('t vaut ') ; ecrireTableau(t) ;
   for i := 1 to 5 do begin   // je cherche 5 éléments au hasard pour avoir succès et échec
      e := elementAleatoire(30*3) ;  // e est un nombre entre 0 et 90
      write('e vaut ') ; ecrireElement(e) ; writeln ;
      writeln('est_dans_seq_trie(e,t) vaut ', est_dans_seq_trie(e,t)) ;
      writeln('après rechercher_seq_trie(e,t,trouve,ind)') ;
      rechercher_seq_trie(e,t,trouve,ind) ;
      writeln('trouve vaut ',trouve,' et ind vaut ',ind) ;
   end {for} ;
   writeln ;

   // test de la recherche dichotomique (dans un tableau trié)
   writeln('// test de la recherche dichotomique (dans un tableau trié)') ;
   t := genereTableauTrie(30,1) ;  // t est un tableau de 30 nombres entre 0 et 30*1
   write('t vaut ') ; ecrireTableau(t) ;
   for i := 1 to 5 do begin   // je cherche 5 éléments au hasard pour avoir succès et échec
      e := elementAleatoire(30*1) ;  // e est un nombre entre 0 et 30
      write('e vaut ') ; ecrireElement(e) ; writeln ;
      writeln('est_dans_dicho(e,t) vaut ', est_dans_dicho(e,t)) ;
      writeln('après rechercher_dicho(e,t,trouve,ind)') ;
      rechercher_dicho(e,t,trouve,ind) ;
      writeln('trouve vaut ',trouve,' et ind vaut ',ind) ;
   end {for} ;
   writeln ;

end.

RESULTATS

// test de la recherche séquentielle dans un tableau quelconque
t vaut 43 82 77 25 27 52 13 12 28 46 92 54 41 47 79 92 27 72 43 86 36 77 57 3 5 4 92 32 19 95
e vaut 46
est_dans_seq(e,t) vaut TRUE
après rechercher_seq(e,t,trouve,ind)
trouve vaut TRUE et ind vaut 9
e vaut 63
est_dans_seq(e,t) vaut FALSE
après rechercher_seq(e,t,trouve,ind)
trouve vaut FALSE et ind vaut 29
e vaut 5
est_dans_seq(e,t) vaut TRUE
après rechercher_seq(e,t,trouve,ind)
trouve vaut TRUE et ind vaut 24
e vaut 73
est_dans_seq(e,t) vaut FALSE
après rechercher_seq(e,t,trouve,ind)
trouve vaut FALSE et ind vaut 29
e vaut 14
est_dans_seq(e,t) vaut FALSE
après rechercher_seq(e,t,trouve,ind)
trouve vaut FALSE et ind vaut 29

// test de la recherche séquentielle dans un tableau trie
t vaut 2 5 7 9 11 12 15 18 19 20 22 22 24 26 27 29 30 31 31 31 34 37 37 37 39 40 41 44 45 48
e vaut 40
est_dans_seq_trie(e,t) vaut TRUE
après rechercher_seq_trie(e,t,trouve,ind)
trouve vaut TRUE et ind vaut 25
e vaut 43
est_dans_seq_trie(e,t) vaut FALSE
après rechercher_seq_trie(e,t,trouve,ind)
trouve vaut FALSE et ind vaut 27
e vaut 30
est_dans_seq_trie(e,t) vaut TRUE
après rechercher_seq_trie(e,t,trouve,ind)
trouve vaut TRUE et ind vaut 16
e vaut 0
est_dans_seq_trie(e,t) vaut FALSE
après rechercher_seq_trie(e,t,trouve,ind)
trouve vaut FALSE et ind vaut 0
e vaut 87
est_dans_seq_trie(e,t) vaut FALSE
après rechercher_seq_trie(e,t,trouve,ind)
trouve vaut FALSE et ind vaut 29

// test de la recherche dichotomique (dans un tableau trié)
t vaut 1 1 3 3 4 6 8 9 10 11 11 12 13 13 15 16 18 20 22 22 23 23 25 27 27 28 30 31 33 33
e vaut 25
est_dans_dicho(e,t) vaut TRUE
après rechercher_dicho(e,t,trouve,ind)
trouve vaut TRUE et ind vaut 22
e vaut 3
est_dans_dicho(e,t) vaut TRUE
après rechercher_dicho(e,t,trouve,ind)
trouve vaut TRUE et ind vaut 2
e vaut 6
est_dans_dicho(e,t) vaut TRUE
après rechercher_dicho(e,t,trouve,ind)
trouve vaut TRUE et ind vaut 5
e vaut 48
est_dans_dicho(e,t) vaut FALSE
après rechercher_dicho(e,t,trouve,ind)
trouve vaut FALSE et ind vaut 29
e vaut 36
est_dans_dicho(e,t) vaut FALSE
après rechercher_dicho(e,t,trouve,ind)
trouve vaut FALSE et ind vaut 29
