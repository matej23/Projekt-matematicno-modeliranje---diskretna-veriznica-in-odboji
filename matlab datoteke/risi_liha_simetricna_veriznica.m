function risi_liha_simetricna_veriznica(zac, L, M)
% Funkcija narise simetricno diskretno veriznico z liho mnogo clenki 
% 
% VHODNI PODATKI:
% zac : podatki o vpenjaliscih veriznice
% L : zaporedno podane dolzine clenkov
% M : zaporedno podane mase clenkov

% zacetni priblizek za u (u0)
u0 = -2;
X = sim_disk_ver_liho_clenkov(u0, zac, L, M);

grid on
axis([zac(1,1) zac(1,2) ceil(min(X(2,:))-1) inf])

hold on
plot(X(1,:),X(2,:),'LineWidth',3, 'Color', "#0072BD")
plot(X(1,:),X(2,:),'o','MarkerSize', 5,'LineWidth', 5, 'Color', "magenta");
hold off

end