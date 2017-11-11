// auteur : API1
// date   : mars 2007
// objet  : programme exemple de
//          parcours d'un fichier typé
program exemple2;

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
   reset(fp);
   i := 0;
   while not eof(fp) do begin
      read(fp,p);
      writeln(i:3,p.x:7:3,p.y:7:3);
      inc(i);
   end {for};
   close(fp);
   writeln(i,' enregistrements lus');
end.