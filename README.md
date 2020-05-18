# TV-Hawkes

This repository contains code for the paper:

Interpretable Hawkes Process Spatial Crime Forecasting with TV-Regularization

TV-Hawkes is an efficient expectation-maximization algorithm coupled with forward backward splitting to estimate the point process with a total-variation regularization that enforces the triggering kernel to be piece-wise constant.

## generate synthetic data
run the following script to simulate multiple sequences using Hawkes process with exponential kernel
```
        run_sim_hp.m
```


## fit model
fit TV-Hawkes
```
        run_tv_hawkes.m
```
 

## plot kernel
plot true and learned kernel
```
        plot_g(model)
```
Note: run this command after you have a model.
