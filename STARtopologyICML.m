% 4-STAR Topolgy with two actions.
tic;
close all;
clear all;
format long


%Assume 1 is center agent and there are totally 4 agents and the matching
%pennies game is being played.
lambda=0;
A_12=[1,-1;-1,1];
A_13=[1,-1;-1,1];
A_21=-[1,-1;-1,1]';
A_23=lambda*[1,-1;-1,1];
A_31=(-[1,-1;-1,1]');
A_32=-lambda*[1,-1;-1,1]';
A_34=lambda*A_12;
A_43=lambda*A_21;
A_14=A_12;
A_41=A_21;
A_24=lambda*A_13;
A_42=lambda*A_31;


%Obtain the ode solution given the initial condition y0 below. Increase T
%for more granularity.
T=5000;
y0=[0.3;0.4;0.9;0.2];
opts=odeset('reltol',1.e-8);
[t,y] = ode45(@(t,y) zs4player(t,y,A_12,A_13,A_21,A_23,A_31,A_32,A_14,A_41,A_24,A_42,A_34,A_43),[0 T],y0,opts);
[r,c]=size(y);
%%Plot the system in the probability space for agents 2,3 and 4, for a
%%cooperative orbit.
figure;
plot3(y(:,2),y(:,3),y(:,4),'r')
xlabel('p2-s1')
ylabel('p3-s1')
zlabel('p4-s1')
grid on
%%Plot the system in the probability space for agents 1,3 and 4, for a
%%periodic orbit. Include the center agent and any other pair of agents to
%%obtain a periodic orbit.
figure;
plot3(y(:,1),y(:,3),y(:,4),'r')
xlabel('p1-s1')
ylabel('p3-s1')
zlabel('p4-s1')
grid on

toc