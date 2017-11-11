{--------------------------------------------------------------------------------------------}
{-                                      TP_images.pas                                       -}
{- Christian Lasou, 26/05/09                                                                -}
{- TP sur les images                                                                        -}
{- OBJET :                                                                                  -}
{-   1) Créer des images                                                                    -}
{-   2) Sauvegarder et récupérer des images                                                 -}
{-   3) Modifier des images                                                                 -}
{--------------------------------------------------------------------------------------------}

program TP_images ;

// RAPPEL (ou NOUVEAUTÉ)

// Une image au format PGM se présente comme un texte qui comporte une en-tête de 4 lignes
//          P2
//          # CREATOR :  le nom du créateur (# met la ligne en commentaire)
//          largeur hauteur                (deux nombres donnant la taille)
//          255                             (256 nuances de gris   0 = noir   255 = blanc)
// Ensuite viennent les largeur x hauteur pixels sous forme de nombre à raison d'un pixel par
// ligne donné par sa nuance gris (les pixels sont affichés ligne par ligne)
// voici un exemple très simple :
//  P2
//  # CREATOR : CHRISTIAN LASOU
//  4 3                   # (3 lignes de 4 pixels)
//  255
//  0                     # (premier pixel de la première ligne)
//  0                     # (second pixel de la première ligne)
//  127                   # (troisième pixel de la première ligne)
//  127                   # (quatrième pixel de la première ligne)
//  255                   #(premier pixel de la seconde ligne)
//  255                   # etc.
//  0
//  0
//  66
//  66
//  255
//  255

// PREMIÈRE PARTIE

// Question 1
// On pourrait essayer de visualiser cette image mais elle est beaucoup trop petite.
// On vous a fourni une autre image qui s'appelle  "penseuse.pgm".
// Pour visualisez cette splendide image il suffit de lancer dans un terminal la commande
//         display  penseuse.pgm &
// attention ceci n'est faisable qu'en salle de TP,
// le "&" permet de pouvoir continuer de travailler sans fermer la fenêtre image.
// Vous pouvez aussi visualiser le contenu "texte" de cette image avec un éditeur de texte
// Kate par exemple.
// Quelles sont la largeur et la hauteur de cette image ?


// Voici une procédure qui va créer une seconde image en utilisant la redirection
// de sortie dans un fichier.

   procedure creerEssai2 ;
   var i,j : CARDINAL ;
   begin
      // Ecrire l'entête
      writeln('P2') ;
      writeln('# CREATOR: CHRISTIAN LASOU') ;
      writeln(400,' ',300) ;
      writeln(255) ;
      // Ecrire les pixels
      // les 100 premières lignes
      for i := 1 to 100 do begin   // écrire une ligne
         for j := 1 to 100 do begin  // écrire un pixel
            writeln(0) ;
         end {for} ;
         for j := 1 to 100 do begin  // écrire un pixel
            writeln(255) ;
         end {for} ;
         for j := 1 to 100 do begin  // écrire un pixel
            writeln(0) ;
         end {for} ;
         for j := 1 to 100 do begin  // écrire un pixel
            writeln(255) ;
         end {for} ;
      end {for} ;
      // les 100 suivantes
      for i := 1 to 100 do begin   // écrire une ligne
         for j := 1 to 100 do begin  // écrire un pixel
            writeln(255) ;
         end {for} ;
         for j := 1 to 100 do begin  // écrire un pixel
            writeln(0) ;
         end {for} ;
         for j := 1 to 100 do begin  // écrire un pixel
            writeln(255) ;
         end {for} ;
         for j := 1 to 100 do begin  // écrire un pixel
            writeln(0) ;
         end {for} ;
      end {for} ;
      // les 100 suivantes
      for i := 1 to 100 do begin   // écrire une ligne
         for j := 1 to 100 do begin  // écrire un pixel
            writeln(0) ;
         end {for} ;
         for j := 1 to 100 do begin  // écrire un pixel
            writeln(255) ;
         end {for} ;
         for j := 1 to 100 do begin  // écrire un pixel
            writeln(0) ;
         end {for} ;
         for j := 1 to 100 do begin  // écrire un pixel
            writeln(255) ;
         end {for} ;
      end {for} ;
   end {creerEssai2} ;

// Question2
// Avant de créer et visualiser cette image :
//     quelles sont ses dimensions ?
//     que représente-t-elle ?

// Maintenant nous allons créer cette image pour cela nous laissons comme
// seule instruction dans le programme principal l'appel à cette procédure
// pour cela vous mettez tout le reste en commentaires avec des (* au début
// et   *) juste avant le END.
// Si vous lancez le programme après l'avoir compilé vous aurez la liste des
// lignes à l'écran, ce n'est pas ce que l'on veut, on veut un fichier qui contient
// ces lignes, pour cela on redirige la sortie vers un fichier.
// Tapez la commande
//        ...$  ./TP_images   > essai2.pgm
// Le ">" sert à rediriger la sortie vers le fichier essai2.pgm
// Après exécution vérifiez que le fichier essai2.pgm a bien été créé et visualisez-le
// avec la commande display    (n'oubliez pas de mettre  & à la fin).
// Vous pouvez vérifier ainsi que vos réponses à la question 2 sont bonnes.

// Question3
// Écrivez maintenant une procédure creerEssai3 dont le résultat sera l'image
// négative de essai2.pgm   (les noirs sont devenus blancs et vice-versa)

   procedure creerEssai3 ;
   var i,j : CARDINAL ;
   begin

      // A COMPLETER

   end {creerEssai3} ;

// Nous allons voir maintenant comment modifier une image existante
// et ceci toujours en utilisant les redirections d'entrée-sortie

// Question 4

// Essayez maintenant de comprendre ce que fait la procédure suivante :
   procedure mystere ;
   var s : STRING ;        // pour les deux premières lignes
       n : 0..255 ;        // pour les lignes "pixel"
       l,h,i : CARDINAL ;  // l=largeur, h=hauteur, i,j=compteurs
   begin
      // je lis et recopie les deux premières lignes
      readln(s) ; writeln(s) ;  // ici j'aurais pu écrire writeln('P2') ;
      readln(s) ; writeln(s) ;  // ici je ne connais pas l'auteur a priori
      //je lis la largeur et la hauteur
      read(l) ; readln(h) ;  // après la hauteur la prochaine lecture se fera à la ligne suivannte d'où le "ln"
      // je les recopie
      writeln(l,' ',h) ;
      // Remarque importante : je n'ai pas fait pour cette 3ième ligne
      // la même chose que pour les deux premières car si au niveau de la recopie
      // cela aurait donné le bon résultat, je n'aurais pas su combien il y avait
      // de pixels en tout et pas connu ni la largeur, ni la hauteur (valeurs
      // qui peuvent être utiles)
      // je lis et j'écris la 4ième ligne (c'est 255)
      readln(n) ; writeln(n) ;
      // enfin je passe aux lignes "pixel"
      for i := 1 to l*h do begin
         // je lis un pixel
         readln(n) ;
         // j'écris son transformé
         writeln(255-n) ;
      end {for} ;
   end {mystere} ;

// Pour vérifier votre réponse il suffit, après n'avoir laissé que l'appel à cette
// procédure dans votre programme (tout le reste est en commentaire) et après
// compilation évidemment de lancer la commande
//     ...$ ./TP_images   < penseuse.pgm    > penseuse2.pgm
// le "<" sert à rediriger l'entrée
// Il ne vous reste plus qu'à visualiser penseuse2.pgm

// Vous allez écrire ou plutôt complétez une procédure qui transforme
// une image en noir et blanc avec 255 nuances de gris (comme penseuse.pgm)
// en une image où il n'y aura plus que 4 nuances de gris (blanc, gris gris clair,
// gris foncé et noir)
// Le 255 de la 4ième ligne restera identique seules les lignes de pixels
// seront modifiées.
// Il suffit dont de recopier les 4 premières lignes, puis pour les suivantes
// faire ceci :
// comme 256/4 = 64, alors 0...63  devient 0
//                        63...127 devient 85  (255/3)
//                       128...191 devient 170
//                       192...255 devient 255

   procedure quatreNuances ;
   var s : STRING ;        // pour les deux premières lignes
       n : 0..255 ;        // pour les lignes "pixel"
       l,h,i : CARDINAL ;  // l=largeur, h=hauteur, i=compteur 
   begin
      // je lis et recopie les deux premières lignes
      readln(s) ; writeln(s) ;  // ici j'aurais pu écrire writeln('P2') ;
      readln(s) ; writeln(s) ;  // ici je ne connais pas l'auteur a priori
      //je lis la largeur et la hauteur
      read(l) ; readln(h) ;  // après la hauteur je vais à la ligne d'où le "ln"
      // je les recopie
      writeln(l,' ',h) ;
      // Remarque importante : je n'ai pas fait pour cette 3ième ligne
      // la même chose que pour les deux premières car si au niveau de la recopie
      // cela aurait donné le bon résultat, je n'aurais pas su combien il y avait
      // de pixels en tout et pas connu ni la largeur, ni la hauteur (valeurs
      // qui peuvent être utiles.
      // j'écris la 4ième ligne (c'est 255)
      readln(n) ; writeln(n) ;
      // enfin je passe aux lignes "pixel"
      for i := 1 to l*h do begin

         // je lis un pixel
         // <À COMPLÉTER>

      end {for} ;
   end {quatreNuances} ;

// Pour tester votre procédure il suffit, après n'avoir laissé que l'appel à cette
// procédure dans votre programme (tout le reste est en commentaire) et après
// compilation évidemment de lancer la commande
//     ...$ ./TP_images   < penseuse.pgm    > penseuse4.pgm
// le "<" sert à rediriger l'entrée
// Il ne vous reste plus qu'à visualiser penseuse4.pgm


// SECONDE PARTIE

// Jusque méaintenant on a fait des manipulations "à la volée" sur un pixel
// Si on veut faire des manipulations plus sophistiquées qui agissent sur plusieurs
// pixels, par exemple des échanges, le mieux est de stocker l'image dans un tableau à
// deux dimensions éventuellement surdimensionné pour ne pas avoir de problème
// Voici une telle structure

   const DIMMAX = 1000;

   type  COULEUR   = BYTE  ;  // 0..255 ;  0: noir, 255: blanc
         DIMENSION = 1..DIMMAX ;
         IMAGE     = ARRAY [DIMENSION, DIMENSION] of COULEUR;
   // dans une image si on connaît sa largeur et sa hauteur on ne s'occupera que des 
   // pixels significatifs évidemment
   // REMARQUEZ QUE CETTE STRUCTURE EST LÉGÈREMENT DIFFÉRENTE DE CELLE VUE EN COURS
   // OÙ LES DIMENSIONS ÉTAIENT INCLUSES EN UTILISANT UN ENREGISTREMENT, CETTE FOIS
   // ON A PRÉFÉRÉ NE PRENDRE QU'UN TABLEAU À DEUX DIMENSIONS ; LES DIMENSIONS ÉTANT
   // TRAITÉES À PART.

   // voici une procédure qui calcule l'image symétrique horizontale d'une image
   // passée en paramètre avec ses dimensions
   // La symétrie horizontale est la symétrie axiale dont l'axe est vertical et passe
   // par le centre de l'image.
   procedure calculerSymHoriz(const l,h : DIMENSION ; const i1 :IMAGE ; out i2 : IMAGE) ;
   var i,j : DIMENSION ;
   begin
      for i := 1 to h do begin // traiter une ligne
         for j := 1 to l do begin
            i2[i,j] := i1[i,l-j+1] ;
         end {for} ;
      end {for} ;
   end {calculerSymHoriz} ;

   // Pour pouvoir tester cette procédure je dois écrire d'abord une procédure qui lit
   // une image dans un fichier et la stocke dans une variable de type IMAGE en mémorisant
   // aussi sa largeur et hauteur
   procedure lire(out l,h : DIMENSION ; out im : IMAGE) ;
   var s : STRING ;        // pour les deux premières lignes
       n : 0..255 ;        // pour les lignes "pixel"
       i,j : CARDINAL ;    // i,j=compteurs
   begin
      // je lis les deux premières lignes
      readln(s) ; readln(s) ;
      //je lis la largeur et la hauteur
      read(l) ; readln(h) ;  // après la hauteur je vais à la ligne d'où le "ln"
      // je lis la 4ième ligne (c'est 255)
      readln(n) ;
      // enfin je passe aux lignes "pixel"
      for i := 1 to h do begin    // je lis une ligne
         for j := 1 to l do begin  // je lis un pixel
            readln(im[i,j]) ;
          end {for} ;
      end {for} ;
   end {lire} ;

   // Ainsi qu'une procédure qui écrit dans un fichier une variable de type IMAGE
   // connaissant sa largeur et hauteur
   procedure ecrire(const l,h : DIMENSION ; const im : IMAGE) ;
   var i,j : CARDINAL ;    // i,j=compteurs
   begin
      // je lis les deux premières lignes
      writeln('P2') ; 
      writeln('# CREATOR : TIMOLEON') ;
      //je lis la largeur et la hauteur
      writeln(l,' ',h) ;
      // j'écris la 4ième ligne (c'est 255)
      writeln(255) ;
      // enfin je passe aux lignes "pixel"
      for i := 1 to h do begin    // j'écris une ligne
         for j := 1 to l do begin  // j'écris un pixel
            writeln(im[i,j]) ;
          end {for} ;
      end {for} ;
   end {ecrire} ;

   // maintenant je peux tester ma procédure calculerSymHoriz
   procedure testerCalculerSymHoriz ;
   var l,h : DIMENSION ;
       i1,i2 : IMAGE ;
   begin
      // lecture de i1
      lire(l,h,i1) ;
      // calcul du symétrique horizontale
      calculerSymHoriz(l,h,i1,i2) ;
      // écriture de i2
      ecrire (l,h,i2) ;
   end {testerCalculerSymHoriz} ;

   // Pour exécuter c'est la même chose avec les redirections

// Question 5
// Ecrivez une procédure calculerSymVerti qui calule la symétrie verticale d'une image
   procedure calculerSymVerti(const l,h : DIMENSION ; const i1 :IMAGE ; out i2 : IMAGE) ;

   // maintenant je peux tester ma procédure calculerSymVerti
   procedure testerCalculerSymVerti ;
   end {testerCalculerSymVerti} ;



BEGIN

//   creerEssai2 ;
//   creerEssai3 ;
//   mystere ;
//   quatreNuances ;
//   testerCalculerSymHoriz ;
//   testerCalculerSymVerti ;

END.

