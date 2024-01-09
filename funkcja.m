function val = funkcja(fun,N,ln,a,b)

xw=linspace(a,b,N+1);
yw = fun(xw);

val=ln*yw'*(b-a);