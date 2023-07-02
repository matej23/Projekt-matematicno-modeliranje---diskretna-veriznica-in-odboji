function V = funkcija_veriznica(tabela_vozlisc_ver, x)
% Funkcija omogoca ekspliciten zapis diskretne veriznice z eno
% spremenljivko (kot graf te eksplicitno podane funkcije)
%
% VHODNI PODATKI:
% tabela_vozlisc_ver doloca tocke diskretne veriznice
% x doloca vrednost ob kateri bi radi ovrednotili V (torej dobili visino
% veriznice) PAZI!, ce x ni na intervalu veriznice, vrne inf

x_vozlisca = tabela_vozlisc_ver(1, :);

if x >= x_vozlisca(1) && x<= x_vozlisca(end)

    indeks = find(x_vozlisca == min(x_vozlisca(x_vozlisca>=x)));

    x1 = x_vozlisca(indeks - 1);
    x2 = x_vozlisca(indeks);
    y1 = tabela_vozlisc_ver(2, indeks-1);
    y2 = tabela_vozlisc_ver(2, indeks);

    dy = y2 - y1;
    dx = x2- x1;

    k = dy/dx;

    % y = k*x + n 
    n = y2 - k*x2;
    V =  k * x + n;

else
    V = inf;
end

end