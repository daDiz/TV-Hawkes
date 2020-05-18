% Hawkes process w/ exponential kernel
% kernel = alpha * w * exp(-wt)
% ref: Ogata, 1981, p.25, Algorithm 2
% ref: Thinning Algorithms for Simulating Point Processes, Algorithm 3
function tau = HawkesOgata(para)
    mu = para.mu;
    alpha = para.alpha;
    w = para.w;
    T = para.T;
    tau = [];
    s = 0.0;
    
    while s < T
        lamb_bar = mu + alpha * w * sum(exp(-1.0 * w * (s - tau)));
        u = rand;
        ds = -1.0 * log(u) / lamb_bar;
        s = s + ds;
        D = rand;
        
        if D * lamb_bar <= (mu + alpha * w * sum(exp(-1.0 * w * (s - tau))))
            tau = [tau s];
        end
    end
    
    if ~isempty(tau) && tau(end) > T
           tau = tau(1:end-1); 
    end
end