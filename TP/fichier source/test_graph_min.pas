program test_graph_min ;

uses SysUtils,u_graph_min;

begin
   initialiser;
   
   
   remplir_ecran(bleu);
   tracer_point(50,50,rouge);
   if test(50,50,rouge) then writeln('ok') else writeln('ko');

   tracer_ligne(10,50,20,20,blanc);
   if test(10,50,blanc) then writeln('ok') else writeln('ko');
   
   tracer_chaine(20,30,'Léopold',blanc,rouge);
   if not test(10,50,bleu) then writeln('ok') else writeln('ko');
   
   attendre_pression_touche;
   
   terminer;
   
end {test_graph_min}.