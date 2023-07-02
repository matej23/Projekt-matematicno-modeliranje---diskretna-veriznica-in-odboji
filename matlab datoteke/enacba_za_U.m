function U_u = enacba_za_U(u, zac, L, vsote_mi, l)
% enacba_za_U nastavi (eno) nelinearno enacbo za spremenljivko u iz standardnega
% postopka resevanja problema (splosne) diskretne veriznice
% Rezultat je U_u, ki je ovrednotena funkcija U, v parametru u
% 
% VHODNI PODATKI (zadoscajo pogojem za liho simetricno veriznico):
% u = neznana spremenljivka, v njen bomo ovrednotili U, ter dobili U_u
% zac = [x_0 x_n+1;y_0 y_n+1], kjer sta (x_0,y_0) in (x_n+1, y_n+1) obesisci. 
% L je vrstica, ki doloca dolzine palic
% vsote_mi je vrstica kumulativnih vsot
%
% Postopamo na enak nacin kot pri splosni diskretni veriznici, le da
% upostevamo se dodaten pogoj, ki nam omogoca prehod na eno spremenljivko u
% (v lahko izrazimo kot funkcijo u-ja in vstavimo, ter resujemo le eno
% nelinearno enacbo)

xi = L./sqrt(1+(u*(vsote_mi(l+1) - vsote_mi)).^2);

U_u = sum(xi)-(zac(1,2)-zac(1,1));

end