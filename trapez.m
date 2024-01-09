function T=trapez(fun,a,b,M)

x=linspace(a,b,M+1);
y = zeros(1,2*M+1);
y=feval(fun,x);
T=0;

for i=1:M
    T= T + y(i) + y(i+1);
end

T=(b-a)/2/M*T;
return