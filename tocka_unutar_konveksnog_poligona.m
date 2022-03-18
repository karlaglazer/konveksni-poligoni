n=input("Unesite broj tocaka prvog poligona: ")
p1=cell(n,2);

polje1=cell();
polje2=cell();

duljinaprvog=cell();
duljinadrugog=cell();

tocka1unutar=cell();
tocka2unutar=cell();


br2=1;
brojac=0;

unutar1=0;
ukupno1=0;
ukupno2=0;
crtanje=cell();

p1stranice=cell();
p2stranice=cell();

presjek2=cell();
tockepresjeka=cell();
tp=1;
postoji=0;
presjek=cell();

izvan=cell();

stranicazaprovjeru=cell();
provjera1=cell();

brojac1=1;
brojac2=1;
provjera2=cell();
brojac3=1;
izvan1=cell();
brojac4=1;
tocka3unutar=cell();
tockeunutar=cell();
novipoligon=cell();
poligonbr=1;
presjeci=0;
tuje=0;
for i = 1:n
  x1=input("Unesite x koordinatu tocke: ")
  y1=input("Unesite y koordinatu tocke: ")
  p1{i,1}=[x1];
  p1{i,2}=[y1];
  tocka=[x1 y1];
  polje1{i}=tocka;
  i++;
endfor
x1os=[p1{1:n,1} p1{1,1}];
y1os=[p1{1:n,2} p1{1,2}];

plot(x1os,y1os);
hold on

l=input("Unesite broj tocaka drugog poligona: ")
p2=cell(l,2);

for i = 1:l
  x2=input("Unesite x koordinatu tocke: ")
  y2=input("Unesite y koordinatu tocke: ")
  p2{i,1}=[x2];
  p2{i,2}=[y2];
  tocka2=[x2 y2];
  polje2{i}=tocka2;
  i++;
endfor
x2os=[p2{1:l,1} p2{1,1}];
y2os=[p2{1:l,2} p2{1,2}];

plot(x2os, y2os);
hold on

for i=1:n-1
  p1stranice{i}=createEdge([p1{i,1} p1{i,2}], [p1{i+1,1} p1{i+1,2}]);
  duljinaprvog{i}=sqrt(power((p1{i+1,1}-p1{i,1}),2)+power((p1{i+1,2}-p1{i,2}),2));
endfor
p1stranice{n}=createEdge([p1{n,1} p1{n,2}], [p1{1,1} p1{1,2}]);
duljinaprvog{n}=sqrt(power((p1{1,1}-p1{n,1}),2)+power((p1{1,2}-p1{n,2}),2));

for i=1:l-1
  p2stranice{i}=createEdge([p2{i,1} p2{i,2}], [p2{i+1,1} p2{i+1,2}]);
  duljinadrugog{i}=sqrt(power((p2{i+1,1}-p2{i,1}),2)+power((p2{i+1,2}-p2{i,2}),2));
endfor
p2stranice{l}=createEdge([p2{l,1} p2{l,2}], [p2{1,1} p2{1,2}]);
duljinadrugog{l}=sqrt(power((p2{1,1}-p2{l,1}),2)+power((p2{1,2}-p2{l,2}),2));

for i=1:n 
  for a=1:l
    pres=intersectEdges([p1stranice{i}],[p2stranice{a}]);
    nula=isnan(pres);
    if (nula==0)
      presjek{i,a}=pres;
      if (tp!=1)
        for j=1:tp-1
          if (presjek{i,a}==tockepresjeka{j,1})
            postoji=1;
          endif
        endfor
      endif
      if (postoji!=1)
        tockepresjeka{tp,1}=presjek{i,a};
        tp++;
      endif
    else
      presjek{i,a}=0;
    endif
    postoji=0;
  endfor
endfor

br1=1;
if(l==3) 
  for i=1:n
    for j=1:l
      provjera1{i,j}=sqrt(power((p2{j,1}-p1{i,1}),2)+power((p2{j,2}-p1{i,2}),2));
    endfor
  endfor
  for i=1:l
    for j=1:n
      for k=1:n
        if (provjera1{j,i}>duljinaprvog{1,k})
          izvan=1;
        endif
      endfor
    endfor
    if (izvan==0)
      tocka2unutar{br1}=[p2{i,1} p2{i,2}];
      brojac2++;
    else
      izvan=0;
    endif
  endfor
  
elseif(l!=3)
  for i=1:l
    tocka=polje2{1,i};
    for j=1:n
      provjera1{i,j}=createEdge([tocka], [polje1{1,j}]);
    endfor
    for j=1:n
      for k=1:n
        pres=intersectEdges([p1stranice{j}],[provjera1{i,k}]);
        nula=isnan(pres);
        if (nula==0)
          if (pres!=polje1{1,k})
            izvan{brojac1}=[polje2{i}];
            brojac1++;
          endif
        endif
      endfor
    endfor
  endfor  
  for i=1:l
    postoji=0;
    for j=1:brojac1-1
      if (polje2{i}==izvan{j})
        postoji++;
      endif
    endfor
    if (postoji==0)
      tocka2unutar{brojac2}=[polje2{i}];
      brojac2++;
    endif
  endfor  
endif

izvan3=0;
if (n==3)
  for i=1:l
    for j=1:n
      provjera2{i,j}=sqrt(power((p1{j,1}-p2{i,1}),2)+power((p1{j,2}-p2{i,2}),2));
    endfor
  endfor
  for i=1:n
    for j=1:l
      for k=1:l
        if (provjera2{j,i}>duljinadrugog{1,k})
          izvan3=1;
        endif
      endfor
    endfor
    if (izvan3==0)
      tocka1unutar{brojac2}=[p1{i,1} p1{i,2}];
      brojac4++;
    else
      izvan3=0;
    endif
  endfor
  
elseif (n!=3)
  for i=1:n
    tocka=polje1{1,i};
    for j=1:l
      provjera2{i,j}=createEdge([tocka], [polje2{1,j}]);
    endfor
    for j=1:l
      for k=1:l
        pres=intersectEdges([p2stranice{j}],[provjera2{i,k}]);
        nula=isnan(pres);
        if (nula==0)
          if (pres!=polje2{1,k})
            izvan1{brojac3}=[polje1{i}];
            brojac3++;
          endif
        endif
      endfor
    endfor
  endfor  
  for i=1:n
    postoji1=0;
    for j=1:brojac3-1
      if (polje1{i}==izvan1{j})
        postoji1++;
      endif
    endfor
    if (postoji1==0)
      tocka1unutar{brojac4}=[polje1{i}];
      brojac4++;
    endif
  endfor  
endif

for i=1:brojac2-1
  tockeunutar{i}=tocka2unutar{i};
endfor

j=1;
for i=brojac2:brojac2-1+brojac4-1 
  tockeunutar{i}=tocka1unutar{1,j};
  j++;
endfor

ukupno=(brojac2-1)+(brojac4-1);

for i=1:n
  for j =1:l
    if (presjek{i,j}!=0)
      for v=1:poligonbr-1
          if (novipoligon{v}==presjek{i,j})
            tuje=1;
          endif
      endfor
      if (tuje==0)
        novipoligon{poligonbr}=presjek{i,j};       
        presjeci++;
        poligonbr++;
      endif
      tuje=0;
        for k=1:ukupno
          if(polje1{i}==tockeunutar{k})
            for v=1:poligonbr-1
              if (novipoligon{v}==polje1{i})
                tuje=1;
              endif
            endfor
            if (tuje==0)
              novipoligon{poligonbr}=polje1{i};
              poligonbr++;
            endif
            tuje=0;
          endif
        endfor
        for k=1:ukupno
            if(polje2{j}==tockeunutar{k})
                for v=1:poligonbr-1
                  if(novipoligon{v}==polje2{j})
                    tuje=1;
                  endif
                endfor
                if (tuje==0)
                  novipoligon{poligonbr}=polje2{j};
                  poligonbr++;
                endif
                tuje=0;
            endif
        endfor
    endif 
  endfor
endfor

for i=1:poligonbr-1
  if (i<poligonbr-1)
    crtanje{i}=createEdge([novipoligon{i}],[novipoligon{i+1}]);
  else
    crtanje{i}=createEdge([novipoligon{i}],[novipoligon{1}]);
  endif
endfor
for i=1:poligonbr-1
  drawEdge(crtanje{i},'k','linewidth',1);
endfor
novipoligon