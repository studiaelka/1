function T = simpson(fun,a,b,M)

x = linspace(a,b,2*M+1);
y = zeros(1,2*M+1);
y = feval(fun,x);
T = 0;
for i = 1:M
  T = T + y(2*i-1) + 4*y(2*i) + y(2*i+1);
end
T = (b - a)/6/M*T;

return 