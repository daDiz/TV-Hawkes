%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate synthetic data using Hawkes process
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

para.mu = 10.0;   % base intensity
para.alpha = 0.5; % kernel alpha
para.w = 2.0;     % kernel w
para.T = 100.0;   % time span

seqs = struct('t', []);

for i = 1:10
    t = HawkesOgata(para);
    seqs(i).t = t;
end
save('hp_exp.mat', 'seqs');
