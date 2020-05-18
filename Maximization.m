%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code deals with the integral in the intensity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% maximization step for EM (MISD) algorithm
% ref: A Nonparametric EM algorithm for Multiscale Hawkes Processes, Eq.
% 28,29
function model = Maximization(model)
    model.mu_list = [model.mu_list model.mu];
    model.g_prev = model.g;
    model.mu_prev = model.mu;
    model.g = zeros(model.nbins, 1);
    model.mu = 0.0;
    
    
    for i = 1:model.n
       for j = 1:(i-1)
           dt1 = model.t(i) - model.t(j);
           if dt1 == 0
               ind = 1;
           else
               ind = ceil(dt1 / model.dt);
           end
           model.g(ind) = model.g(ind) + model.p(i,j) / model.dt;
       end
       model.mu = model.mu + model.p(i,i) / model.T;
       
    end
    
    model.g = model.g ./ model.denomenator;
    model.g(isnan(model.g)) = 0.0;
    model.g(isinf(model.g)) = 0.0;
end