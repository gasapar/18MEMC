%% Calculate Volume of d-dimensional ball
%%

close all
clear variables
clc


%% Parameters

ball_dimension = 5;
sample_size = 1e6;


%% Generate Random Values

random_coordinates = rand(sample_size, ball_dimension) * 2 - 1;
distance_from_center = sqrt(sum(random_coordinates.^2, 2));

is_in_ball = distance_from_center <= 1;


%% Volume Calculation

box_volume = 2^ball_dimension;
ball_volume_theor = ...
    pi^(0.5 * ball_dimension) / gamma(0.5 * ball_dimension + 1);

ball_volume_estimate = box_volume * mean(is_in_ball);


%% Show Estimate Convergence

sample_size_series = 1:sample_size;

ball_volume_estimate_series = ...
    box_volume * cumsum(is_in_ball(:)) ./ sample_size_series(:);

figure("Color", "white")
scatter(sample_size_series, ball_volume_estimate_series, ". black", ...
    "SizeData", 1, ...
    "DisplayName", "Estimates")

legend( ...
    "AutoUpdate","off", ...
    "Location", "best")

yline(ball_volume_theor, "-- red", ...
    "Label", "Theor. Result")

set(gca, "XScale", "log")
xlabel("Sample Size")
ylabel("Volume Estimate")
title("MC Ball Volume Calculation")

grid on
box on
