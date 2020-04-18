%% Parameters
r     = 0.05; % Real interest rate
beta  = 0.90; % Discount factor
gamma = 1;  % EIS
phi   = 0;    % Borrowing limit

Pi(1,1) = 0.5; % Prob(y'=y_h|y=y_h)
Pi(1,2) = 1 - Pi(1,1); % Prob(y'=y_l|y=y_h)
Pi(2,1) = 0.5; % Prob(y'=y_h|y=y_l)
Pi(2,2) = 0.5; % Prob(y'=y_l|y=y_l)

%% Tolerance
tol = 10^(-5);
itmax = 100000;

n_y = 2;

pi = ones(1,n_y)/n_y;
pi_new = zeros(1,n_y);
for it = 1 : itmax
    pi_new = pi*Pi';
    if max(pi-pi_new)<tol
        break
    end
    pi = pi_new;
end

yratio = 1.5;% [y_h y_l]
y  = [ yratio 1] / (pi * [yratio 1]'); % Normalizing to mean 1



n_a   = 500;  % Number grid points for state variable
amax  = 50;   % Maximum level assets

% State variable grid z= y +(1+r)*a
pivot  = 0.25*((phi)<=0);
agrid   = logspace(log10(-phi+pivot),log10(amax+pivot),n_a)-pivot;

% agrid   = linspace((-phi+pivot),(amax+pivot),n_a)-pivot;

if gamma == 1
    u = @(c) log(c);
else
    u = @(c) c.^(1-gamma)/(1-gamma);
end

mu = @(c) c.^(-gamma);
muinv = @(mu) mu.^(-1/gamma);


alpha = 0.3;
A     = 1;
delta = 0.15;

MPk = @(K,L) alpha * A * K.^(alpha-1) * L^(1-alpha);
wage   = @(K,L) (1-alpha) * A * K.^(alpha) * L^(-alpha);





