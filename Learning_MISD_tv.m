% EM (MISD) learning Hawkes process intensity (non-parameteric)
% constant base intensity mu, and general g
% lambda = mu + sum(g)
% ref: A Nonparametric EM algorithm for Multiscale Hawkes Processes, Eq. 26
% ~ 29
function model = Learning_MISD_tv(model, para, para_tv, opts)
    i = 0;
    while 1
        model = Expectation(model);
        model = Maximization(model);
        
        %model = Maximization(model);
        if para_tv.tv
            [model.g, ~] = fasta_totalVariation(model.g, para_tv.mu, opts);
        end
        model.g(ceil(model.g_t_limit / model.dt):end) = 0.0;
        
        %err_gg = norm(model.g - model.gt);
        %fprintf('|g - gt| = %f\n', err_gg);
        
        err_mu = norm(model.mu - model.mu_prev);
        err_g = norm(model.g - model.g_prev);
        if ~isempty(para.n_iter) && i >= para.n_iter || para.tol_mu && err_mu < para.tol_mu && para.tol_g && err_g < para.tol_g
            model.err_mu_list = [model.err_mu_list err_mu];
            model.err_g_list = [model.err_g_list err_g];
            
            fprintf('iter %d, err mu %.6f, err g %.6f\n', i, err_mu, err_g);
            break
        end
        model.err_mu_list = [model.err_mu_list err_mu];
        model.err_g_list = [model.err_g_list err_g];
        if mod(i, para.print_iter) == 0
            fprintf('iter %d, err mu %.6f, err g %.6f\n', i, err_mu, err_g);
        end
        i = i + 1;
    end
end
