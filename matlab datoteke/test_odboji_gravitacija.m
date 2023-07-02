zac = [1 9;0 0];

L = [2 1 2 1 2 1 2 1 2];

M = [2 1 2 1 2 1 2 1 2];

tabela_vozlisc_ver = sim_disk_ver_liho_clenkov(-1, zac, L, M);

zac_t = [6.7; -1];
vec = [1; 1];

[polozaj_konec, hitrost_konec, tocke_odboji, hitrosti_odboji, cas_do_odbojev] = n_odbojev_zogica(vec, zac_t, tabela_vozlisc_ver, 20);
risi_odboji_gravitacija(zac, L, M, zac_t, vec, 20)
