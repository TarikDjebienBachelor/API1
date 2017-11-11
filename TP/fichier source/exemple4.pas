// auteur : API1
// date   : mars 2007
// objet  : programme exemple de
//          de modification d'un enregistrement
//          dans un fichier typé
program exemple4;

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
   seek(fp,filesize(fp)-1);
   p.x := 2*pi;
   p.y := sin(p.x);
   write(fp,p);
   close(fp);
end.