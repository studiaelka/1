clear all;
close all;

v = @(r)((4*pi.*(r.^3))./3); %obj�to�� qli: 4/3 * pi * R^3
dokl = v(0.5) %to jest warto�c dok�adna
pole = @(r)(4*pi.*(r.^2)); %a to b�dziemy ca�kowa�, czyli powierzchni� qli: 4 * pi * R^2
%obj�to�� = ca�ka (od 0 do R) z powierzchni. Taka ma�a dygresyjka.

N = 10;
for krok = 1:7 %ilo�� punkt�w losowania zmienia si� od 10 do 10000000
    N = 10.^krok;
punkty = 0.5 .* rand(1, N); %promie� zmienia si� w akresie od 0 do 0.5
wart = pole(punkty);
obj(krok) = mean(wart) .* 0.5; %warto�� ca�ki = �rednia warto�� f-ji w przedziale * szeroko�� przedzia�u

end;
delta = abs(dokl - obj)
semilogy(delta); %narysowanie b��du bezwzg�dnego wyznaczania warto�ci w zale�no�ci od wyk�adnika 10^krok.