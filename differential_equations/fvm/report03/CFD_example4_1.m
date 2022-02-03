% UNIVERSIDADE FEDERAL DA PARAÍBA
% CENTRO DE ENERGIAS ALTERNATIVAS E RENOVÁVEIS
% DEPARTAMENTO DE ENGENHARIA DE ENERGIAS RENOVÁVEIS
% DISCIPLINA DE TÓPICOS ESPECIAIS EM ENGENHARIA DE ENERGIAS RENOVÁVEIS
% ALUNO THIAGO NEY EVARISTO RODRIGUES
%
% Book: An Introduction to Computational Fluid Dynamics - Versteeg, H.K.
% and Malalasekera, W. 
% 
% Chapter 4: The Finite Volume Method for Diffusion Problems
% 
% Example 4.1. The problem of source-free heat conduction in an insulated
% rod whose ends are maintained at constant temperatures.

clear
close all
clc

%% Inputs

TA = 100;     % Temperature A [°C]
TB = 500;     % Temperature B [°C]
k = 1000;     % Thermal conductivity constant [W/m.K]
A = 10*10^-3; % Cross-sectional area [m^2]
L = 0.5;      % Length [m]
n = 5;        % Number of nodes (grid generation)

%% Numerical Solution

dx = L/n;

% Preallocation

aW = zeros(n,1);
aE = zeros(n,1);
SP = zeros(n,1);
Su = zeros(n,1);

% Node 1

aE(1) = k*A/dx;
SP(1) = -2*k*A/dx;
Su(1) = (2*k*A/dx)*TA;

% Central Nodes

i = 2:(n-1);

aW(i) = k*A/dx;
aE(i) = k*A/dx;

% Node n

aW(n) = k*A/dx;
SP(n) = -2*k*A/dx;
Su(n) = (2*k*A/dx)*TB;

% Matrix Equation

aP = aW + aE - SP;
a = diag(aP);

for i = 2:n
    
    j = i-1;
    a(i,j) = -aW(i);
    a(j,i) = -aE(j);
    
end

T = a\Su;

%% Outputs

x_num = linspace(0,L-dx,n) + dx/2;
x_num = [0; x_num'; L];
f_num = [TA; T; TB];

x_ex = linspace(0,L,100);
f_ex = 800*x_ex + 100;

figure
plot(x_num,f_num, 'sk',  'MarkerFaceColor', 'k')
hold on
plot(x_ex,f_ex, 'k')
legend({'Numerical Solution', 'Exact Solution'}, 'Location', 'southeast')
xlabel('Distance x [m]')
ylabel('Temperature [ºC]')
grid