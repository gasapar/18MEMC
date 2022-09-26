%% Rejection Method for Bounded Domain
%%

close all
clear variables
clc


%% Parameters

% define domain as interval
domain = [0, pi] - 0.5 * pi;
% define probab. distribution using density
% note that pdf is normalized
pdf = @(x) 0.5 * sin(x + 0.5 * pi);
% define max of pdf
pdf_max = 0.5;

% sample size
n = 1e3;


%% Generation

% generete x coordinate, U(a, b)
x = rand(n, 1) * (domain(2) - domain(1)) + domain(1);
% generate y coordinate, U(0, pdf_max)
y = rand(n, 1) * pdf_max;

% check if y < pdf(x)
point_in_under_pdf = y < pdf(x);

% accept only such x, for which hold y < pdf(x)
r_sample = x(point_in_under_pdf);


%% Visualisation

figure("Name", "rejection_for_bounded_set")
hold on

% draw histogram of generated sample
histogram(r_sample,...
    "FaceAlpha", 1,...
    "FaceColor", "black",...
    "EdgeColor", "white",...
    "Normalization", "pdf",...
    "DisplayName", "histogram")

% draw pdf
fplot(pdf, domain,...
    "LineWidth", 2,...
    "Color", "blue")

% draw rejected sample
scatter(x(~point_in_under_pdf), y(~point_in_under_pdf), ". red",...
    "DisplayName", "rejected points")
% draw accepted sample
scatter(x(point_in_under_pdf), y(point_in_under_pdf), ". green",...
    "DisplayName", "accepted points")

xlim(domain)
ylim([0, pdf_max])

xlabel("domain")
ylabel("probability density")
title("Rejection Generated Sample")
legend("Location", "northeastoutside")

box on
grid on
