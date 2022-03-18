

axis([-10 10 -10 10],"normal");
hold on
drawPoint([0 0],"k");
hold on
plot([ 0 0], [0 -10] , ":k")
hold on
plot([-10 0],[0 0], ":k")
hold on

n=input("Unesite broj tocaka: ")

c=cell(n,2);
p=cell(n,1);
stranica=cell(n,1);
povezivanje=cell(n,1);
presjek=cell(n,3);
for i=1:n
x=input("Unesite x koordinatu tocke: ")
y=input("Unesite y koordinatu tocke: ")
c{i,1}=[x];
c{i,2}=[y];
tocka=[x y];
p{i,1}=tocka;
i++;
endfor
%nacrta se poligon
xos=[c{1:n,1} c{1,1}];
yos=[c{1:n,2} c{1,2}];

plot(xos,yos)
hold on
%korisnik unese tocku koju zeli provjeriti
printf("Unesite tocku za koju zelite provjeriti nalazi li se u poligonu.\n")
tx=input("x koordinata: ")
ty=input("y koordinata:  ")
tockazaprovjeru=[tx ty];
drawPoint(tockazaprovjeru)
hold on
duljinastranicap=cell();
%povežemo sve stranice poligona u rubove(mislim da je to kao dužina, PROVJERI)
for i=1:n-1
  stranica{i}=createEdge([c{i,1} c{i,2}], [c{i+1,1} c{i+1,2}]);
  duljinastranicap{i}=sqrt(power((c{i+1,1}-c{i,1}),2)+power((c{i+1,2}-c{i,2}),2));
  i++;
endfor
stranica{n}=createEdge([c{n,1} c{n,2}], [c{1,1} c{1,2}]);
duljinastranicap{n}=sqrt(power((c{1,1}-c{n,1}),2)+power((c{1,2}-c{n,2}),2));
narubu=cell();
%provjerava jel to?ka na rubu
for i=1:n
  narubu{i}=isPointOnEdge([tockazaprovjeru],[stranica{i}]);
  i++;
endfor
br=0;
br1=0;
for i=1:n
  if (narubu{i}==1)
    br=1;
    br1++;
  i++;
  endif
endfor
if (br1==1)
  printf("Tocka je na stranici poligona.\n")
elseif (br1==2)
  printf("Tocka je vrh poligona.\n")
endif
%ako nije na rubu provjerava jel unutar ili izvan poligona
duljinastranicat=cell();
van=0;
if (br==0)
   
  if (n==3)
    for i=1:n
      duljinastranicat{i}=sqrt(power((c{i,1}-tx),2)+power((c{i,2}-ty),2));
    endfor
  for j=1:n
    for k=1:n
      if (duljinastranicat{j}>duljinastranicap{k})
        van=1;
      endif
    endfor
  endfor
  if (van==1)
    printf("Tocka je izvan poligona.\n")
  elseif (van==0)
    printf("Tocka je unutar poligona.\n")
  endif
  
  else 
  for i=1:n
    povezivanje{i}=createEdge([tockazaprovjeru], [c{i,1} c{i,2}]);
    i++;
  endfor
  %provjerava jel se sjeku stranice poligona sa onim nasim povezanim stranicama
  for i=1:n
    for a=1:n
      pres=intersectEdges([povezivanje{i}],[stranica{a}]);
      nula=isnan(pres);
      if (nula==0)
        presjek{i,a}=pres;
      else
        presjek{i,a}=0;
      endif
      a++;
    endfor
    i++;
  endfor

%ako je presjek stranice isti kao tocka poligona onda znaci da je unutra
  izvan=0;
  for i=1:n
    for a=1:n
      if (presjek{i,a}!=0)
        if (presjek{i,a}!=p{i})
          izvan=1;
          break;
        endif
      endif
      a++;
    endfor
    i++;
  endfor
  if (izvan==0)
    printf("Tocka je unutar poligona.\n")
  elseif (izvan==1)
    printf("Tocka je izvan poligona.\n")
  endif
  endif
endif