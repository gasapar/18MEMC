%% Rejection Method for Bounded Domain
%%

close all
clear variables
clc


%% Parameters
% The aim is to generate a sample from a distribution with bounded domain.

% define domain as interval
domain = [0, pi] - 0.5 * pi;
% define probab. distribution using density
% note that the defined pdf is normalised
pdf = @(x) 0.5 * sin(x + 0.5 * pi);
% define max of pdf
pdf_max = 0.5;

sample_size = 2e3;


%% Generation

% generate x coordinate, U(a, b)
x = rand(sample_size, 1) * (domain(2) - domain(1)) + domain(1);
% generate y coordinate, U(0, pdf_max)
y = rand(sample_size, 1) * pdf_max;

% check if y < pdf(x)
point_is_under_pdf = y < pdf(x);

% accept only such x, for which holds y < pdf(x)
r_sample = x(point_is_under_pdf);


%% Visualisation

figure("Name", "rejection_for_bounded_set")
hold on

% draw histogram of generated sample
histogram(r_sample,...
    "FaceAlpha", 1,...
    "FaceColor", "black",...
    "EdgeColor", "white",...
    "Normalization", "pdf",...
    "DisplayName", "Histogram")

% draw pdf
fplot(pdf, domain,...
    "LineWidth", 2,...
    "Color", "blue")

% draw rejected sample
scatter(x(~point_is_under_pdf), y(~point_is_under_pdf), ". red",...
    "DisplayName", "Rejected Points")
% draw accepted sample
scatter(x(point_is_under_pdf), y(point_is_under_pdf), ". green",...
    "DisplayName", "Accepted Points")

xlim(domain)
ylim([0, pdf_max])

xlabel("Domain")
ylabel("Probability Density")
title("Rejection Generated Sample")
legend("Location", "northeastoutside")

box on
grid on
