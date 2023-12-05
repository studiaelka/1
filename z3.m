clc;clearvars;

%f1=@(x)(sin(x).*cos(x));
f1=@(x) x.^5 + x.^4 + 5*x.^3 - 4*x.^2

przedzial1=linspace(-pi,3*pi,301);

for i=3:13
        %interpolacja
        przedzial1=linspace(-pi,3*pi,301);
    x1_punkty=linspace(-pi,3*pi,15); %węzły
    dok1_wart=f1(x1_punkty);
    % INTERPOLACJA POJEDYNCZYM WIELOMIANEM
    p1=polyfit(x1_punkty,dok1_wart,i);
    val1=polyval(p1,przedzial1);
    yy=f1(przedzial1);

    bladi(i-2)= norm(val1-yy);

    %aproksymacja
    x_punkty=linspace(-pi,3*pi,15);
    dok_wart=f1(x_punkty);

    p=polyfit(x_punkty,dok_wart,i);
    %Wartosci
    aproksymowana=f1(przedzial1);
    val=polyval(p,przedzial1);

    blada(i-2)= norm(val-aproksymowana);

end
figure(1)
semilogy(bladi)
figure(2)
semilogy(blada)
