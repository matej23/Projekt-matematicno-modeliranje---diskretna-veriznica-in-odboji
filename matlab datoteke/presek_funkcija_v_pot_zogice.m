function [tocka_preseka, cas_do_preseka, hitrost_ob_preseku] = presek_funkcija_v_pot_zogice(tabela_vozlisc_ver, v_0, s_0)
% Funkcija poisce podatke o potencialnem preseku s funkcijo podane diskretne veriznice in trajektorije
% zogice, ki je dolocena s zacetnim polozajem, zacetno hitrostjo in vplivom
% gravitacijskega pospeska
%
% VHODNI PODATKI:
% v_0 je zacetna hitrost zogice, s_0 pa njen zacetni polozaj
% tabela_vozlisc_ver doloca vozlisca diskretne veriznice, katere presek s
% trajektorijo telesa zelimo poiskati


nastavitve = optimset('TolFun', 1e-16);
g = 9.81; %gravitacijski pospesek 

V = @(x) funkcija_veriznica(tabela_vozlisc_ver, x);
tocka_V = @(x) [x; V(x)];

trajektorija_zogica = @(t) s_0 + v_0 * t - 1/2 * [0; g] * t^2;

hitrost_zogica = @(t) v_0 - [0; g] * t;

%T = [t1 t2]
presecisce= @(T) trajektorija_zogica(T(1)) - tocka_V(T(2));

[T_presek, ~, exitflag] = fsolve(presecisce, [100; (tabela_vozlisc_ver(1,1) + tabela_vozlisc_ver(1,end))/2], nastavitve);


% pazimo, ali sploh imamo presecisce
if exitflag < 0
    % nimamo presecisca
    tocka_preseka = [NaN; NaN];
    hitrost_ob_preseku = [NaN; NaN];
    cas_do_preseka = inf;
else
    % imamo presecisce
    tocka_preseka = trajektorija_zogica(T_presek(1));
    hitrost_ob_preseku = hitrost_zogica(T_presek(1));
    cas_do_preseka = T_presek(1);
end

end