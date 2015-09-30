h=15;
r1=8;
[a,z]=meshgrid((0:.05:1)*2*pi,(0:.05:1)*h);
 x=r1*cos(a);
 y=r1*sin(a);
 surf(x,y,z,x*0)
 hold on
 h1=10;
R=5;
[a,z1]=meshgrid((0:.05:1)*2*pi,(0:.05:1)*h1);
r=R*(1-z1/h1);
 x1=cos(a).*r;
 y1=sin(a).*r;
 surf(x1,y1,z1,x*0)
 hold on