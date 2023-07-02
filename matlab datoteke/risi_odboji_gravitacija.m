function risi_odboji_gravitacija(zac, L, M, s_0, v_0, stevilo_odbojev)
% Funkcija postopoma/animacijsko narise zahtevano stevilo odbojev zogice na
% diskretni veriznici (ce do odbojev pride, potencialno se postopek
% izrisave predhodno zakljuci)
%
% VHODNI PODATKI:
% s_0 in v_0 dolocata zacetni polozaj in zacetno hitrost zogice/telesa
% zac, L, M so podatki, ki dolocajo diskretno veriznico od katere se bo
% zogica odbijala, stevilo_odbojev pa zahtevano stevilo odbojev 
%
% OPOMBA: odboji zogice so oznaceni z rdeco, zadnji polozaj zogice (torej
% polozaj nekaj trenutkov po zakljuckom odbijanja - bodisi zaradi stevila
% odboja ali odboja izven veriznice) pa je oznacen z modro

hold on
u0 = -2;
g = 9.81;
X = sim_disk_ver_liho_clenkov(u0, zac, L, M);

[polozaj_konec, hitrost_konec, tocke_odboji, hitrosti_odboji, cas_do_odbojev] = n_odbojev_zogica(v_0, s_0, X, stevilo_odbojev);
pot_zogice = [s_0'; tocke_odboji];
hitrost_zogice = [v_0'; hitrosti_odboji];

m = size(pot_zogice);
m1 = m(1);

grid on
axis([min([pot_zogice(:, 1); zac(1,1)]) max([pot_zogice(:, 1); zac(1,2)]) ceil(min(X(2,:))-1) inf])

plot(X(1,:),X(2,:),'LineWidth',3, 'Color', "#0072BD")
plot(X(1,:),X(2,:),'o','MarkerSize', 5,'LineWidth', 5, 'Color', "magenta");

j = 1;
while ~isnan(pot_zogice(j, 1)) && j < m1
    if j == 1
        plot(pot_zogice(j,1), pot_zogice(j, 2), 'o', 'MarkerSize', 4, 'LineWidth', 4, 'Color', "red")
    else
        plot(pot_zogice(j,1), pot_zogice(j, 2), 'o', 'MarkerSize', 2, 'LineWidth', 4, 'Color', "red")
    end

    sx = pot_zogice(j, 1);
    sy = pot_zogice(j, 2);
    vx = hitrost_zogice(j, 1);
    vy = hitrost_zogice(j, 2);
    
    t = linspace(0, cas_do_odbojev(j), int16(cas_do_odbojev(j) * 100)) ;
    x = sx + vx * t ;
    y = sy + vy * t - 1/2 * g * t.^2;

    for r=1:int16(cas_do_odbojev(j) * 100)
        plot(x(1:r),y(1:r), 'Color', "#77AC30")
        drawnow
    end

    j = j + 1;

end

plot(pot_zogice(j,1), pot_zogice(j, 2), 'o', 'MarkerSize', 2, 'LineWidth', 4, 'Color', "red")

N = 10;
tt = linspace(0, 1/25, N) ;
xx = polozaj_konec(1) + hitrost_konec(1) * tt ;
yy = polozaj_konec(2) + hitrost_konec(2) * tt - 1/2 * g * tt.^2;

for rr=1:N
    plot(xx(1:rr),yy(1:rr), 'Color', "#77AC30")
    drawnow
end

plot(polozaj_konec(1) + hitrost_konec(1) * 1/25, ...
    polozaj_konec(2) + hitrost_konec(2) * 1/25 - 1/2 * g * (1/25)^2, ...
    'o', 'MarkerSize', 3, 'LineWidth', 3, 'Color', "#4DBEEE")
drawnow
  
hold off 

end