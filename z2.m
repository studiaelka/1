clear all;
clc;
clearvars;

f1=@(x)(sin(x).*cos(x));
f2=@(x)(exp(x));

przedzial=linspace(-pi,3*pi,301);
przedzial2=linspace(0,4,301);

for i=3:13
   
    x_punkty=linspace(-pi,3*pi,15);
    dok_wart=f1(x_punkty);
    
    p=polyfit(x_punkty,dok_wart,i);
    %Wartosci
    aproksymowana=f1(przedzial);
    val=polyval(p,przedzial);
    
    
      x_punkty2=linspace(0,4,15);
    dok_wart2=f2(x_punkty2);

    p2=polyfit(x_punkty2,dok_wart2,i);
    %Wartosci
    aproksymowana2=f2(przedzial2);
    val2=polyval(p2,przedzial2);
    
    % Rysunek 1
    figure(1)
    subplot(3,4,i-2);
    plot(przedzial,aproksymowana,'b');
    hold on;
    plot(przedzial,val,'r');
    plot(x_punkty,dok_wart,'ok');
    title(i);
    
    %Rysunek 2
     figure(2)
    subplot(3,4,i-2);
    plot(przedzial2,aproksymowana2,'b');
    hold on;
    plot(przedzial2,val2,'r');
    plot(x_punkty2,dok_wart2,'ok');
    title(i);
    
    blad1(i)=norm(abs(aproksymowana)-abs(val));
end
figure(3)
semilogy(blad1);