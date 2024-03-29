%% Exponentially Distributed Random Sample
%%

close all
clear variables
clc


%% Parameters
% PDF of exp. distribution:
%
% $$f(x) = \lambda\, \exp(-\lambda\,x)$$
%
% CDF of exp. distribution:
%
% $$F(x) = 1 - \exp(-\lambda\,x)$$
%
% CDF inversion:
%
% $$F^{-1}(y) = -1/\lambda\,\ln(1-y)$$
%

sample_size = 1e4;
% parameter of the distribution
lambda_par = 4;
% probability density function with set parameter
exp_pdf = @(x) lambda_par * exp(-lambda_par * x);
% inverse cumulative distribution function
exp_icdf = @(y) -1/lambda_par * log(y);


%% Generation

% sample from U(0, 1)
r_uniform = rand(sample_size, 1);
% use icdf
r_exp = exp_icdf(r_uniform);


%% Visualisation
% Plot histogram of obtained values vs. pdf

% open figure
figure("Name", "exp_sample")
% keep multiple graphical objects
hold on
% draw histogram
histogram(r_exp,...
    "FaceAlpha", 1,...
    "FaceColor", "black",...
    "EdgeColor", "white",...
    "Normalization", "pdf",...
    "LineWidth", 0.1,...
    "DisplayName", "Histogram")
% draw pdf
fplot(exp_pdf, [0, max(r_exp)],...
    "Color", "red",...
    "LineWidth", 2,...
    "DisplayName", "pdf")
% add labels
xlabel("Domain")
ylabel("Probability Density")
title("Exponentialy Distributed Random Sample")
legend("Location", "northeast")

box on
grid on
