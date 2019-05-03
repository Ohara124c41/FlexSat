%% Modal Open Init
constants;
[A,B,C,D] = linmod('Modal_Control_Open');
sys = ss(A,B,C,D)
pole(sys)
%% Eigenstructure 
constants;  
sys = linmod('Modal_Control_Open');
delta = 0.7; 
omega = 0.2;    
lambda = roots([1 2*delta*omega omega^2]);  
VW1 = null([sys.a-lambda(1)*eye(7) sys.b]);   
VW2 = null([sys.a-lambda(2)*eye(7) sys.b]);
V = [VW1(1:7) VW2(1:7)];
W = [VW1(8) VW2(8)];
K = -real(W/(sys.c*V))
damp(sys.a-sys.b*K*sys.c)
%% Modal Close Bode
constants;
[A,B,C,D] = linmod('Modal_Control_Closed');
sys = ss(A,B,C,D)
bode(sys)
%nyquist(sys)
%% Open Integrator Init
constants;
[A,B,C,D] = linmod('Modal_Control_Open_Integ');
sys = ss(A,B,C,D)
pole(sys)
%% Eigenstructure Integral 
constants;  
sys = linmod('Modal_Control_Open_Integ');
delta = 0.7; 
omega = 0.13;    
lambda = [roots([1 2*delta*omega omega^2 ]); -omega]  
VW1 = null([sys.a-lambda(1)*eye(8) sys.b]);   
VW2 = null([sys.a-lambda(2)*eye(8) sys.b]);
VW3 = null([sys.a-lambda(3)*eye(8) sys.b]);
V = [VW1(1:8) VW2(1:8) VW3(1:8)];
W = [VW1(9) VW2(9) VW3(9)];
Kint = real(W/(sys.c*V))
damp(sys.a+sys.b*Kint*sys.c);
%% Close Bode Integral
constants;
[A,B,C,D] = linmod('Modal_Control_Closed_Integ');
sys = ss(A,B,C,D)
bode(sys)
%nyquist(sys)
%% Phase-lead SISO 
constants;
[A,B,C,D] = linmod('Phase_Control_Open');
G = ss(A,B,C,D)
bode(G)
sisotool (G);
%% 
constants;
[A,B,C,D] = linmod('Phase_Control_K1');
sys = ss(A,B,C,D)
%bode(sys)
dcgain(sys)
%% 
constants;
[A,B,C,D] = linmod('Phase_Control_Open');
G = ss(A,B,C,D)
K1 = tf([18.9*1.33*0.23 0.23],[1.33 1]);
sisotool(G,K1)
%% 
constants;
t2 = 67;
[A,B,C,D] = linmod('Phase_Control_K2');
sys = ss(A,B,C,D)
bode(sys)