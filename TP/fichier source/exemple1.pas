// auteur : API1
// date   : mars 2007
// objet  : programme exemple de
//          création d'un fichier typé
program exemple1;

type
   POINT = record
      x,y : REAL;
   end {POINT};
   
   FICHIER_POINTS = file of POINT;

var
   fp : FICHIER_POINTS;
   i : CARDINAL;
   p : POINT;
begin
   assign(fp,'sinus.data');
   rewrite(fp);
   for i := 0 to 99 do begin
      p.x := 2*i*pi/100;
      p.y := sin(p.x);
      write(fp,p);
   end {for};
   close(fp);
end.