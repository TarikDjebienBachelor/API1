{--------------------------------------------------------------------------------------------}
{-                                     U_ELEMENT.pas                                        -}
{- Christian Lasou, 17/03/08                                                                -}
{- l'unité U_ELEMENT pour lire et écrire un ELEMENT                                         -}
{--------------------------------------------------------------------------------------------}
unit U_ELEMENT ;

interface

   type ELEMENT = CARDINAL ;

   // affiche un ELEMENT
   procedure ecrireElement(const e : ELEMENT) ;

   // permet la saisie d'un ELEMENT
   procedure lireElement(out e : ELEMENT) ;

   // renvoie un ELEMENT au hasard entre 0 et m
   function elementAleatoire(m : ELEMENT) : ELEMENT ;

implementation

   procedure ecrireElement(const e : ELEMENT) ;
   begin
      write(e) ;
   end ;

   procedure lireElement(out e : ELEMENT) ;
   begin
      read(e) ;
   end ;

   function elementAleatoire(m : ELEMENT) : ELEMENT ;
   begin
      elementAleatoire := random(m+1) ;
   end {elementAleatoire} ;

initialization

   randomize();  // pour initialiser le générateur aléatoire

end.