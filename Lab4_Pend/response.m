%p = sys_params;
%q = (p.M+p.m)*(p.I+p.m*p.l^2)-(p.m*p.l)^2;

M = 2.4;
m = 0.23;
b = 0.05;
I = 0.099;
g = 9.81;
l = 0.362;

q = (M+m)*(I+m*l^2)-(m*l)^2;
s = tf('s');
P_cart = (((I+m*l^2)/q)*s^2 - (m*g*l/q))/(s^4 + (b*(I + m*l^2))*s^3/q - ((M + m)*m*g*l)*s^2/q - b*m*g*l*s/q);
P_pend = (m*l*s/q)/(s^3 + (b*(I + m*l^2))*s^2/q - ((M + m)*m*g*l)*s/q - b*m*g*l/q);
sys_tf = [P_cart ; P_pend];

inputs = {'u'};
outputs = {'x'; 'phi'};

set(sys_tf,'InputName',inputs)
set(sys_tf,'OutputName',outputs)

figure;
t=0:0.01:1;
impulse(sys_tf,t);  
title('Open-Loop Impulse Response')

figure;
t = 0:0.05:10;
u = ones(size(t));
[y,t] = lsim(sys_tf,u,t);
plot(t,y)
title('Open-Loop Step Response')
axis([0 3 0 50])
legend('x','phi')
step_info = lsiminfo(y,t);
cart_info = step_info(1)
pend_info = step_info(2)
