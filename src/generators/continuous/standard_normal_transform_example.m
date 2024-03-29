%% Generation of Standard Normal Sample Using Pair-Wise Transform
%%

close all
clear variables
clc

%% Parameters

sample_size = 1e4;


%% Random Sample Generation
% Sample is generated pair-wise using transformations
% $\sqrt{-2\,\ln(\gamma_1)}\,\sin(2\,\pi\,\gamma_2)$
% and
% $\sqrt{-2\,\ln(\gamma_1)}\,\cos(2\,\pi\,\gamma_2)$

% calculate needed number of pairs
n_pairs = ceil(0.5 * sample_size);

% generate random samples from U(0, 1)
gamma_1 = rand(n_pairs, 1);
gamma_2 = rand(n_pairs, 1);

% compute common multiple
common_mult = sqrt(-2 * log(gamma_1));
% compute common argument of goniometric functions
gonio_arg = 2*pi * gamma_2;
% generate samples
r_1 = common_mult .* sin(gonio_arg);
r_2 = common_mult .* cos(gonio_arg);

% combine samples
r_sample = [r_1; r_2];
% select only number of elements initaly requested
r_sample = r_sample(1:sample_size);


%% Visualisation

figure("Name", "normal_by_transform")
hold on

% draw histogram of generated sample
histogram(r_sample,...
    "FaceAlpha", 1,...
    "FaceColor", "black",...
    "EdgeColor", "white",...
    "Normalization", "pdf",...
    "DisplayName", "histogram");
% draw pdf of N(0, 1)
fplot(@(x) normpdf(x),...
    "Color", "red",...
    "LineWidth", 2)

% add labels
xlabel("domain")
ylabel("probability density")
title("Normaly Distributed Random Sample")
legend()

box on
grid on
