function model = exp_g(model, para)
    t = model.dt * (1:model.nbins);
    model.gt = para.alpha * para.w * exp(-para.w * t);
    model.gt(ceil(model.g_t_limit / model.dt):end) = 0.0;
end