function n = normala_na_clenek(x1, y1, x2, y2)
% Rezultat je n, smerni vektor normale na clenek diskretne veriznice, ki ga
% dolocajo vhodni podatki
%
% VHODNI PODATKI:
% (x1, y1) in (x2, y2) sta tocki na clenku diskretne veriznice, 
% katerega normalo zelimo poiskati
%
% OPOMBA: iscemo smerni vektor normale, ki bo imel nenegativno y koordinato,
% oziroma gledano iz graficnega vidika: tisto normalo, ki kaze "v veriznico"

dx = x2 -  x1;
dy = y2 - y1;

if (dx>=0)
    n = [-dy; dx];
else
    n = [dy; -dx];
end
  
end
