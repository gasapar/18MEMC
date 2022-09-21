%% Exponentially Distributed Random Sample
%%

close all
clear variables
clc


%% Parameters

% parameter ofr distribution
lambda_par = 4;
% probability density function with set parameter
exp_pdf = @(x) lambda_par * exp(-lambda_par * x);
% inverse cumulative distribution function
exp_icdf = @(y) -1/lambda_par * log(y);
% sample size
n = 1e4;


%% Generation
% PDF of exp. distribution is:
%
% $$f(x) = \lambda\, \exp(-\lambda\,x)$$
%
% CDF of exp. distribution is:
%
% $$F(x) = 1 - \exp(-\lambda\,x)$$
%
% CDF inversion:
%
% $$F^{-1}(y) = -1/\lambda\,\ln(1-y)$$
%

% sample from U(0, 1)
r_uniform = rand(n, 1);
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
    "DisplayName", "histogram")
% draw pdf
fplot(exp_pdf, [0, max(r_exp)],...
    "Color", "red",...
    "LineWidth", 2,...
    "DisplayName", "pdf")

xlabel("domain")
ylabel("probability density")
title("Exponentialy Distributed Random Sample")
legend("Location", "northeast")

box on
grid on
