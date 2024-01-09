close all;
clear;
clc;

ln1 = [1 4 1]/6;         % Simpson
ln2 = [1 1]/2;           % Trapez

N1=2; % Simpson
N2=1; % Trapez

fun=@(x)(sin(pi*x));
dokladny = (1/pi)*(1 - cos(pi^2/2)); % dokladna wartosc calki obliczona rêcznie

a=0;
b=pi/2;

M = [2 4 8 16];

for p=M
    xp=linspace(a,b,p+1);  % dzielenie na M przedzia³ów
    I1=0;                  % wynik dla kwadratury Simpsona
    I2=0;                  % wynik dla kwadratury trapezow
    for k=2:length(xp)
        I1 =I1+funkcja(fun,N1,ln1,xp(k-1),xp(k)); %obliczanie z³o¿onej kwadratury
        I2 =I2+funkcja(fun,N2,ln2,xp(k-1),xp(k));
    end
    errs(p)=abs(I1-dokladny);
    errm(p)=abs(I2-dokladny);
end

figure(4)
grid on
semilogy(M,errs(M),'-ok','LineWidth',2)
xlabel('Liczba podzialow M')
ylabel('Blad przyblizenia')
title('Zlozona Kwadratura Simpsona')
I1
I2
figure(5)
grid on
semilogy(M,errm(M),'-ok','LineWidth',2)
xlabel('Liczba podzialow M')
ylabel('Blad przyblizenia')
title('Zlozona Kwadratura Trapezow')

