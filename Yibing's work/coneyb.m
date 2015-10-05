h=10;
R=5;
[a,z]=meshgrid((0:.05:1)*2*pi,(0:.05:1)*h);
r=R*(h-z)/h
 x=cos(a).*r;
 y=sin(a).*r;
 surf(x,y,z,x*0)
 hold on
 
