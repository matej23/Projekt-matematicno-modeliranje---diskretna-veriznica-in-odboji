function [polozaj_konec, hitrost_konec, tocke_odboji, hitrosti_odboji, cas_do_odbojev] = n_odbojev_zogica(v_0, s_0, X, n)
% Funkcija izvede n korakov/odbojev zacetno podanega telesa/zogice s
% podano diskretno veriznico. 
% Rezultat so podatki o vseh odbojih, njihovih
% hitrostih in podatki o casu, potrebnem, da je do odboja prislo
%
% VHODNI PODATKI:
% s_0 je zacetni polozaj telesa, v_0 pa njegova zacetna hitrost
% X je tabela vozlisc, ki dolocajo diskretno veriznico
% n je stevilo odbojev

tocke_odboji = NaN(n, 2);
hitrosti_odboji = NaN(n, 2);
cas_do_odbojev = NaN(n, 1);
hitrost = v_0;
tocka = s_0;

% ali smo znotraj veriznice, da je sploh smiselno gledati odboje ?
if s_0(2) >= funkcija_veriznica(X, s_0(1))

    i = 0;
    while i < n
        [nova_tocka, nova_v, cas] = odboj_funkcija_disk_ver(hitrost, tocka, X);

        if (isnan(nova_tocka))
            % pazimo, da do odboja res pride
            break

        else 
            % do odboja pride, dolocimo nove zacetne pogoje za naslednji
            % iterativni korak
            tocka = nova_tocka;
            hitrost = nova_v;
            tocke_odboji(i+1, :) = tocka;
            cas_do_odbojev(i+1) = cas;
            hitrosti_odboji(i+1, :) = hitrost;
        end

        i = i + 1;
    
    end
end
    
    % po koncani while zanki imamo zadnjo znano hitrost in polozaj
    hitrost_konec = hitrost;
    polozaj_konec = tocka;
    
end