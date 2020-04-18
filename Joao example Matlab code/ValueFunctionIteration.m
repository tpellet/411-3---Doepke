%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%Code by Joao Guerreiro %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; clc; close all; figure_setup_bw;
tic;
Parameters;
agrid   = linspace(-phi,amax,n_a);
H = 1;

%% Initialize value function
V      = zeros(n_y, n_a);
Vnew   = zeros(n_y, n_a);
apol   = zeros(n_y, n_a);
apol_i = zeros(n_y, n_a);

for it = 1 : itmax
    for iy = 1 : n_y
        for ia = 1 : n_a
            Vtilde = u( max(y(iy) + (1+r)*agrid(ia) - agrid,10^(-10))) + beta * Pi(iy,:) * V;
            
            [Vnew(iy,ia), apol_i(iy,ia)] = max(Vtilde);
            apol(iy,ia) = agrid(apol_i(iy,ia));
        end
    end
    
    fprintf('Value Function - Iteration #%d\n', it);
        err = max(max(abs(Vnew - V)));
        fprintf('Error = #%d\n', err);  
    
    if err < tol
        V = Vnew;
        break
    elseif it == itmax
        fprintf('Value function did not converge!');
    end    
    V = Vnew;
    
     
    if H == 1 %%Howard improvement
        for it2 = 1 : itmax
         for iy = 1 : n_y
             Vnew(iy,:) = u( max(y(iy) + (1+r)*agrid - agrid(apol_i(iy,:)),10^(-6)))...
                 +beta*( Pi(iy,1) * V(1,apol_i(iy,:))+Pi(iy,2)*V(2,apol_i(iy,:)));
             
         end
         err = max(max(abs(Vnew - V)));
             if err < tol
                V = Vnew;
                break
             elseif it2 == itmax
                fprintf('Howard Improvement did not converge!');
             end
          V = Vnew;
        end
     end
end

cpol = repmat(y',1,n_a) + (1+r)*repmat(agrid,2,1) - apol;

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