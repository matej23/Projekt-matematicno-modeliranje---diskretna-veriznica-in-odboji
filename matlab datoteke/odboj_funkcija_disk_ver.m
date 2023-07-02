function [tocka_odboja, hitrost_po_odboju, cas_do_naslednjega_trka] = odboj_funkcija_disk_ver(v_0, s_0, tabela_vozlisc_ver)
% Funkcija poracuna naslednji odboj (ce obstaja) zogice z dano diskretno
% veriznico, ter vrne podatke o hitrosti po odboju, cas do tega trka, ter
% tocko trka oziroma odboja
%
% VHODNI PODATKI:
% v_0 je zacetna hitrost zogice/telesa
% s_0 je zacetni polozaj zogice/telesa
% tabela_vozlisc_ver doloca veriznico od katere se zelimo odbiti

[tocka_preseka, cas_do_preseka, hitrost_ob_preseku] = presek_funkcija_v_pot_zogice(tabela_vozlisc_ver, v_0, s_0);


if (tocka_preseka(1) >= tabela_vozlisc_ver(1,1)) && (tocka_preseka(1) <= tabela_vozlisc_ver(1, end)) && tocka_preseka(2) <= tabela_vozlisc_ver(2, 1)
    % imamo odboj, znotraj veriznice
    x_vozlisca = tabela_vozlisc_ver(1, :);
    y_vozlisca = tabela_vozlisc_ver(2, :);
    indeks = find(x_vozlisca == min(x_vozlisca(x_vozlisca>tocka_preseka(1))));
    normala_clenek = normala_na_clenek(x_vozlisca(indeks-1), y_vozlisca(indeks-1), x_vozlisca(indeks), y_vozlisca(indeks));

    hitrost_po_odboju = odboj(hitrost_ob_preseku, normala_clenek);
    tocka_odboja = tocka_preseka;
    cas_do_naslednjega_trka = cas_do_preseka;

else
    % nimamo odboja
    tocka_odboja = NaN;
    hitrost_po_odboju = NaN;
    cas_do_naslednjega_trka = inf;

end

end