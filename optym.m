clear all;
close all;

f = @(x)(x .* x .* cos(x)); %funkcja dana
fprim = @(x)((2 .* x .* cos(x)) - (x .* x .* sin(x))); %funkcja zró¿niczkowana metod¹ MonteKartka

x = pi; %wokó³ tego punktu ró¿niczkujemy
delta_x = logspace(0, -13, 14); %10^0, 10^-1, 10^-2 ... 10^-13 czyli kolejne granice ilorazu ró¿nicowego

pochodna = (f(x + delta_x) - f(x)) ./ delta_x; 
dokl = fprim(x); %wartosæ dok³adna pochodnej

err = abs(pochodna - dokl); %b³¹d bezwzglêdny
semilogy(err) 

[a, optymal] = min(err);
optymal
