%% making a cylinder!
%{
Rotate a cylinder by angle a
RotX=[1 0 0;0 cos(a) -sin(a);0 sin(a) cos(a)]
RotY=[cos(a) 0 sin(a);0 1 0;-sin(a) 0 cos(a)]
RotZ=[cos(a) -sin(a) 0;sin(a) cos(a) 0;0 0 1]
%}

%{
Waved cylinder 
t = 0:pi/10:2*pi;
figure
[X,Y,Z] = cylinder(2+cos(t));
surf(X,Y,Z)
%}

%{
%make a cylinder height 5 radius 1
[x,y,z]=cylinder(1,100);
z(2,:)=5;
%in z direction
%surf(x,y,z)
%in x direction
surf(z,x,y)
%}

r_cyl_inner = 1;
r_cyl_outer = 1.2;
segments = 100; %determines "precision" "smoothness" of cylinder
[x_cyl_inner,y_cyl_inner,z_cyl_inner]=cylinder(r_cyl_inner, segments);
[x_cyl_outer,y_cyl_outer,z_cyl_outer]=cylinder(r_cyl_outer, segments);
z_cyl_inner(1,:)=-100;
z_cyl_inner(2,:)=100;
z_cyl_outer=z_cyl_inner;
set(surf(x_cyl_inner,y_cyl_inner,z_cyl_inner,'FaceColor', [0.5,0,0]),'FaceAlpha',0.75,'edgealpha', 0)
% surf(z,x,y) for cylinder along x axis
% to plot outter surface of vessel
% hold on
% set(surf(x_cyl_outer,y_cyl_outer,z_cyl_outer,'FaceColor', [0.5,0,0]),'FaceAlpha',0.35,'edgealpha', 0)
%% making a spiral
 t_spiral = -8*pi:pi/50:8*pi;
 hold on %plot spiral on same figure as vessel
 plot3(sin(t_spiral),cos(t_spiral),4*t_spiral, 'b');

%% making a slanted plane from equation
u_plane=linspace(-2,2);
v_plane=linspace(-2,2);
[x_plane,y_plane]=meshgrid(u_plane,v_plane);
z_plane = -(200-100.*y_plane-100.*x_plane)/4;
surf(x_plane,y_plane,z_plane, 'FaceColor', [0,0.8,0],'FaceAlpha',0.2,'edgealpha', 0.1)

%% plotting chopped cylinder, from http://www.mathworks.com/matlabcentral/newsreader/view_thread/40256
r=10; % cylinder radius
sect=40; % number of sectors of cylinder base
% Plane equation: A*(x-x0)+B*(y-y0)+C*(z-z0)=0 
vd=[1 1 1]; % vd=[A B C];
v0=[0,0,20]; % v0=[x0 y0 z0];
fi=linspace(-pi,pi,sect);
x=r*cos(fi);
y=r*sin(fi);
z=1/vd(3)*(-vd(1)*(x-v0(1))-vd(2)*(y-v0(2)))+v0(3)
zM=max(z)
zm=min(z)
if zM*zm >= 0
   zb=zeros(1,sect);
else
   zb=zm*ones(1,sect);
end
zb
X=[x;x];
Y=[y;y];
Z=[zb;z];
surf(X,Y,Z)
shading interp 
colormap([.8 .8 .8])
camlight('right','local')


