%% Open-Loop Init
constants;
T = 1;
b = [0 0 1];
a = [J_s 0 0];
TF = tf(b,a)
[A,B,C,D] = tf2ss(b,a)
Poles = pole(TF)
%% SS and Dampening
constants;
A = [0 1 0 0 ; 0 0 -w_mode^2/(1-alpha) -2*c_damp*w_mode/(1-alpha) ; 0 0 0 1 ; 0 0 -w_mode^2/(1-alpha) -2*c_damp*w_mode/(1-alpha)];
B = [0 ; 1/(J_s*(1-alpha)) ; 0 ; alpha-2/(J_s*(1-alpha))];
C = [1 0 0 0];
D = [0];
sys = ss(A,B,C,D);
damp(sys)
%% linmod 
constants;
[A,B,C,D] = linmod('Flex_Satellite');
sys = ss(A,B,C,D)
damp(sys);
%% Step, Initialize, Controllability, and Observability 
constants;
A = [0 1 0 0 ; 0 0 -w_mode^2/(1-alpha) -2*c_damp*w_mode/(1-alpha) ; 0 0 0 1 ; 0 0 -w_mode^2/(1-alpha) -2*c_damp*w_mode/(1-alpha)];
B = [0 ; 1/(J_s*(1-alpha)) ; 0 ; alpha/(J_s*(1-alpha))];
C = [1 0 0 0];
D = [0];
sys = ss(A,B,C,D);
figure(1);
step(sys)
grid;
x0 = [0 ; 0 ; 1 ; 0];
figure(2);
initial(sys,x0)
figure(3);
bode(sys)
figure(4);
nichols(sys)
figure(5);
nyquist(sys)
figure(6);
rlocus(sys)
Co = ctrb(sys)
Co_rank = rank(Co)
Ob = obsv(sys)
Ob_rank = rank(Ob)