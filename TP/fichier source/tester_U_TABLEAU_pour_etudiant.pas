{--------------------------------------------------------------------------------------------}
{-                                    tester_U_TABLEAU.pas                                  -}
{- Christian Lasou, 17/03/08                                                                -}
{- Pour tester l'unité U_Tableau                                                            -}
{--------------------------------------------------------------------------------------------} 
program tester_U_TABLEAU ;

uses U_TABLEAU_pour_etudiant ;

var t1,t2,t3 : TABLEAU;

begin

   // tests de lireTableau et EcrireTableau
   writeln('// tests de lireTableau et EcrireTableau') ;
   writeln('Vous donnez d''abord la taille du tableau et <ENTREE> puis') ;
   writeln('les éléments du tableau sur une ligne en les séparant par des espaces') ;
   lireTableau(t1) ;
   writeln('votre tableau est') ;
   ecrireTableau(t1) ;
   writeln ;

   // test de genereTableau
   writeln('// test de genereTableau') ;
   t1 := genereTableau(10,5);
   writeln('Voici un tableau de 10 entiers choisis aléatoirement entre 1 et 5 : ');
   ecrireTableau(t1);

   // test de copietableau et son utilité
   writeln('// test de copietableau et son utilité') ;
   writeln('Je fais une copie de t1 dans t2 en utilisant une affectation t2 := t1') ;
   writeln('et une copie de t1 dans t3 en utilisant copieTableau t3 := copieTableau(t1)') ;
   t2 := t1 ; t3 := copieTableau(t1);
   write('t2 vaut ') ; ecrireTableau(t2) ;
   write('t3 vaut ') ; ecrireTableau(t3) ;
   writeln('Si je change t1, les copies doivent-elles changer ?') ;
   t1[0] := 30 ;
   writeln('je modifie t1 en faisant t1[0] := 30 et maintenant') ;
   write('t1 vaut ') ; ecrireTableau(t1) ;
   write('t2 vaut ') ; ecrireTableau(t2) ;
   write('t3 vaut ') ; ecrireTableau(t3) ;
   writeln('C''est normal que t1 ait changé');
   writeln('C''est anormal que t2 ait changé aussi');
   writeln('C''est normal que t3 n''ait pas changé');
   writeln('Donc pour faire une vraie copie il faut utiliser copieTableau ');
   writeln('Ce sera très important quand dans la fusion on fait une copie de t') ;
   writeln ;

   // tests de genereTableauTrieTrivial
   writeln('// tests de genereTableauTrieTrivial') ;
   t1 := genereTableauTrieTrivial(15);
   writeln('Un tableau trié contenant les entiers de 0 à 15-1 : ');
   ecrireTableau(t1);
   writeln ;

   // tests de genereTableauTrie
   writeln('// tests de genereTableauTrie') ;
   t1 := genereTableauTrie(15,5);
   writeln('Un tableau trié contenant 15 entiers entre 0 à 15*5 : ');
   ecrireTableau(t1);
   writeln ;

   // tests de genereTableauSuperTrie
   writeln('// tests de genereTableauSuperTrie') ;
   t1 := genereTableauSuperTrie(15);
   writeln('Un tableau super-trié de 15 entiers : ');
   ecrireTableau(t1);
   writeln ;

   // tests de genereTableauAntiTrieTrivial
   writeln('// tests de genereTableauAntiTrieTrivial') ;
   t1 := genereTableauAntiTrieTrivial(20);
   writeln('Un tableau anti-trié contenant les entiers 20-1 à 0 : ');
   ecrireTableau(t1);
   writeln ;

   // tests de genereTableauAntiTrie
   writeln('// tests de genereTableauAntiTrie') ;
   t1 := genereTableauAntiTrie(20,5);
   writeln('Un tableau anti-trié contenant 20 entiers entre 0 à 20*5 : ');
   ecrireTableau(t1);
   writeln ;

end.

RESULTATS

// tests de lireTableau et EcrireTableau
Vous donnez d'abord la taille du tableau et <ENTREE> puis
les éléments du tableau sur une ligne en les séparant par des espaces
5
12 1 4 5 7
votre tableau est
12 1 4 5 7

// test de genereTableau
Voici un tableau de 10 entiers choisis aléatoirement entre 1 et 5 :
2 2 1 1 5 5 4 5 2 3

// test de copietableau et son utilité
Je fais une copie de t1 dans t2 en utilisant une affectation t2 := t1
et une copie de t1 dans t3 en utilisant copieTableau t3 := copieTableau(t1)
t2 vaut 2 2 1 1 5 5 4 5 2 3
t3 vaut 2 2 1 1 5 5 4 5 2 3
Si je change t1, les copies doivent-elles changer ?
je modifie t1 en faisant t1[0] := 30 et maintenant
t1 vaut 30 2 1 1 5 5 4 5 2 3
t2 vaut 30 2 1 1 5 5 4 5 2 3
t3 vaut 2 2 1 1 5 5 4 5 2 3
C'est normal que t1 ait changé
C'est anormal que t2 ait changé aussi   // t2 n'est pas une copie de t1 mais t1 lui-même
C'est normal que t3 n'ait pas changé    // t3 est une vraie copie
Donc pour faire une vraie copie il faut utiliser copieTableau
Ce sera très important quand dans la fusion on fait une copie de t

// tests de genereTableauTrieTrivial
Un tableau trié contenant les entiers de 0 à 15-1 :
0 1 2 3 4 5 6 7 8 9 10 11 12 13 14

// tests de genereTableauTrie
Un tableau trié contenant 15 entiers entre 0 à 15*5 :
4 6 9 11 14 17 18 20 24 29 30 31 33 35 40

// tests de genereTableauSuperTrie
Un tableau super-trié de 15 entiers :
4 5 12 22 47 91 184 366 733 1466 2934 5865 11733 23462 46926

// tests de genereTableauAntiTrieTrivial
Un tableau anti-trié contenant les entiers 20-1 à 0 :
19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0

// tests de genereTableauAntiTrie
Un tableau anti-trié contenant 20 entiers entre 0 à 20*5 :
38 37 36 36 31 26 24 21 21 19 14 12 11 7 5 4 2 2 2 1

