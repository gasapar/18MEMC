%% Example of Generation of Bernouli Random Numbers


%%

close all
clear variables
clc


%% Parameters

% probability specifying bern. distribution 
p = 0.6;
% sample size to generate
n = 1e6;


%% Generation

% generate from U(0, 1)
r_uniform = rand(n, 1);
% with probab. 'p' get 'true'
r_bern = r_uniform < p;


%% Visualisation
% Plot histogram of obtained values vs. theor. probabilities.

% open figure
figure("Name", "bernoulli_sample")
% keep multipel graphical objects
hold on
% draw histogram
histogram(r_bern,...
    "FaceAlpha", 1,...
    "FaceColor", "black",...
    "EdgeColor", "white",...
    "Normalization", "probability",...
    "DisplayName", "histogram")
% draw probabilities
scatter([0, 1], [1-p, p],...
    "Marker", "o",...
    "SizeData", 50,...
    "MarkerFaceColor", "red",...
    "MarkerEdgeColor", "white",...
    "DisplayName", "probabs.")

xlabel("domain")
ylabel("probability")
title("Bernoulli Random Sample")
legend()

box on
grid on

snapnow
