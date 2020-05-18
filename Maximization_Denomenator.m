function model = Maximization_Denomenator(model)
for i = 1:model.n
    for ind = 1:model.nbins
        if model.T - model.t(i) >= model.dt * ind
            model.denomenator(ind) = model.denomenator(ind) + 1.0;
        end
    end
end