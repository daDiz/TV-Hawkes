% Expectation step for EM (MISD) algorithm
% ref: A Nonparametric EM algorithm for Multiscale Hawkes Processes, Eq.
% 26,27
function model = Expectation(model)
    for i = 2:model.n
        for j = 1:(i-1)
            dt1 = model.t(i) - model.t(j);
            
            if dt1 == 0
                ind = 1;
            else
                ind = ceil(dt1 / model.dt);
            end
            
            gk = model.g(ind);
            model.p(i,j) = gk;
        end
        model.p(i,i) = model.mu;
        denominator = sum(model.p(i,:));
        model.p(i,:) = model.p(i,:) / denominator;
    end
end