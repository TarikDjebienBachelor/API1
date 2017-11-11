// Christian LASOU
// 27/01/2009
// TP1 : divers affichage de la table ASCII 

program TP1_table_ASCII ;

    procedure exercice_1 ;
    var k : CARDINAL ;
    begin
       // question 1
       for k := 65 to 90 do begin
          writeln(CHAR(k)) ;
       end {for} ;
       // Réponse à la question 2
       // CHAR(k) est le caractère dont le code est k
    end {exercice_1} ;

    procedure exercice_2 ;
    // équivaut à table1.pas : affichage sur une colonne sans se soucier des caractères non affichables
    var k : CARDINAL ;
    begin
       for k := 0 to 127 do begin
          writeln(CHAR(k):5,' : ',k:4) ;
       end {for} ;
    end {exercice_2} ;

    procedure exercice_3 ;
    // équivaut à table2.pas : affichage sur une colonne en tenant compte des caractères non affichables

       // la procédure afficher qui remplace les caractères non affichables par NA
       procedure afficher(const c : CHAR) ;
       begin
          if (ord(c) < 32) or (ord(c) = 127) then begin // le caractère n'est pas affichable
             write('NA':5) ;
          end else begin  // pas de problème
             write(c : 5) ;
          end {if} ; 
       end {afficher} ;

    var k : CARDINAL ;
    begin
       for k := 0 to 127 do begin
          afficher(CHAR(k)) ;
          writeln(' : ',k:4) ;
       end {for} ;
    end {exercice_3} ;

    procedure exercice_4 ;
    // équivaut à table3.pas : 
    // affichage sur plusieurs colonnes mais croissance en lignes

       // les constantes NBC et NBL
       const NBC = 4 ;
             NBL = 128 div NBC ; // 128 caractères sur NBC colonnes

       // la procédure afficher qui remplace les caractères non affichables par NA
       procedure afficher(const c : CHAR) ;
       begin
          if (ord(c) < 32) or (ord(c) = 127) then begin // le caractère n'est pas affichable
             write('NA':5) ;
          end else begin  // pas de problème
             write(c : 5) ;
          end {if} ; 
       end {afficher} ;

    var c,l,k : CARDINAL ;

    // deux versions possibles :

    // première version je fais une seule boucle et gére les passages à la ligne en utilisant les
    // variables c et l (c pour colonnes et l pour lignes) en fait l ne sert pas et NBL non plus
(*
    begin
       c := 1 ;  // au départ je suis sur la première colonne
       for k := 0 to 127 do begin
          // j'écris le contenu
          afficher(CHAR(k)) ;  write(' : ',k:4) ; // cette fois je ne vais pas toujours à la ligne
          if c = NBC then begin // c'était la dernière colonne donc je vais à la ligne
             writeln ;
             c := 1 ;   // et je remets c à 1
          end else begin // je passe à la colonne suivante
             c := c+1 ;
          end {if} ;
       end {for} ;
    end {exercice_4 version 1} ;
*)
    // seconde version je fais deux boucles imbriquées, l'une pour les lignes etl'autre pour les
    // colonne et je gère le numéro du caractères dans ces boucles
    // ATTENTION : il faut bien sûr mettre la première version en commentaire avec des (* *) par exemple
    begin
       k := 0 ;
       for l := 1 to NBL do begin   // j'écris une ligne
          for c := 1 to NBC do begin   // j'écris l'élément de la colonne c
             afficher(CHAR(k)) ;  write(' : ',k:4) ;
             // je prépare k pour le suivant
             k := k+1 ;
          end {for} ;
          // j'ai fini ma ligne donc je vais à la ligne
          writeln ;
       end {for} ;
    end {exercice_4 version 2} ;

// ATTENTION je généralise l'exercice 4
// J'avais fixé le nombre de colonnes à 8
// Question : puis-je le modifier ? Et par exemple prendre 4 colonnes au lieu de 8, ou bien 5 colonnes qui
// n'est plus un diviseur de 128
// Pour voir si c'est possible je modifie NBC en mettant 4 et je réessaie mes deux versions
// RÉPONSE : PAS DE PB POUR LES 2 VERSIONS AVEC NBC = 4
//           AVEC NBC NON DIVISEUR DE 128 PETITS PROBLÈMES (VOIR RÉSULTATS)

    procedure exercice_5 ;
    // équivaut à table4.pas : 
    // affichage sur plusieurs colonnes avec croissance en colonnes

       // les constantes NBC et NBL
       const NBC = 5 ;               // si NBC est non diviseur de 128 je dois ajouter 1 à NBL
             NBL = 128 div NBC + 1 ; // 128 caractères sur NBC colonnes

       // la procédure afficher qui remplace les caractères non affichables par NA
       procedure afficher(const c : CHAR) ;
       begin
          if (ord(c) < 32) or (ord(c) = 127) then begin // le caractère n'est pas affichable
             write('NA':5) ;
          end else begin  // pas de problème
             write(c : 5) ;
          end {if} ;
       end {afficher} ;

    var c,l,k,p : CARDINAL ;

    // deux versions possibles :

    // première version je fais une seule boucle et gére les passages à la ligne en utilisant les
    // variables c et l (c pour colonnes et l pour lignes) en fait l ne sert pas et NBL non plus
    // Cette fois je vais non plus afficher CHAR(k) et k mais utiliser une autre variable que j'appelle p
    // à chaque tour de boucle elle augmente de NBL si on ne va pas à la ligne et sinon elle vaut l-1
    // l étant le numéro de la ligne qui ici est utile
(*    begin
       c := 1 ; l := 1 ; p := l-1 ;
//       for k := 0 to 127 do begin         // si NBC non diviseur de 128 il vaut mieux faire une boucle TANT QUE
       k:= 0 ;                              // car si p >= 128 je ne dois pas compter le caractère
       while k < 128 do begin 
          // j'écris le contenu
          if p < 128 then begin  // si >= 128 ce n'est pas de l'ASCII standard
             afficher(CHAR(p)) ;  write(' : ',p:4) ; // cette fois je ne vais pas toujours à la ligne
             k := k+1 ;     // pour compter le caractère
          end {if} ;
          if c = NBC then begin // c'était la dernière colonne donc je vais à la ligne
             writeln ;
             c := 1 ;   // et je remets c à 1
             l := l+1 ; // je passe à la ligne suivante
             p := l-1 ;
          end else begin // je ne change pas de ligne mais p augmente de NBL et c de 1
             c := c+1 ;
             p := p + NBL ;
          end {if} ;
       end {for} ;
    end {exercice_5 version 1} ;
*)
    // seconde version je fais deux boucles imbriquées, l'une pour les lignes etl'autre pour les
    // colonne et je gère le numéro du caractères dans ces boucles
    // Remarque analague concernant la variable p
    // ATTENTION : il faut bien sûr mettre la première version en commentaire avec des (* *) par exemple
    begin
       k := 0 ;
       for l := 1 to NBL do begin   // j'écris une ligne
          p:= l-1 ;
          for c := 1 to NBC do begin   // j'écris l'élément de la colonne c
             if p < 128 then begin  // si >= 128 ce n'est pas de l'ASCII standard
                afficher(CHAR(p)) ;  write(' : ',p:4) ;
                k := k+1 ;
             end {if} ;
             // je prépare k pour le suivant
             p := p + NBL ;
          end {for} ;
          // j'ai fini ma ligne donc je vais à la ligne
          writeln ;
       end {for} ;
    end {exercice_5 version 2} ;

// ATTENTION je généralise l'exercice 5
// J'avais fixé le nombre de colonnes à 4
// Question : puis-je le modifier ? Et par exemple prendre 5 colonnes qui n'est plus un diviseur de 128
// Pour voir si c'est possible je modifie NBC en mettant 5 et je réessaie mes deux versions
// RÉPONSE : PAS DE PB POUR LES 2 VERSIONS AVEC NBC = 4
//           AVEC NBC NON DIVISEUR DE 128 PETITS PROBLÈMES (VOIR RÉSULTATS)

    procedure exercice_6 ;
    // production d'un fichier html contenant la table ASCII

       // Voici d'abord toutes les procédures données dans l'énoncé

       procedure debuterHTML(const nomPage : STRING) ;
       // debuterHTML(titre) écrit sur la sortie standard
       // le debut d'un document HTML.
       // le paramètre titre donne le titre du document.
       begin
          writeln('<html>') ;
          writeln('<head>') ;
          writeln('<title>',nomPage,'</title>') ; 
          writeln('</head>') ;
          writeln('<body>') ;
       end {ouvrirHTML};

       procedure finirHTML ;
       // finirHTML() écrit sur la sortie standard
       // la fin d'un document HTML.
       begin 
          writeln('</body>') ;
          writeln('</html>') ;
       end {finirHTML} ;

       procedure H1(const libelle : STRING) ;
       // H1(libelle) écrit sur la sortie standard
       // le libellé passé en paramètre entre les balises
       // <h1> et </h1>.
       begin
          writeln('<h1> ',libelle,'</h1>') ;
       end {H1} ;

       procedure debuterTable(const bordure : CARDINAL; const largeur : REAL) ;
       // debuterTable(b,l) écrit sur la sortie standard
       // le code HTML de début d'une table.
       // b indique l'épaisseur des bords des cellules.
       // l donne la largeur de la table en pourcentage
       // de la largeur de la fenêtre du navigateur.
       begin
          writeln('<table border="',bordure,'" width="',largeur:6:2,'%">') ;
       end {debuterTable};

       procedure finirTable ;
       // finirTable() écrit sur la sortie standard
       // le code HTML de fin d'une table.
       begin
          writeln('</table>') ;
       end {finirTable} ;

       procedure debuterLigne ;
       // debuterLigne() écrit sur la sortie standard
       // le code HTML du début d'une ligne de table.
       begin
          writeln('<tr>') ;
       end {debuterLigne} ;

       procedure finirLigne ;
       // finirLigne() écrit sur la sortie standard
       // le code HTML de fin d'une ligne de table.
       begin
          writeln('</tr>') ;
       end {finirLigne} ;

       procedure debuterCellule(const couleur : STRING) ;
       // debuterCellule(c) écrit sur la sortie standard
       // le code HTML de début d'une cellule.
       // Le paramètre c décrit la couleur de fond de cette cellule.
       begin
          write('<td bgcolor="',couleur,'">') ;
       end {debuterCellule} ;

       // finirCellule() écrit sur la sortie standard
       // le code HTML de fin d'une cellule.
       procedure finirCellule ;
       begin
          writeln('</td>') ;
       end {finirCellule};

       procedure exemple ;
       begin
          debuterHTML('Code ASCII') ;
          H1('Table des caractères ASCII') ;
          debuterTable(5,50) ;
          // 1ère ligne
          debuterLigne() ;  // on peut mettre ou ne pas mettre les ()
          debuterCellule('#777777') ;
          write('Case 1,1') ;
          finirCellule() ;
          debuterCellule('#AAAAAA') ;
          write('Case 1,2') ;
          finirCellule() ;
          debuterCellule('#CCCCCC') ;
          write('Case 1,3') ;
          finirCellule(); finirLigne() ;
          // 2ème ligne
          debuterLigne() ;
          debuterCellule('#777777') ;
          write('Case 2,1');
          finirCellule();
          debuterCellule('#AAAAAA') ;
          write('Case 2,2') ;
          finirCellule() ;
          debuterCellule('#CCCCCC') ;
          write('Case 2,3') ;
          finirCellule() ;
          finirLigne() ;
          finirTable() ;
          finirHTML() ;
       end {exemple} ;

       // les constantes NBC et NBL
       const NBC = 4 ;           // j'ai repris la valeur 4 pour NBC
             NBL = 128 div NBC ; // 128 caractères sur NBC colonnes

       // la procédure afficher qui remplace les caractères non affichables par NA
       procedure afficher(const c : CHAR) ;
       begin
          if (ord(c) < 32) or (ord(c) = 127) then begin // le caractère n'est pas affichable
             write('NA':5) ;
          end else begin  // pas de problème
             write(c : 5) ;
          end {if} ;
       end {afficher} ;

    var c,l,k,p : CARDINAL ;

    begin
       // essai de l'exemple avec la sortie standard (écran)
       // exemple ;
       // pour essayer la'exemple avec sortie dans un fichier de nom tableASCII.html
       // il suffit de taper dans un terminal
       //  ./TP1_table_ASCII >tableASCII.html
       // Je passe à la création de la vraie table ASCII
       debuterHTML('Code ASCII') ;
       H1('Table des caractères ASCII') ;
       debuterTable(5,50) ;
       k := 0 ;
       for l := 1 to NBL do begin   // j'écris une ligne
          p:= l-1 ;
          debuterLigne() ;  // on peut mettre ou ne pas mettre les ()
          for c := 1 to NBC do begin   // j'écris l'élément de la colonne c sur 2 cases
             // première case en gris foncé avec le caractère
             debuterCellule('#777777') ;
             afficher(CHAR(p)) ;    // je ne fais pas le test p < 128 inutile ici
             finirCellule() ;
             // seconde case en gris moyen
             debuterCellule('#AAAAAA') ;
             write(p:4) ;
             finirCellule() ;
             // je prépare k pour le suivant
             k := k+1 ;
             p := p + NBL ;
          end {for} ;
          // j'ai fini ma ligne
          finirLigne() ;
       end {for} ;
       finirTable() ;
       finirHTML() ;
    end {exercice_6} ;

begin
(*
   writeln('exercice 1') ;
   exercice_1 ;
   writeln ;

   writeln('exercice 2') ;
   exercice_2 ;
   writeln ;

   writeln('exercice 3') ;
   exercice_3 ;
   writeln ;

   writeln('exercice 4') ;
   exercice_4 ;
   writeln ;

   writeln('exercice 5') ;
   exercice_5 ;
   writeln ;
*)
   writeln('exercice 6') ;
   exercice_6 ;
   writeln ;

end.


RESULTATS

exercice 1
A
B
C
D
E
F
G
H
I
J
K
L
M
N
O
P
Q
R
S
T
U
V
W
X
Y
Z

exercice 2
     :    0
     :    1
     :    2
     :    3
     :    4
     :    5
     :    6
     :    7
    :    8
         :    9

 :   10

     :   11

     :   12
 :   13
     :   14
     :   15
     :   16
     :   17
     :   18
     :   19
     :   20
     :   21
     :   22
     :   23
    ▒ :   24
     :   25
    ▒ :   26
    :   27
     :   28
     :   29
     :   30
     :   31
      :   32
    ! :   33
    " :   34
    # :   35
    $ :   36
    % :   37
    & :   38
    ' :   39
    ( :   40
    ) :   41
    * :   42
    + :   43
    , :   44
    - :   45
    . :   46
    / :   47
    0 :   48
    1 :   49
    2 :   50
    3 :   51
    4 :   52
    5 :   53
    6 :   54
    7 :   55
    8 :   56
    9 :   57
    : :   58
    ; :   59
    < :   60
    = :   61
    > :   62
    ? :   63
    @ :   64
    A :   65
    B :   66
    C :   67
    D :   68
    E :   69
    F :   70
    G :   71
    H :   72
    I :   73
    J :   74
    K :   75
    L :   76
    M :   77
    N :   78
    O :   79
    P :   80
    Q :   81
    R :   82
    S :   83
    T :   84
    U :   85
    V :   86
    W :   87
    X :   88
    Y :   89
    Z :   90
    [ :   91
    \ :   92
    ] :   93
    ^ :   94
    _ :   95
    ` :   96
    a :   97
    b :   98
    c :   99
    d :  100
    e :  101
    f :  102
    g :  103
    h :  104
    i :  105
    j :  106
    k :  107
    l :  108
    m :  109
    n :  110
    o :  111
    p :  112
    q :  113
    r :  114
    s :  115
    t :  116
    u :  117
    v :  118
    w :  119
    x :  120
    y :  121
    z :  122
    { :  123
    | :  124
    } :  125
    ~ :  126
     :  127

exercice 3
   NA :    0
   NA :    1
   NA :    2
   NA :    3
   NA :    4
   NA :    5
   NA :    6
   NA :    7
   NA :    8
   NA :    9
   NA :   10
   NA :   11
   NA :   12
   NA :   13
   NA :   14
   NA :   15
   NA :   16
   NA :   17
   NA :   18
   NA :   19
   NA :   20
   NA :   21
   NA :   22
   NA :   23
   NA :   24
   NA :   25
   NA :   26
   NA :   27
   NA :   28
   NA :   29
   NA :   30
   NA :   31
      :   32
    ! :   33
    " :   34
    # :   35
    $ :   36
    % :   37
    & :   38
    ' :   39
    ( :   40
    ) :   41
    * :   42
    + :   43
    , :   44
    - :   45
    . :   46
    / :   47
    0 :   48
    1 :   49
    2 :   50
    3 :   51
    4 :   52
    5 :   53
    6 :   54
    7 :   55
    8 :   56
    9 :   57
    : :   58
    ; :   59
    < :   60
    = :   61
    > :   62
    ? :   63
    @ :   64
    A :   65
    B :   66
    C :   67
    D :   68
    E :   69
    F :   70
    G :   71
    H :   72
    I :   73
    J :   74
    K :   75
    L :   76
    M :   77
    N :   78
    O :   79
    P :   80
    Q :   81
    R :   82
    S :   83
    T :   84
    U :   85
    V :   86
    W :   87
    X :   88
    Y :   89
    Z :   90
    [ :   91
    \ :   92
    ] :   93
    ^ :   94
    _ :   95
    ` :   96
    a :   97
    b :   98
    c :   99
    d :  100
    e :  101
    f :  102
    g :  103
    h :  104
    i :  105
    j :  106
    k :  107
    l :  108
    m :  109
    n :  110
    o :  111
    p :  112
    q :  113
    r :  114
    s :  115
    t :  116
    u :  117
    v :  118
    w :  119
    x :  120
    y :  121
    z :  122
    { :  123
    | :  124
    } :  125
    ~ :  126
   NA :  127

exercice 4  version 1
   NA :    0   NA :    1   NA :    2   NA :    3   NA :    4   NA :    5   NA :    6   NA :    7
   NA :    8   NA :    9   NA :   10   NA :   11   NA :   12   NA :   13   NA :   14   NA :   15
   NA :   16   NA :   17   NA :   18   NA :   19   NA :   20   NA :   21   NA :   22   NA :   23
   NA :   24   NA :   25   NA :   26   NA :   27   NA :   28   NA :   29   NA :   30   NA :   31
      :   32    ! :   33    " :   34    # :   35    $ :   36    % :   37    & :   38    ' :   39
    ( :   40    ) :   41    * :   42    + :   43    , :   44    - :   45    . :   46    / :   47
    0 :   48    1 :   49    2 :   50    3 :   51    4 :   52    5 :   53    6 :   54    7 :   55
    8 :   56    9 :   57    : :   58    ; :   59    < :   60    = :   61    > :   62    ? :   63
    @ :   64    A :   65    B :   66    C :   67    D :   68    E :   69    F :   70    G :   71
    H :   72    I :   73    J :   74    K :   75    L :   76    M :   77    N :   78    O :   79
    P :   80    Q :   81    R :   82    S :   83    T :   84    U :   85    V :   86    W :   87
    X :   88    Y :   89    Z :   90    [ :   91    \ :   92    ] :   93    ^ :   94    _ :   95
    ` :   96    a :   97    b :   98    c :   99    d :  100    e :  101    f :  102    g :  103
    h :  104    i :  105    j :  106    k :  107    l :  108    m :  109    n :  110    o :  111
    p :  112    q :  113    r :  114    s :  115    t :  116    u :  117    v :  118    w :  119
    x :  120    y :  121    z :  122    { :  123    | :  124    } :  125    ~ :  126   NA :  127

exercice 4  version 2
   NA :    0   NA :    1   NA :    2   NA :    3   NA :    4   NA :    5   NA :    6   NA :    7
   NA :    8   NA :    9   NA :   10   NA :   11   NA :   12   NA :   13   NA :   14   NA :   15
   NA :   16   NA :   17   NA :   18   NA :   19   NA :   20   NA :   21   NA :   22   NA :   23
   NA :   24   NA :   25   NA :   26   NA :   27   NA :   28   NA :   29   NA :   30   NA :   31
      :   32    ! :   33    " :   34    # :   35    $ :   36    % :   37    & :   38    ' :   39
    ( :   40    ) :   41    * :   42    + :   43    , :   44    - :   45    . :   46    / :   47
    0 :   48    1 :   49    2 :   50    3 :   51    4 :   52    5 :   53    6 :   54    7 :   55
    8 :   56    9 :   57    : :   58    ; :   59    < :   60    = :   61    > :   62    ? :   63
    @ :   64    A :   65    B :   66    C :   67    D :   68    E :   69    F :   70    G :   71
    H :   72    I :   73    J :   74    K :   75    L :   76    M :   77    N :   78    O :   79
    P :   80    Q :   81    R :   82    S :   83    T :   84    U :   85    V :   86    W :   87
    X :   88    Y :   89    Z :   90    [ :   91    \ :   92    ] :   93    ^ :   94    _ :   95
    ` :   96    a :   97    b :   98    c :   99    d :  100    e :  101    f :  102    g :  103
    h :  104    i :  105    j :  106    k :  107    l :  108    m :  109    n :  110    o :  111
    p :  112    q :  113    r :  114    s :  115    t :  116    u :  117    v :  118    w :  119
    x :  120    y :  121    z :  122    { :  123    | :  124    } :  125    ~ :  126   NA :  127

exercice 4  version 1 avec NBC = 4
   NA :    0   NA :    1   NA :    2   NA :    3
   NA :    4   NA :    5   NA :    6   NA :    7
   NA :    8   NA :    9   NA :   10   NA :   11
   NA :   12   NA :   13   NA :   14   NA :   15
   NA :   16   NA :   17   NA :   18   NA :   19
   NA :   20   NA :   21   NA :   22   NA :   23
   NA :   24   NA :   25   NA :   26   NA :   27
   NA :   28   NA :   29   NA :   30   NA :   31
      :   32    ! :   33    " :   34    # :   35
    $ :   36    % :   37    & :   38    ' :   39
    ( :   40    ) :   41    * :   42    + :   43
    , :   44    - :   45    . :   46    / :   47
    0 :   48    1 :   49    2 :   50    3 :   51
    4 :   52    5 :   53    6 :   54    7 :   55
    8 :   56    9 :   57    : :   58    ; :   59
    < :   60    = :   61    > :   62    ? :   63
    @ :   64    A :   65    B :   66    C :   67
    D :   68    E :   69    F :   70    G :   71
    H :   72    I :   73    J :   74    K :   75
    L :   76    M :   77    N :   78    O :   79
    P :   80    Q :   81    R :   82    S :   83
    T :   84    U :   85    V :   86    W :   87
    X :   88    Y :   89    Z :   90    [ :   91
    \ :   92    ] :   93    ^ :   94    _ :   95
    ` :   96    a :   97    b :   98    c :   99
    d :  100    e :  101    f :  102    g :  103
    h :  104    i :  105    j :  106    k :  107
    l :  108    m :  109    n :  110    o :  111
    p :  112    q :  113    r :  114    s :  115
    t :  116    u :  117    v :  118    w :  119
    x :  120    y :  121    z :  122    { :  123
    | :  124    } :  125    ~ :  126   NA :  127

exercice 4  version 2 avec NBC = 4
   NA :    0   NA :    1   NA :    2   NA :    3
   NA :    4   NA :    5   NA :    6   NA :    7
   NA :    8   NA :    9   NA :   10   NA :   11
   NA :   12   NA :   13   NA :   14   NA :   15
   NA :   16   NA :   17   NA :   18   NA :   19
   NA :   20   NA :   21   NA :   22   NA :   23
   NA :   24   NA :   25   NA :   26   NA :   27
   NA :   28   NA :   29   NA :   30   NA :   31
      :   32    ! :   33    " :   34    # :   35
    $ :   36    % :   37    & :   38    ' :   39
    ( :   40    ) :   41    * :   42    + :   43
    , :   44    - :   45    . :   46    / :   47
    0 :   48    1 :   49    2 :   50    3 :   51
    4 :   52    5 :   53    6 :   54    7 :   55
    8 :   56    9 :   57    : :   58    ; :   59
    < :   60    = :   61    > :   62    ? :   63
    @ :   64    A :   65    B :   66    C :   67
    D :   68    E :   69    F :   70    G :   71
    H :   72    I :   73    J :   74    K :   75
    L :   76    M :   77    N :   78    O :   79
    P :   80    Q :   81    R :   82    S :   83
    T :   84    U :   85    V :   86    W :   87
    X :   88    Y :   89    Z :   90    [ :   91
    \ :   92    ] :   93    ^ :   94    _ :   95
    ` :   96    a :   97    b :   98    c :   99
    d :  100    e :  101    f :  102    g :  103
    h :  104    i :  105    j :  106    k :  107
    l :  108    m :  109    n :  110    o :  111
    p :  112    q :  113    r :  114    s :  115
    t :  116    u :  117    v :  118    w :  119
    x :  120    y :  121    z :  122    { :  123
    | :  124    } :  125    ~ :  126   NA :  127

exercice 4  version 1 avec NBC = 5
   NA :    0   NA :    1   NA :    2   NA :    3   NA :    4
   NA :    5   NA :    6   NA :    7   NA :    8   NA :    9
   NA :   10   NA :   11   NA :   12   NA :   13   NA :   14
   NA :   15   NA :   16   NA :   17   NA :   18   NA :   19
   NA :   20   NA :   21   NA :   22   NA :   23   NA :   24
   NA :   25   NA :   26   NA :   27   NA :   28   NA :   29
   NA :   30   NA :   31      :   32    ! :   33    " :   34
    # :   35    $ :   36    % :   37    & :   38    ' :   39
    ( :   40    ) :   41    * :   42    + :   43    , :   44
    - :   45    . :   46    / :   47    0 :   48    1 :   49
    2 :   50    3 :   51    4 :   52    5 :   53    6 :   54
    7 :   55    8 :   56    9 :   57    : :   58    ; :   59
    < :   60    = :   61    > :   62    ? :   63    @ :   64
    A :   65    B :   66    C :   67    D :   68    E :   69
    F :   70    G :   71    H :   72    I :   73    J :   74
    K :   75    L :   76    M :   77    N :   78    O :   79
    P :   80    Q :   81    R :   82    S :   83    T :   84
    U :   85    V :   86    W :   87    X :   88    Y :   89
    Z :   90    [ :   91    \ :   92    ] :   93    ^ :   94
    _ :   95    ` :   96    a :   97    b :   98    c :   99
    d :  100    e :  101    f :  102    g :  103    h :  104
    i :  105    j :  106    k :  107    l :  108    m :  109
    n :  110    o :  111    p :  112    q :  113    r :  114
    s :  115    t :  116    u :  117    v :  118    w :  119
    x :  120    y :  121    z :  122    { :  123    | :  124
    } :  125    ~ :  126   NA :  127

exercice 4  version 2 avec NBC = 5
   NA :    0   NA :    1   NA :    2   NA :    3   NA :    4
   NA :    5   NA :    6   NA :    7   NA :    8   NA :    9
   NA :   10   NA :   11   NA :   12   NA :   13   NA :   14
   NA :   15   NA :   16   NA :   17   NA :   18   NA :   19
   NA :   20   NA :   21   NA :   22   NA :   23   NA :   24
   NA :   25   NA :   26   NA :   27   NA :   28   NA :   29
   NA :   30   NA :   31      :   32    ! :   33    " :   34
    # :   35    $ :   36    % :   37    & :   38    ' :   39
    ( :   40    ) :   41    * :   42    + :   43    , :   44
    - :   45    . :   46    / :   47    0 :   48    1 :   49
    2 :   50    3 :   51    4 :   52    5 :   53    6 :   54
    7 :   55    8 :   56    9 :   57    : :   58    ; :   59
    < :   60    = :   61    > :   62    ? :   63    @ :   64
    A :   65    B :   66    C :   67    D :   68    E :   69
    F :   70    G :   71    H :   72    I :   73    J :   74
    K :   75    L :   76    M :   77    N :   78    O :   79
    P :   80    Q :   81    R :   82    S :   83    T :   84
    U :   85    V :   86    W :   87    X :   88    Y :   89
    Z :   90    [ :   91    \ :   92    ] :   93    ^ :   94
    _ :   95    ` :   96    a :   97    b :   98    c :   99
    d :  100    e :  101    f :  102    g :  103    h :  104
    i :  105    j :  106    k :  107    l :  108    m :  109
    n :  110    o :  111    p :  112    q :  113    r :  114
    s :  115    t :  116    u :  117    v :  118    w :  119
    x :  120    y :  121    z :  122    { :  123    | :  124
ATTENTION : ICI ON A UN PB CAR IL MANQUE LA DERNIÈRE LIGNE
NORMAL LE NOMBRE DE LIGNES N'EST PLUS 128 div NBC MAIS (128 div NBC) + 1
MODIFIONS NBL ET ON RÉESSAIE
} JE FERME L'ACCOLADE DU NUMÉRO 123

exercice 4  version 2 avec NBC = 5 et NBL = 128 div NBC + 1
   NA :    0   NA :    1   NA :    2   NA :    3   NA :    4
   NA :    5   NA :    6   NA :    7   NA :    8   NA :    9
   NA :   10   NA :   11   NA :   12   NA :   13   NA :   14
   NA :   15   NA :   16   NA :   17   NA :   18   NA :   19
   NA :   20   NA :   21   NA :   22   NA :   23   NA :   24
   NA :   25   NA :   26   NA :   27   NA :   28   NA :   29
   NA :   30   NA :   31      :   32    ! :   33    " :   34
    # :   35    $ :   36    % :   37    & :   38    ' :   39
    ( :   40    ) :   41    * :   42    + :   43    , :   44
    - :   45    . :   46    / :   47    0 :   48    1 :   49
    2 :   50    3 :   51    4 :   52    5 :   53    6 :   54
    7 :   55    8 :   56    9 :   57    : :   58    ; :   59
    < :   60    = :   61    > :   62    ? :   63    @ :   64
    A :   65    B :   66    C :   67    D :   68    E :   69
    F :   70    G :   71    H :   72    I :   73    J :   74
    K :   75    L :   76    M :   77    N :   78    O :   79
    P :   80    Q :   81    R :   82    S :   83    T :   84
    U :   85    V :   86    W :   87    X :   88    Y :   89
    Z :   90    [ :   91    \ :   92    ] :   93    ^ :   94
    _ :   95    ` :   96    a :   97    b :   98    c :   99
    d :  100    e :  101    f :  102    g :  103    h :  104
    i :  105    j :  106    k :  107    l :  108    m :  109
    n :  110    o :  111    p :  112    q :  113    r :  114
    s :  115    t :  116    u :  117    v :  118    w :  119
    x :  120    y :  121    z :  122    { :  123    | :  124
    } :  125    ~ :  126   NA :  127    � :  128    � :  129
LE PROBLÈME N'EST PAS RÉSOLU CAR J'AI 2 CARACTÈRES EN TROP
LES NUMÉROS 128 ET 129
JE POURRAIS RÈGLER CE PROBLÈME EN TESTANT LE CODE D'UN CARACTÈRE
AVANT DE L'AFFICHER EN METTANT DANS LA PROCÉDURE afficher un
"if k < 128 then begin ...
JE NE LE FAIS PAS

CONCLUSION : JE TROUVE LA VERSION 1 MEILLEURE

exercice 5  version 1 avec NBC = 4
   NA :    0      :   32    @ :   64    ` :   96
   NA :    1    ! :   33    A :   65    a :   97
   NA :    2    " :   34    B :   66    b :   98
   NA :    3    # :   35    C :   67    c :   99
   NA :    4    $ :   36    D :   68    d :  100
   NA :    5    % :   37    E :   69    e :  101
   NA :    6    & :   38    F :   70    f :  102
   NA :    7    ' :   39    G :   71    g :  103
   NA :    8    ( :   40    H :   72    h :  104
   NA :    9    ) :   41    I :   73    i :  105
   NA :   10    * :   42    J :   74    j :  106
   NA :   11    + :   43    K :   75    k :  107
   NA :   12    , :   44    L :   76    l :  108
   NA :   13    - :   45    M :   77    m :  109
   NA :   14    . :   46    N :   78    n :  110
   NA :   15    / :   47    O :   79    o :  111
   NA :   16    0 :   48    P :   80    p :  112
   NA :   17    1 :   49    Q :   81    q :  113
   NA :   18    2 :   50    R :   82    r :  114
   NA :   19    3 :   51    S :   83    s :  115
   NA :   20    4 :   52    T :   84    t :  116
   NA :   21    5 :   53    U :   85    u :  117
   NA :   22    6 :   54    V :   86    v :  118
   NA :   23    7 :   55    W :   87    w :  119
   NA :   24    8 :   56    X :   88    x :  120
   NA :   25    9 :   57    Y :   89    y :  121
   NA :   26    : :   58    Z :   90    z :  122
   NA :   27    ; :   59    [ :   91    { :  123
   NA :   28    < :   60    \ :   92    | :  124
   NA :   29    = :   61    ] :   93    } :  125
   NA :   30    > :   62    ^ :   94    ~ :  126
   NA :   31    ? :   63    _ :   95   NA :  127

exercice 5   version 2 avec NBC = 4
   NA :    0      :   32    @ :   64    ` :   96
   NA :    1    ! :   33    A :   65    a :   97
   NA :    2    " :   34    B :   66    b :   98
   NA :    3    # :   35    C :   67    c :   99
   NA :    4    $ :   36    D :   68    d :  100
   NA :    5    % :   37    E :   69    e :  101
   NA :    6    & :   38    F :   70    f :  102
   NA :    7    ' :   39    G :   71    g :  103
   NA :    8    ( :   40    H :   72    h :  104
   NA :    9    ) :   41    I :   73    i :  105
   NA :   10    * :   42    J :   74    j :  106
   NA :   11    + :   43    K :   75    k :  107
   NA :   12    , :   44    L :   76    l :  108
   NA :   13    - :   45    M :   77    m :  109
   NA :   14    . :   46    N :   78    n :  110
   NA :   15    / :   47    O :   79    o :  111
   NA :   16    0 :   48    P :   80    p :  112
   NA :   17    1 :   49    Q :   81    q :  113
   NA :   18    2 :   50    R :   82    r :  114
   NA :   19    3 :   51    S :   83    s :  115
   NA :   20    4 :   52    T :   84    t :  116
   NA :   21    5 :   53    U :   85    u :  117
   NA :   22    6 :   54    V :   86    v :  118
   NA :   23    7 :   55    W :   87    w :  119
   NA :   24    8 :   56    X :   88    x :  120
   NA :   25    9 :   57    Y :   89    y :  121
   NA :   26    : :   58    Z :   90    z :  122
   NA :   27    ; :   59    [ :   91    { :  123
   NA :   28    < :   60    \ :   92    | :  124
   NA :   29    = :   61    ] :   93    } :  125
   NA :   30    > :   62    ^ :   94    ~ :  126
   NA :   31    ? :   63    _ :   95   NA :  127

exercice 5   version 1 avec NBC = 5
   NA :    0   NA :   26    4 :   52    N :   78    h :  104
   NA :    1   NA :   27    5 :   53    O :   79    i :  105
   NA :    2   NA :   28    6 :   54    P :   80    j :  106
   NA :    3   NA :   29    7 :   55    Q :   81    k :  107
   NA :    4   NA :   30    8 :   56    R :   82    l :  108
   NA :    5   NA :   31    9 :   57    S :   83    m :  109
   NA :    6      :   32    : :   58    T :   84    n :  110
   NA :    7    ! :   33    ; :   59    U :   85    o :  111
   NA :    8    " :   34    < :   60    V :   86    p :  112
   NA :    9    # :   35    = :   61    W :   87    q :  113
   NA :   10    $ :   36    > :   62    X :   88    r :  114
   NA :   11    % :   37    ? :   63    Y :   89    s :  115
   NA :   12    & :   38    @ :   64    Z :   90    t :  116
   NA :   13    ' :   39    A :   65    [ :   91    u :  117
   NA :   14    ( :   40    B :   66    \ :   92    v :  118
   NA :   15    ) :   41    C :   67    ] :   93    w :  119
   NA :   16    * :   42    D :   68    ^ :   94    x :  120
   NA :   17    + :   43    E :   69    _ :   95    y :  121
   NA :   18    , :   44    F :   70    ` :   96    z :  122
   NA :   19    - :   45    G :   71    a :   97    { :  123
   NA :   20    . :   46    H :   72    b :   98    | :  124
   NA :   21    / :   47    I :   73    c :   99    } :  125
   NA :   22    0 :   48    J :   74    d :  100    ~ :  126
   NA :   23    1 :   49    K :   75    e :  101   NA :  127
   NA :   24    2 :   50    L :   76    f :  102               les derniers caractères des 2 dernières
   NA :   25    3 :   51    M :   77    g :  103               lignes ne sont pas affichés car code > 127

exercice 5    version 2 avec NBC = 5
   NA :    0   NA :   26    4 :   52    N :   78    h :  104
   NA :    1   NA :   27    5 :   53    O :   79    i :  105
   NA :    2   NA :   28    6 :   54    P :   80    j :  106
   NA :    3   NA :   29    7 :   55    Q :   81    k :  107
   NA :    4   NA :   30    8 :   56    R :   82    l :  108
   NA :    5   NA :   31    9 :   57    S :   83    m :  109
   NA :    6      :   32    : :   58    T :   84    n :  110
   NA :    7    ! :   33    ; :   59    U :   85    o :  111
   NA :    8    " :   34    < :   60    V :   86    p :  112
   NA :    9    # :   35    = :   61    W :   87    q :  113
   NA :   10    $ :   36    > :   62    X :   88    r :  114
   NA :   11    % :   37    ? :   63    Y :   89    s :  115
   NA :   12    & :   38    @ :   64    Z :   90    t :  116
   NA :   13    ' :   39    A :   65    [ :   91    u :  117
   NA :   14    ( :   40    B :   66    \ :   92    v :  118
   NA :   15    ) :   41    C :   67    ] :   93    w :  119
   NA :   16    * :   42    D :   68    ^ :   94    x :  120
   NA :   17    + :   43    E :   69    _ :   95    y :  121
   NA :   18    , :   44    F :   70    ` :   96    z :  122
   NA :   19    - :   45    G :   71    a :   97    { :  123
   NA :   20    . :   46    H :   72    b :   98    | :  124
   NA :   21    / :   47    I :   73    c :   99    } :  125
   NA :   22    0 :   48    J :   74    d :  100    ~ :  126
   NA :   23    1 :   49    K :   75    e :  101   NA :  127
   NA :   24    2 :   50    L :   76    f :  102
   NA :   25    3 :   51    M :   77    g :  103

exercice 6  l'exemple
<html>
<head>
<title>Code ASCII</title>
</head>
<body>
<h1> Table des caractères ASCII</h1>
<table border="5" width=" 50.00%">
<tr>
<td bgcolor="#777777">Case 1,1</td>
<td bgcolor="#AAAAAA">Case 1,2</td>
<td bgcolor="#CCCCCC">Case 1,3</td>
</tr>
<tr>
<td bgcolor="#777777">Case 2,1</td>
<td bgcolor="#AAAAAA">Case 2,2</td>
<td bgcolor="#CCCCCC">Case 2,3</td>
</tr>
</table>
</body>
</html>

exercice 6  Copier-coller du fichier tableASCII.html avec l'exemple
Table des caractères ASCII
Case 1,1 	Case 1,2 	Case 1,3          On ne voit pas les cases comme
Case 2,1 	Case 2,2 	Case 2,3          dans un navigateur malheureusement

exercice 6  le fichier tableASCII.html
<html>
<head>
<title>Code ASCII</title>
</head>
<body>
<h1> Table des caractères ASCII</h1>
<table border="5" width=" 50.00%">
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">   0</td>
<td bgcolor="#777777">     </td>
<td bgcolor="#AAAAAA">  32</td>
<td bgcolor="#777777">    @</td>
<td bgcolor="#AAAAAA">  64</td>
<td bgcolor="#777777">    `</td>
<td bgcolor="#AAAAAA">  96</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">   1</td>
<td bgcolor="#777777">    !</td>
<td bgcolor="#AAAAAA">  33</td>
<td bgcolor="#777777">    A</td>
<td bgcolor="#AAAAAA">  65</td>
<td bgcolor="#777777">    a</td>
<td bgcolor="#AAAAAA">  97</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">   2</td>
<td bgcolor="#777777">    "</td>
<td bgcolor="#AAAAAA">  34</td>
<td bgcolor="#777777">    B</td>
<td bgcolor="#AAAAAA">  66</td>
<td bgcolor="#777777">    b</td>
<td bgcolor="#AAAAAA">  98</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">   3</td>
<td bgcolor="#777777">    #</td>
<td bgcolor="#AAAAAA">  35</td>
<td bgcolor="#777777">    C</td>
<td bgcolor="#AAAAAA">  67</td>
<td bgcolor="#777777">    c</td>
<td bgcolor="#AAAAAA">  99</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">   4</td>
<td bgcolor="#777777">    $</td>
<td bgcolor="#AAAAAA">  36</td>
<td bgcolor="#777777">    D</td>
<td bgcolor="#AAAAAA">  68</td>
<td bgcolor="#777777">    d</td>
<td bgcolor="#AAAAAA"> 100</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">   5</td>
<td bgcolor="#777777">    %</td>
<td bgcolor="#AAAAAA">  37</td>
<td bgcolor="#777777">    E</td>
<td bgcolor="#AAAAAA">  69</td>
<td bgcolor="#777777">    e</td>
<td bgcolor="#AAAAAA"> 101</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">   6</td>
<td bgcolor="#777777">    &</td>
<td bgcolor="#AAAAAA">  38</td>
<td bgcolor="#777777">    F</td>
<td bgcolor="#AAAAAA">  70</td>
<td bgcolor="#777777">    f</td>
<td bgcolor="#AAAAAA"> 102</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">   7</td>
<td bgcolor="#777777">    '</td>
<td bgcolor="#AAAAAA">  39</td>
<td bgcolor="#777777">    G</td>
<td bgcolor="#AAAAAA">  71</td>
<td bgcolor="#777777">    g</td>
<td bgcolor="#AAAAAA"> 103</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">   8</td>
<td bgcolor="#777777">    (</td>
<td bgcolor="#AAAAAA">  40</td>
<td bgcolor="#777777">    H</td>
<td bgcolor="#AAAAAA">  72</td>
<td bgcolor="#777777">    h</td>
<td bgcolor="#AAAAAA"> 104</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">   9</td>
<td bgcolor="#777777">    )</td>
<td bgcolor="#AAAAAA">  41</td>
<td bgcolor="#777777">    I</td>
<td bgcolor="#AAAAAA">  73</td>
<td bgcolor="#777777">    i</td>
<td bgcolor="#AAAAAA"> 105</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  10</td>
<td bgcolor="#777777">    *</td>
<td bgcolor="#AAAAAA">  42</td>
<td bgcolor="#777777">    J</td>
<td bgcolor="#AAAAAA">  74</td>
<td bgcolor="#777777">    j</td>
<td bgcolor="#AAAAAA"> 106</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  11</td>
<td bgcolor="#777777">    +</td>
<td bgcolor="#AAAAAA">  43</td>
<td bgcolor="#777777">    K</td>
<td bgcolor="#AAAAAA">  75</td>
<td bgcolor="#777777">    k</td>
<td bgcolor="#AAAAAA"> 107</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  12</td>
<td bgcolor="#777777">    ,</td>
<td bgcolor="#AAAAAA">  44</td>
<td bgcolor="#777777">    L</td>
<td bgcolor="#AAAAAA">  76</td>
<td bgcolor="#777777">    l</td>
<td bgcolor="#AAAAAA"> 108</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  13</td>
<td bgcolor="#777777">    -</td>
<td bgcolor="#AAAAAA">  45</td>
<td bgcolor="#777777">    M</td>
<td bgcolor="#AAAAAA">  77</td>
<td bgcolor="#777777">    m</td>
<td bgcolor="#AAAAAA"> 109</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  14</td>
<td bgcolor="#777777">    .</td>
<td bgcolor="#AAAAAA">  46</td>
<td bgcolor="#777777">    N</td>
<td bgcolor="#AAAAAA">  78</td>
<td bgcolor="#777777">    n</td>
<td bgcolor="#AAAAAA"> 110</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  15</td>
<td bgcolor="#777777">    /</td>
<td bgcolor="#AAAAAA">  47</td>
<td bgcolor="#777777">    O</td>
<td bgcolor="#AAAAAA">  79</td>
<td bgcolor="#777777">    o</td>
<td bgcolor="#AAAAAA"> 111</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  16</td>
<td bgcolor="#777777">    0</td>
<td bgcolor="#AAAAAA">  48</td>
<td bgcolor="#777777">    P</td>
<td bgcolor="#AAAAAA">  80</td>
<td bgcolor="#777777">    p</td>
<td bgcolor="#AAAAAA"> 112</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  17</td>
<td bgcolor="#777777">    1</td>
<td bgcolor="#AAAAAA">  49</td>
<td bgcolor="#777777">    Q</td>
<td bgcolor="#AAAAAA">  81</td>
<td bgcolor="#777777">    q</td>
<td bgcolor="#AAAAAA"> 113</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  18</td>
<td bgcolor="#777777">    2</td>
<td bgcolor="#AAAAAA">  50</td>
<td bgcolor="#777777">    R</td>
<td bgcolor="#AAAAAA">  82</td>
<td bgcolor="#777777">    r</td>
<td bgcolor="#AAAAAA"> 114</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  19</td>
<td bgcolor="#777777">    3</td>
<td bgcolor="#AAAAAA">  51</td>
<td bgcolor="#777777">    S</td>
<td bgcolor="#AAAAAA">  83</td>
<td bgcolor="#777777">    s</td>
<td bgcolor="#AAAAAA"> 115</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  20</td>
<td bgcolor="#777777">    4</td>
<td bgcolor="#AAAAAA">  52</td>
<td bgcolor="#777777">    T</td>
<td bgcolor="#AAAAAA">  84</td>
<td bgcolor="#777777">    t</td>
<td bgcolor="#AAAAAA"> 116</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  21</td>
<td bgcolor="#777777">    5</td>
<td bgcolor="#AAAAAA">  53</td>
<td bgcolor="#777777">    U</td>
<td bgcolor="#AAAAAA">  85</td>
<td bgcolor="#777777">    u</td>
<td bgcolor="#AAAAAA"> 117</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  22</td>
<td bgcolor="#777777">    6</td>
<td bgcolor="#AAAAAA">  54</td>
<td bgcolor="#777777">    V</td>
<td bgcolor="#AAAAAA">  86</td>
<td bgcolor="#777777">    v</td>
<td bgcolor="#AAAAAA"> 118</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  23</td>
<td bgcolor="#777777">    7</td>
<td bgcolor="#AAAAAA">  55</td>
<td bgcolor="#777777">    W</td>
<td bgcolor="#AAAAAA">  87</td>
<td bgcolor="#777777">    w</td>
<td bgcolor="#AAAAAA"> 119</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  24</td>
<td bgcolor="#777777">    8</td>
<td bgcolor="#AAAAAA">  56</td>
<td bgcolor="#777777">    X</td>
<td bgcolor="#AAAAAA">  88</td>
<td bgcolor="#777777">    x</td>
<td bgcolor="#AAAAAA"> 120</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  25</td>
<td bgcolor="#777777">    9</td>
<td bgcolor="#AAAAAA">  57</td>
<td bgcolor="#777777">    Y</td>
<td bgcolor="#AAAAAA">  89</td>
<td bgcolor="#777777">    y</td>
<td bgcolor="#AAAAAA"> 121</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  26</td>
<td bgcolor="#777777">    :</td>
<td bgcolor="#AAAAAA">  58</td>
<td bgcolor="#777777">    Z</td>
<td bgcolor="#AAAAAA">  90</td>
<td bgcolor="#777777">    z</td>
<td bgcolor="#AAAAAA"> 122</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  27</td>
<td bgcolor="#777777">    ;</td>
<td bgcolor="#AAAAAA">  59</td>
<td bgcolor="#777777">    [</td>
<td bgcolor="#AAAAAA">  91</td>
<td bgcolor="#777777">    {</td>
<td bgcolor="#AAAAAA"> 123</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  28</td>
<td bgcolor="#777777">    <</td>
<td bgcolor="#AAAAAA">  60</td>
<td bgcolor="#777777">    \</td>
<td bgcolor="#AAAAAA">  92</td>
<td bgcolor="#777777">    |</td>
<td bgcolor="#AAAAAA"> 124</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  29</td>
<td bgcolor="#777777">    =</td>
<td bgcolor="#AAAAAA">  61</td>
<td bgcolor="#777777">    ]</td>
<td bgcolor="#AAAAAA">  93</td>
<td bgcolor="#777777">    }</td>
<td bgcolor="#AAAAAA"> 125</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  30</td>
<td bgcolor="#777777">    ></td>
<td bgcolor="#AAAAAA">  62</td>
<td bgcolor="#777777">    ^</td>
<td bgcolor="#AAAAAA">  94</td>
<td bgcolor="#777777">    ~</td>
<td bgcolor="#AAAAAA"> 126</td>
</tr>
<tr>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA">  31</td>
<td bgcolor="#777777">    ?</td>
<td bgcolor="#AAAAAA">  63</td>
<td bgcolor="#777777">    _</td>
<td bgcolor="#AAAAAA">  95</td>
<td bgcolor="#777777">   NA</td>
<td bgcolor="#AAAAAA"> 127</td>
</tr>
</table>
</body>
</html>

exercice 6  Copier-coller du fichier tableASCII.html
Table des caractères ASCII
NA 	0 		32 	@ 	64 	` 	96        On ne voit pas les cases comme
NA 	1 	! 	33 	A 	65 	a 	97        dans un navigateur malheureusement
NA 	2 	" 	34 	B 	66 	b 	98
NA 	3 	# 	35 	C 	67 	c 	99
NA 	4 	$ 	36 	D 	68 	d 	100
NA 	5 	% 	37 	E 	69 	e 	101
NA 	6 	& 	38 	F 	70 	f 	102
NA 	7 	' 	39 	G 	71 	g 	103
NA 	8 	( 	40 	H 	72 	h 	104
NA 	9 	) 	41 	I 	73 	i 	105
NA 	10 	* 	42 	J 	74 	j 	106
NA 	11 	+ 	43 	K 	75 	k 	107
NA 	12 	, 	44 	L 	76 	l 	108
NA 	13 	- 	45 	M 	77 	m 	109
NA 	14 	. 	46 	N 	78 	n 	110
NA 	15 	/ 	47 	O 	79 	o 	111
NA 	16 	0 	48 	P 	80 	p 	112
NA 	17 	1 	49 	Q 	81 	q 	113
NA 	18 	2 	50 	R 	82 	r 	114
NA 	19 	3 	51 	S 	83 	s 	115
NA 	20 	4 	52 	T 	84 	t 	116
NA 	21 	5 	53 	U 	85 	u 	117
NA 	22 	6 	54 	V 	86 	v 	118
NA 	23 	7 	55 	W 	87 	w 	119
NA 	24 	8 	56 	X 	88 	x 	120
NA 	25 	9 	57 	Y 	89 	y 	121
NA 	26 	: 	58 	Z 	90 	z 	122
NA 	27 	; 	59 	[ 	91 	{ 	123
NA 	28 	< 	60 	\ 	92 	| 	124
NA 	29 	= 	61 	] 	93 	} 	125
NA 	30 	> 	62 	^ 	94 	~ 	126
NA 	31 	? 	63 	_ 	95 	NA 	127