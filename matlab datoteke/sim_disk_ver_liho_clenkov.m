function tabela_vozlisc = sim_disk_ver_liho_clenkov(u0, zac, L, M)
% Rezultat je tabela_vozlisc je 2x(n+2) tabela koordinat vozlisc, kjer
% prva vrstica doloca abscise, druga ordinate iskanih tock.
%
% VHODNI PODATKI:
% zac = [x_0 x_n+1;y_0 y_n+1], kjer sta (x_0,y_0) in (x_n+1, y_n+1) obesisci. 
% L je vrstica, ki doloca dolzine palic
% M je vrstica, ki doloca mase palic
% u0 je zacetni priblizek za resevanje nelinearne enacbe
%
% OPOMBA: prepricati se moramo, ali vhodni/zacetni podatki zadoscajo
% pogojem za simetricno diskretno veriznico z liho clenki, t.j. veljati mora:
% 1) n+1 = 2*l + 1 (za nek l) <=> n+1 % 2 = 1
% 2) y_0 = y_n+1
% 3) L(1) = L(n+1), L(2) = L(n), ..., L(i) = L(n+2-i)

y_zacetek = zac(2,1); % = y_0
y_konec = zac(2,2); % = y_n+1
parnost = mod(length(L), 2); % parnost stevila clenkov, zelimo, da jih je liho

% Prepricamo se, da je vsem pogojem z opombe zadosceno, ce ne vrnemo ustrezen "error"
if ~(y_zacetek == y_konec)
   error("Vnešeni podatki ne zadoščajo pogojem za simetrično diskretno verižnico! \n%s", ...
       "Veljati mora y_0 = y_n+1 !")
end

if (parnost == 0)
   error("Vnešeni podatki ne zadoščajo pogojem za simetrično diskretno verižnico! \n%s", ...
       "Vnesli ste vnesli sodo število členkov!")
end

l = (length(L) - 1)/2; %ce pridemo do sem, ze vemo, da imamo liho clenkov
prva_polovica = L(1:l); %prva polovica palic
druga_polovica = L(length(L):-1:l+2); %"obrnjena" druga polovica palic

if ~isequal(prva_polovica, druga_polovica)
   error("Vnešeni podatki ne zadoščajo pogojem za simetrično diskretno verižnico! \n%s", ...
       "Dolžine palic morajo biti določene simetrično!")
end

% Sedaj lahko nadaljujemo, saj vemo, da je vsem zahtevam za simetricno diskretno veriznico zadosceno 
% Postopamo podobno, kot pri "splosni" diskretni verižnici

mi = (1/2)*(M(1:end-1)+M(2:end)); %tako kot pri splosni diskretni veriznici
vsote_mi = [0,cumsum(mi)]; %prvi clen je 0, da lahko kasneje ustrezno mnozimo po koordinatah

% Ker vemo, da imamo simetricno veriznico z liho clenki, lahko prevedemo
% problem na resevanje ene nelinearne enacbe U, ki je odvisna od u, kot je to opisano v (*****)

U = @(u) enacba_za_U(u, zac, L, vsote_mi, l);

% Nelinearno enacbo zelimo resiti, za resevanje uporabimo fsolve
options = optimoptions('fsolve','Display','none');
resitev_u = fsolve(U, u0, options);

% Ko dobimo resitev, lahko poracunamo vse koordinate vozlisc, tako da vstavimo v enacbe 
% Od tu naprej postopamo tako kot pri "splosni" diskretni veriznici, saj
% smo poracunali u (in posledicno v iz splosne diskretne veriznice)

xi = L./sqrt(1+(resitev_u*(vsote_mi(l+1) - vsote_mi)).^2);
eta = xi.*(resitev_u*(vsote_mi(l+1) - vsote_mi));

% Dokoncno izrazimo in zapisemo v tabelo
tabela_vozlisc =[zac(1,1)+cumsum(xi); zac(2,1)+cumsum(eta)];
tabela_vozlisc= [zac(:,1) tabela_vozlisc];

end