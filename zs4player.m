function [dydt] = zs4player(t,y,A_12,A_13,A_21,A_23,A_31,A_32,A_14,A_41,A_24,A_42,A_34,A_43)
%UNTITLED Summary of this function goes here
%   4 player two strategy game on a square. The evolution is explicitly written for
%   strategy 1 only. A is the payoff matrix 
dydt = zeros(4,1);
y_p1=y(1);
y_p2=y(2);
y_p3=y(3);
y_p4=y(4);
v_p1=A_12*[y_p2;1-y_p2]+A_13*[y_p3;1-y_p3]+A_14*[y_p4;1-y_p4];
v_p2=A_21*[y_p1;1-y_p1]+A_23*[y_p3;1-y_p3]+A_24*[y_p4;1-y_p4];
v_p3=A_31*[y_p1;1-y_p1]+A_32*[y_p2;1-y_p2]+A_34*[y_p4;1-y_p4];
v_p4=A_41*[y_p1;1-y_p1]+A_42*[y_p2;1-y_p2]+A_43*[y_p3;1-y_p3];

dydt(1) = y_p1*(1-y_p1)*(v_p1(1)-v_p1(2));
dydt(2) = y_p2*(1-y_p2)*(v_p2(1)-v_p2(2));
dydt(3)=  y_p3*(1-y_p3)*(v_p3(1)-v_p3(2));
dydt(4)=  y_p4*(1-y_p4)*(v_p4(1)-v_p4(2));
end
