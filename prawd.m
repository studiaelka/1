clear all;
close all;

v = @(r)((4*pi.*(r.^3))./3); %objêtoœæ qli: 4/3 * pi * R^3
dokl = v(0.5) %to jest wartoœc dok³adna
pole = @(r)(4*pi.*(r.^2)); %a to bêdziemy ca³kowaæ, czyli powierzchniê qli: 4 * pi * R^2
%objêtoœæ = ca³ka (od 0 do R) z powierzchni. Taka ma³a dygresyjka.

N = 10;
for krok = 1:7 %iloœæ punktów losowania zmienia siê od 10 do 10000000
    N = 10.^krok;
punkty = 0.5 .* rand(1, N); %promieñ zmienia siê w akresie od 0 do 0.5
wart = pole(punkty);
obj(krok) = mean(wart) .* 0.5; %wartoœæ ca³ki = œrednia wartoœæ f-ji w przedziale * szerokoœæ przedzia³u

end;
delta = abs(dokl - obj)
semilogy(delta); %narysowanie b³êdu bezwzgêdnego wyznaczania wartoœci w zale¿noœci od wyk³adnika 10^krok.