%% Example of Generation of Bernouli Random Numbers Using Binary Numbers
%%

close all
clear variables
clc


%% Parameters
% Probability is fixed to 0.5 given the algorith principle.


% binary numbers lenght
bin_length = 10;
% sample size to generate
n = 1e6;


%% Generation
% Based on random integers from:
% $\mathcal{U}(\{0, 1, \ldots, 2^n-1\})$

% number of needed binary numbers
bin_n = ceil(n / bin_length);

% generation of random integers
r_int = randi(2^bin_length, bin_n, 1) - 1;
% turn to binary array
r_bin = dec2bin(r_int) == '1';
% reshape to obtain requested array size
r_bern = r_bin(1:n);


%% Visualisation
% Plot histogram of obtained values vs. theor. probabilities.

% open figure
figure("Name", "bernoulli_sample_bin")
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
scatter([0, 1], [1, 1] / 2,...
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
