clear

T = 100.0; % total time span
mu = 1.0; % initial mu
dt = 0.1; % time interval of g

load('hp_exp.mat'); % load the sequences
t = seqs(1).t;
n = length(t);
nbins = ceil(T / dt); % num of bins for g

% model
model.T = T;
model.p = diag(ones(n,1)); % probabilities
model.t = t;
model.mu = mu;
model.dt = dt;
model.nbins = nbins; % num of bins
model.n = n; % num of events
model.g = mu * ones(nbins, 1); % kernel

model.denomenator = zeros(model.nbins, 1); % derivative of integral of g
model = Maximization_Denomenator(model);

model.g_t_limit = 2.0; % kernel cutoff
model.mu_list = [];
model.g_prev = 0.0;
model.mu_prev = 0.0;
model.err_mu_list = [];
model.err_g_list = [];



% parameter general
para.n_iter = [];
para.tol_mu = 1e-2;
para.tol_g = 1e-2;
para.print_iter = 10;

% parameter tv
para_tv.tv = true; % false - turn off tv constraint
para_tv.mu = 1.0*1e-2;

% parameter for true exponential kernel
para_t.mu = 10.0;
para_t.alpha = 0.5;
para_t.w = 2.0;
para_t.T = 100.0;

model = exp_g(model, para_t);

%  OPTIONAL:  give some extra instructions to FASTA
opts = [];
opts.tol = 1e-3;  % Use custom stopping tolerance
opts.recordObjective = true; %  Record the objective function so we can plot it
opts.maxIters = 1e5;
opts.verbose = false;
opts.stringHeader='    ';      % Append a tab to all text output from FISTA.  This option makes formatting look a bit nicer. 


% learning
model = Learning_MISD_tv(model, para, para_tv, opts);

% base intensity: model.mu
% kernel: model.g

% save model
save('model_tv_hawkes.mat', 'model');