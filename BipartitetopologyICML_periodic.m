% 4 player bipartite , 2 action games. Code to obtain agents that play MP
% in a bipartite graph that exhibit periodic orbit
tic;
close all;
clear all;

format long


delta =0.005; %This denotes the error tolerance for the trajectory to be close to a given plane for the Poincare sections.
%Plane for poincare section a0x+b0y+c0z+d=0;
a0=1;
b0=1.5;
c0=1;
d0=-0.15; 

%Game parameters for the 4 player bipartite game.%V_L={1,3} and V_R={2,4}
%Consider 1 and 3 are row agents, 2 and 4 as column agents.
lambda1=1;
lambda2=1;
lambda3=1;
lambda4=1;
rowA=[1,-1;-1,1];
colA=-rowA';
A_12=lambda1*rowA;
A_13=0*rowA; %0 on the edge as bipartite
A_21=lambda2*colA;
A_32=lambda3*rowA;
A_31=0*rowA; %0 on the edge as bipartite
A_23=lambda2*colA;
A_34=lambda3*rowA;
A_43=lambda4*colA;
A_14=lambda1*rowA;
A_41=lambda4*colA;
A_24=0*colA; %0 on the edge as bipartite
A_42=0*colA; %0 on the edge as bipartite

%Create the Poincare section plane
XX=linspace(0,1,100);
YY=linspace(0,1,100);
[xx yy] = meshgrid(0:0.005:1); % Generate x and y data
zz = (1.0/c0)*(a0*xx+b0*yy+d0);

%Obtain the ode solution given the initial conditions y01,y02,y03 below. Increase T
%for more granularity.
T=15000;
y01=[0.3;0.1;0.7;0.6];
y02=[0.1;0.2;0.3;0.7];
y03=[0.2;0.4;0.7;0.6];
opts=odeset('reltol',1.e-8);
[t,y1] = ode45(@(t,y1) zs4player(t,y1,A_12,A_13,A_21,A_23,A_31,A_32,A_14,A_41,A_24,A_42,A_34,A_43),[0 T],y01,opts);
[t,y2] = ode45(@(t,y2) zs4player(t,y2,A_12,A_13,A_21,A_23,A_31,A_32,A_14,A_41,A_24,A_42,A_34,A_43),[0 T],y02,opts);
[t,y3] = ode45(@(t,y3) zs4player(t,y3,A_12,A_13,A_21,A_23,A_31,A_32,A_14,A_41,A_24,A_42,A_34,A_43),[0 T],y03,opts);
for k=1:length(y1)
    if abs(a0*y1(k,1)+b0*y1(k,2)-c0*y1(k,3)+d0) <= delta
        idx_list1(k)=1;
    else
        idx_list1(k)=0;
    end
end

for k=1:length(y2)
    if abs(a0*y2(k,1)+b0*y2(k,2)-c0*y2(k,3)+d0) <= delta
        idx_list2(k)=1;
    else
        idx_list2(k)=0;
    end
end

for k=1:length(y3)
    if abs(a0*y3(k,1)+b0*y3(k,2)-c0*y3(k,3)+d0) <= delta
        idx_list3(k)=1;
    else
        idx_list3(k)=0;
    end
end

 idx_new1=(idx_list1>=1);
 idx_new2=(idx_list2>=1);
 idx_new3=(idx_list3>=1);
%%Plot the system in the probability space-Only the Poincare Section
figure;
scatter3(y1(idx_new1,1),y1(idx_new1,2),y1(idx_new1,3), 'k.')
hold on;
scatter3(y2(idx_new2,1),y2(idx_new2,2),y2(idx_new2,3),1, 'r.')
hold on;
scatter3(y3(idx_new3,1),y3(idx_new3,2),y3(idx_new3,3), 'm.')
xlabel('p1-s1')
ylabel('p2-s1')
zlabel('p3-s1')
grid off

%%Plot the system in the probability space-The Full Trajectory
figure;
scatter3(y1(:,1),y1(:,2),y1(:,3), 'k.')
hold on;
scatter3(y2(:,1),y2(:,2),y2(:,3),1, 'r.')
hold on;
scatter3(y3(:,1),y3(:,2),y3(:,3), 'm.')
xlabel('p1-s1')
ylabel('p2-s1')
zlabel('p3-s1')
grid off
