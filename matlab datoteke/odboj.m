 function s_vek_po_odboju = odboj(s_vektor, normala)
% s_vek_po_odboju je vektor smeri, v kateri kroglica leti po odboju od dane povrsine, 
% ce poznamo smerni vektor kroglice pred odbojem in normalo povrsine
% od katere se bo kroglica elasticno odbila (brez izgub, torej vhodni kot bo enak izhodnemu)
%
% VHODNI PODATKI:
% s_vektor = vektor smeri kroglice pred odbojem
% normala = normala povrsine, od katere se bo zogica odbila

% IDEJA:
% s_vektor razstavimo v smeri normale (na povrsino) in v smeri pravokotni
% na normalo

u = (dot(s_vektor, normala)/(norm(normala)^2)) * normala;
s_vek_po_odboju = s_vektor - 2 * u;

end