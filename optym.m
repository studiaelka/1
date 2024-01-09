clear all;
close all;

f = @(x)(x .* x .* cos(x)); %funkcja dana
fprim = @(x)((2 .* x .* cos(x)) - (x .* x .* sin(x))); %funkcja zr�niczkowana metod� MonteKartka

x = pi; %wok� tego punktu r�niczkujemy
delta_x = logspace(0, -13, 14); %10^0, 10^-1, 10^-2 ... 10^-13 czyli kolejne granice ilorazu r�nicowego

pochodna = (f(x + delta_x) - f(x)) ./ delta_x; 
dokl = fprim(x); %wartos� dok�adna pochodnej

err = abs(pochodna - dokl); %b��d bezwzgl�dny
semilogy(err) 

[a, optymal] = min(err);
optymal
