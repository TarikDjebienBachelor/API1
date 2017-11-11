// auteur : API1
// date   : mars 2007
// objet  : programme exemple de
//          d'ajout d'un enregistrement
//          en fin de fichier typé
program exemple3;

type
   POINT = record
      x,y : REAL;
   end {POINT};
   
   FICHIER_POINTS = file of POINT;

var
   fp : FICHIER_POINTS;
   p : POINT;
begin
   assign(fp,'sinus.data');
   reset(fp);
   seek(fp,filesize(fp));
   p.x := 2*pi;
   p.y := 1.;
   write(fp,p);
   close(fp);
end.