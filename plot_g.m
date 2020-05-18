function plot_g(model)
    x = 1:ceil(model.g_t_limit / model.dt);
    stairs(x * model.dt, model.g(x), 'DisplayName', 'g learned');
    hold on;
    stairs(x * model.dt, model.gt(x), 'DisplayName', 'g true');
    legend;
end