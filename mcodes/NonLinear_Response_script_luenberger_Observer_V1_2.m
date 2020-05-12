M=1000;
m1=100;
m2=100;
l1=20;
l2=10;
g=9.81;
I = [0;0;10;0;10;0];
%{
Try the following sets of values values 
---> Initial COndition: I = [0;0;0;0;0;0]
---> I = [0;0;5;0;0;0]; t = 1:0.001:10;
---> I = [1;0;5;0;5;0]; t = 1:0.0001:10;
---> I = [1;0;5;0;5;0]; t = 1:0.001:10;
---> I = [0;0;5;0;10;0]; t = 1:0.001:10;
I = [1;1;5;0;5;0]; t = 1:0.0001:10;
%}
t = 0:0.0001:5;
[t,x] = ode45(@nlsys_solve,t,I);
plot(t,x,'linewidth',1);
title('response of the non-liear system');

%%Function Definition
function nlsys= nlsys_solve(~,x)
M=1000;
m1=100;
m2=100;
l1=20;
l2=10;
g=9.81;

A_f =[0 1 0 0 0 0;0 0 (-m1*g)/M 0 (-m2*g)/M 0;0 0 0 1 0 0;0 0 -(g/l1)*((m1+M)/M) 0 (-m2*g)/M*l1 0;0 0 0 0 0 1;0 0 (-m1*g)/M*l2 0 -(g/l2)*((m2+M)/M) 0];
B_f =[0;1/M;0;1/(M*l1);0;1/(M*l2)];
eigs(A_f);
C = [1,0,0,0,0,0];
%C = diag([1 1 1 1 1 1]);
%C1 = [1,0,0,0,0,0];
%D = [0;0;0;0;0;0];
D = [0];


Poles_L_Obs = [-28;-30;-10;-6;-2;-4];

L = place(A_f',C',Poles_L_Obs);

F = -L*x;

nlsys = zeros(6,1);

nlsys(1)= x(2);

nlsys(2)= ((F) - m1*g*sind(x(3))*cosd(x(3)) - m1*l1*x(4)^2*sind(x(3)) - m2*l2*x(6)^2*sind(x(5))  - m2*g*sind(x(5))*cosd(x(5)))/(M+m1*(sind(x(3)))^2+ m2*(sind(x(5)))^2);

nlsys(3)= x(4);

nlsys(4)= (((F) - m1*g*sind(x(3))*cosd(x(3)) - m1*l1*x(4)^2*sind(x(3)) - m2*l2*x(6)^2*sind(x(5))  - m2*g*sind(x(5))*cosd(x(5)))*cosd(x(3))/(M+m1*(sind(x(3)))^2+ m2*(sind(x(5)))^2)*l1)-((g*sind(x(3)))/l1);

nlsys(5)= x(6);

nlsys(6)= (((F) - m1*g*sind(x(3))*cosd(x(3)) - m1*l1*x(4)^2*sind(x(3)) - m2*l2*x(6)^2*sind(x(5))  - m2*g*sind(x(5))*cosd(x(5)))*cosd(x(5))/(M+m1*(sind(x(3)))^2+ m2*(sind(x(5)))^2)*l2)-((g*sind(x(5)))/l1);

end
