%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%Code by Joao Guerreiro %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; clc; close all; figure_setup_bw;
tic;
Parameters;

cpol     = repmat(agrid,n_y,1)/2+min(y);
cpol_new = cpol;
c        = zeros(1,n_a);
a        = zeros(1,n_a);

for it = 1 : itmax
    c = ((beta*(1+r) * Pi) * cpol.^(-gamma)).^(-1/gamma);
    a = (c+repmat(agrid,n_y,1)-repmat(y',1,n_a))/(1+r);
    
    for iy = 1 : n_y
        cpol_new(iy,:) = interp1(a(iy,:),c(iy,:),agrid,'linear','extrap');
        cpol_new(iy,agrid<=a(iy,1)) = y(iy)+(1+r)*agrid(agrid<=a(iy,1));
    end

    fprintf('Endogenous Gridpoints - Iteration #%d\n', it);
    err = max(max(abs(cpol_new - cpol)));
    fprintf('Error = #%d\n', err);  
    
    if err < tol
        cpol = cpol_new;  
        break
    elseif it == itmax
        fprintf('Policy function did not converge!');
    end    
    cpol = cpol_new;  
end
apol = repmat(y',1,n_a)+(1+r)*repmat(agrid,n_y,1)-cpol;
toc;

subplot(1,2,1)
plot(agrid,cpol)
xlabel('$a$')
ylabel('$c(a,y)$')
legend('$y_h$','$y_l$')
subplot(1,2,2)
plot(agrid,apol)
xlabel('$a$')
ylabel('$a^\prime(a,y)$')
legend('$y_h$','$y_l$')