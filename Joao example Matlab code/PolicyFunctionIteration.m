%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%Code by Joao Guerreiro %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; clc; close all; figure_setup_bw;
tic;
Parameters;
options = optimset('Display','off');
%% Initialize value function
cpol = repmat(agrid,n_y,1)/2+min(y);
cpol_new = cpol;

fun = @(x,iyx,cohx,cpol) (cohx - x)  ...
                -(beta*(1+r)*(Pi(iyx,1)*(interp1(agrid,cpol(1,:),x,'linear','extrap')).^(-gamma)...
                +Pi(iyx,2)*(interp1(agrid,cpol(2,:),x,'linear','extrap')).^(-gamma))).^(-1/gamma);

for it = 1 : itmax
    
    mup = ((beta*(1+r)*Pi)*((cpol).^(-gamma))).^(-1/gamma);                
    for iy = 1 : n_y
        coh = y(iy) + (1+r)*agrid;
        x0  = coh - cpol(iy,:);
        apol_new = fsolve(@(x) fun(x,iy,coh,cpol),x0,options);
        apol_new(apol_new<=-phi) = -phi;
        cpol_new(iy,:) = y(iy) + (1+r)*agrid - apol_new;        
    end
    
    fprintf('Policy Function - Iteration #%d\n', it);
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


