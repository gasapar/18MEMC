%% Rejection Method for Unbounded Domain
%%

close all
clear variables
clc


%% Parameters
% The aim is to generate from standard normal distribution.
% Note that
% $\forall x \in \mathbb{R},\quad
% \mathrm{pdf}_{\mathrm{norm.}}(x) < \mathrm{pdf}_{\mathrm{exp.}}(x).$

% define pdf of N(0, 1)
pdf_n = @(x) normpdf(x);
% define pdf of Exp(1)
pdf_e = @(x) exppdf(x);

sample_size = 1e3;


%% Generation

% generate x coordinates, Exp(1)
x = -log(rand(sample_size, 1));
% generate y coordinate, U(0, Exp(x))
y = rand(sample_size, 1) .* pdf_e(x);

% check if: y < pdf_n(x)
point_is_under_pdf = y < pdf_n(x);

% with probab. 0.5 flip signum of the x coordinate to obtain neg. values
plus_or_minus_one = ((rand(sample_size, 1) < 0.5) * 2 - 1);
x = x .* plus_or_minus_one;

% accept only such x, for which holds y < pdf_n(x)
r_sample = x(point_is_under_pdf);


%% Visualisation

% get limits for the image
x_limits = [min(x), max(x)];

figure("Name", "rejection_for_bounded_set")
hold on

% draw histogram of the generated sample
histogram(r_sample,...
    "FaceAlpha", 1,...
    "FaceColor", "black",...
    "EdgeColor", "white",...
    "Normalization", "pdf",...
    "DisplayName", "Histogram")

% draw pdf, N(0, 1)
fplot(pdf_n, x_limits,...
    "LineWidth", 2,...
    "Color", "blue")

% draw pdf, Exp(1)
fplot(pdf_e, [0, max(x_limits)],...
    "LineWidth", 2,...
    "Color", "cyan")

% draw rejected points
scatter(x(~point_is_under_pdf), y(~point_is_under_pdf), ". red",...
    "DisplayName", "Rejected Points")
% draw accepted points
scatter(x(point_is_under_pdf), y(point_is_under_pdf), ". green",...
    "DisplayName", "Accepted Points")

xlim(x_limits)
xlabel("Domain")
ylabel("Probability Density")
title("Rejection Generated Sample")
legend()

box on
grid on
