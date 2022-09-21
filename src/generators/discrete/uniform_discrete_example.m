%% Uniformly Distributed Discrete Randdom Variables
%%

close all
clear variables
clc

%% Parameters

% max integer givin domain {1, ... max_value}
max_value = 9;
% sample size
n = 1e6;

%% Generation

% sample from U(0, 1)
r_cont = rand(n, 1);
% sample from U({1, ..., max_value})
r_disc = floor(r_cont * max_value) + 1;


%% Visualisation
% Plot histogram of obtained values vs. theor. probabilities.

% open figure
figure("Name", "uniform_discrete_sample")
% keep multipel graphical objects
hold on
% draw histogram
histogram(r_disc,...
    "FaceAlpha", 1,...
    "FaceColor", "black",...
    "EdgeColor", "white",...
    "Normalization", "probability",...
    "DisplayName", "histogram")
% draw probabilities
scatter(1:max_value, 1/max_value * ones(1, max_value),...
    "Marker", "o",...
    "SizeData", 50,...
    "MarkerFaceColor", "red",...
    "MarkerEdgeColor", "white",...
    "DisplayName", "probabs.")

xlabel("domain")
ylabel("probability")
title("Uniformly Distribute Random Sample")
legend("Location", "south")

box on
grid on
