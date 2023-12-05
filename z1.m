% FUNKCJE------------
clear all;
clc;
f1=@(x)(sin(x).*cos(x));
f2=@(x)(exp(x));
%----------------------
N=14;
%% Zadanie 1a funkcja 
przedzial1=linspace(-pi,3*pi,301);
x1_punkty=linspace(-pi,3*pi,15); %węzły
dok1_wart=f1(x1_punkty);
% INTERPOLACJA POJEDYNCZYM WIELOMIANEM
p1=polyfit(x1_punkty,dok1_wart,14);
val1=polyval(p1,przedzial1);
%------------------------------
figure(1)
plot(x1_punkty,dok1_wart,'ok');
hold on;
plot(przedzial1,f1(przedzial1),'b');
plot(przedzial1,val1,'r');

blad=norm(dok1_wart'-val1,Inf)
%% Zadanie 1a funkcja b
przedzial2=linspace(0,4,301);
x2_punkty=linspace(0,4,15);
dok2_wart=f2(x2_punkty);
% INTERPOLACJA POJEDYNCZYM WIELOMIANEM
p2=polyfit(x2_punkty,dok2_wart,14);
val2=polyval(p2,przedzial2);
%------------------------------
figure(2)
plot(x2_punkty,dok2_wart,'ok');
hold on;
plot(przedzial2,f2(przedzial2),'b');
plot(przedzial2,val2,'r');

%% Zadanie 1b funkcja a
figure(3)
funkcja_sklejana1=spline(x1_punkty,dok1_wart,przedzial1);
plot(przedzial1,funkcja_sklejana1,'g');
hold on;
plot(przedzial1,f1(przedzial1),'b');
plot(x1_punkty,dok1_wart,'ok');
%% Zadanie 1b funkcja b
figure(4)
funkcja_sklejana2=spline(x2_punkty,dok2_wart,przedzial2);
plot(przedzial2,funkcja_sklejana2,'g');
hold on;
plot(przedzial2,f2(przedzial2),'b');
plot(x2_punkty,dok2_wart,'ok');

%% Zadanie 1c funkcja a,b
for j=0:14
    xN1(j+1)=0.5*(4*pi)*cos((2*j+1)*pi/30)+0.5*(2*pi);
    xN2(j+1)=0.5*(4)*cos((2*j+1)*pi/30)+0.5*(4);
end
    dok_wart3=f1(xN1);
    dok_wart4=f2(xN2);
    
    p3=polyfit(xN1,dok_wart3,14);
    p4=polyfit(xN2,dok_wart4,14);
    
    val3=polyval(p3,przedzial1);
    val4=polyval(p4,przedzial2);
    
    
    figure(5)
    plot(xN1,dok_wart3,'ok');
    hold on;
    plot(przedzial1,f1(przedzial1),'b');
    plot(przedzial1,val3,'r');
    
    
    figure(6)
    plot(xN2,dok_wart4,'ok');
    hold on;
    plot(przedzial2,f2(przedzial2),'b');
    plot(przedzial2,val4,'r');
    title("funkcja b Czybyszew");
    figure(6);
    semilogy(blad,'go');
    title("blad");
    
    