%% Generation of Sample of Isotropic Directions in 3d
%%

close all
clear variables
clc


%% Parameters

sample_size = 1e3;
% flag to run animation
run_animation = false;


%% Generation
% The aim is to generate isotroic directions in 3d which correcpond to
% the uniformly distributed points $(x, y, z)$ on a unit sphere.
% Used transformations for dimensions:
% $x = \sqrt{1 - \mu^2}\,\sin(\varphi)$,
% $y = \sqrt{1 - \mu^2}\,\cos(\varphi)$,
% $z = \mu$,
% where $\mu\sim\mathcal{U}(-1, 1)$ and $\varphi\sim\mathcal{U}(0, 2\,\pi)$.
%
% Note that standard spherical transformation does not produce uniformly
% distributed sample.

% generate from U(-1, 1)
r_mu = rand(sample_size, 1) * 2 - 1;
% generate from U(0, 2*pi)
r_phi = rand(sample_size, 1) * 2*pi;

% compute common multiple
common_mult = sqrt(1 - r_mu.^2);
% compute coordinates
x = common_mult .* sin(r_phi);
y = common_mult .* cos(r_phi);
z = r_mu;


%% Visualisation

hf = figure("Name", "isotropic_in_3d",...
    "Color", "white");
hold on

% draw random points
scatter3(x, y, z, ". black",...
    "DisplayName", "Random Sample")
% draw point (0, 0, 0) for orientation
scatter3(0, 0, 0, "filled", "red",...
    "DisplayName", "(0, 0, 0)")

% remove axis to look better in 3d
axis vis3d off

% add legend with title
hl = legend("Location", "southeast");
title(hl, "Isotropic Directions in 3d")

% run animation while figure window is open
angl = 1;
while isgraphics(hf) && run_animation
    view(angl, 90 - abs(angl - 180))
    angl = mod(angl + 1, 360);
    drawnow
end
