%% Sample From General Discrete Distribution
%%

close all
clear variables
clc


%% Parameters

% probability vector
p = [8, 2, 4, 1];
% sample size
n = 1e6;


%% Generation

% ensure normalization of probab. vector
p = p / sum(p);
% sample from U(0, 1)
r = rand(n, 1);
% empty array for final sample
r_sample = nan(n, 1);

for idx = 1:n
    S = r(idx);
    k = 1;
    
    S = S - p(k);
    while S > 0
        k = k + 1;
        S = S - p(k);
    end
    
    r_sample(idx) = k;
end


%% MATLAB Specific Alternative Implementation

r_sample_MATLAB = sum(rand(n, 1) > cumsum(p), 2) + 1;


%% Visualisation
% Plot histogram of obtained values vs. theor. probabilities.

% open figure
figure("Name", "general_discrete_sample")
% keep multiple graphical objects
hold on
% draw histogram
histogram(r_sample,...
    "FaceAlpha", 1,...
    "FaceColor", "black",...
    "EdgeColor", "white",...
    "Normalization", "probability",...
    "DisplayName", "histogram")
% draw probabilities
scatter(1:numel(p), p,...
    "Marker", "o",...
    "SizeData", 50,...
    "MarkerFaceColor", "red",...
    "MarkerEdgeColor", "white",...
    "DisplayName", "probabs.")

xlabel("domain")
ylabel("probability")
title("Generally Distributed Random Sample")
legend("Location", "south")

box on
grid on
