%% Cauchy Distributed Random Sample
%%

close all
clear variables
clc


%% Parameters
% PDF of cauchy distribution:
%
% $$f(x) = \frac{1}{\pi\, (1 + x^2)}$$
%
% CDF of cauchy distribution:
%
% $$F(x) = \frac{1}{2} + \frac{1}{\pi}\, \mathrm{atan}(x)$$
%
% CDF inversion:
%
% $$F^{-1}(y) = \tan\big(\pi\,(y - 1/2)\big)$$
%

% probability density function with set parameter
cauchy_pdf = @(x) 1 ./ (pi * (1 + x.^2));
% inverse cumulative distribution function
cauchy_icdf = @(y) tan(pi * (y - 0.5));
% sample size
sample_size = 1e6;


%% Generation

% generate sample from U(0, 1)
r_uniform = rand(sample_size, 1);
% use icdf
r_cauchy = cauchy_icdf(r_uniform);


%% Calculation of Absolute Moments of Sample
% Calculate sample moments and theoretical moments for vizualization.

% values of moment orders to calculate
order_values_theor = linspace(0, 0.99, 100);
order_values_sample = linspace(0, 0.99, 10);

% calculate all sample moments
sample_moments = nan(size(order_values_sample));
for idx = 1:numel(order_values_sample)
    sample_moments(idx) = mean(abs(r_cauchy).^order_values_sample(idx));
end

%% Calculation of Theoretical Absolute Moments

% define symbolic variables
syms x real
syms order positive
% define symbolic pdf
pdf_symb = cauchy_pdf(x);
% define integral expresing moment
mom_symb = int(abs(x)^order * pdf_symb, x, -inf, inf);

% substitute value of moment order and analyticaly evaluate integral
theor_moments = nan(size(order_values_theor));
for idx = 1:numel(order_values_theor)
    moment_order_now = order_values_theor(idx);
    % substitution and conversion from symbolic to double variable
    theor_moments(idx) = double(subs(mom_symb, order, moment_order_now));
end


%% Visualisation
% Plot theoretical moments vs. sample moments.

% open figure
figure("Name", "exp_sample")
% keep multiple graphical objects
hold on
% theor. moments
plot(order_values_theor, theor_moments, ": red",...
    "LineWidth", 3,...
    "DisplayName", "theor. moments")
% sample moments
plot(order_values_sample, sample_moments, ":x black",...
    "LineWidth", 2,...
    "MarkerSize", 10,...
    "DisplayName", "sample moments")

xlabel("moment order")
ylabel("moment value")

set(gca, "YScale", "log")

title("Absolute Moments of Cauchy Distribution")
legend("Location", "northwest")

box on
grid on
