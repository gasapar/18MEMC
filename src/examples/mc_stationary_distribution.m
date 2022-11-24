%% Stationary Distribution for Random Walk in 2D
% Displays distribution of particle positions in a box in evolving time.
%%

close all
clear variables
clc


%% Parameters

% number of simulated particles
n_particles = 10000;
% square space edge size (movement limits: [0, box_edge - 1])
box_edge = 50;
% time steps to plot distribution at
n_steps = [20:20:200, 300:100:1000, 2000:1000:5000];

% initial locations of particles
% all particles on zeros
Xall = zeros(n_particles, 2);


%% Movement Definition

% allowed directions of one step
allowed_dirs = [zeros(1, 2); eye(2); -eye(2)];
% probability of each direction
probab_dirs = ones(1, size(allowed_dirs, 1));
% keep low probability of staying
probab_dirs(1) = 0.1;
% ensure normalisation
probab_dirs = probab_dirs / sum(probab_dirs, "all");


%% Generate Trajectories

Tall = getTrajectory( ...
    Xall, max(n_steps), probab_dirs, allowed_dirs, box_edge);


%% Calculate Particles Densities

particle_density = nan(box_edge, box_edge, numel(n_steps));
for idx = 1:size(particle_density, 3)
    % get particle positions at the given time
    Xnow = Tall(:, :, n_steps(idx));
    % get number of paticles in every position
    particle_density(:, :, idx) = countsInPositions(Xnow, box_edge);
end
% normalization to grayscale
particle_density = (particle_density / n_particles) * 255;


%% Plot Densities

figure( ...
    "Name", "distribution_evolution", ...
    "Color", "white", ...
    "MenuBar", "none", ...
    "WindowState", "maximized")

tiledlayout("flow", ...
    "Padding", "tight",...
    "TileSpacing", "tight")

for idx = 1:numel(n_steps)
    
    density_now = particle_density(:, :, idx);
    
    nexttile
    % show as image
    imshow(density_now, "Colormap", colormap("hot"));
    
    title("t = " + n_steps(idx))
end

% add colorbar
nexttile
axis off
hc = colorbar(gca);
hc.Location = "layout";
hc.Label.String = "Probability";


%% Functions


function Tall = getTrajectory( ...
    Xall, n_steps, probab_dirs, allowed_dirs, box_edge)
% GETTRAJECTORY Adds random steps to initial locations.

% get number of particles
n_particles = size(Xall, 1);


%% Generate All Random Directions

% number of needed steps for all particles
n_steps_total = n_steps * n_particles;
% generate indexes of random directions
r_dirs_idx = sum(rand(n_steps_total, 1) > cumsum(probab_dirs), 2) + 1;
% get random directions
r_dirs = allowed_dirs(r_dirs_idx, :);
% reshape array to 3D, the third dimension is time
r_dirs = permute(reshape(r_dirs.', 2, n_particles, n_steps), [2, 1, 3]);
% create trajectory as the sum of steps
Tall = Xall + cumsum(r_dirs, 3);


%% Limit to Box
% Ensure that all particles do not leave the box of the given edge.

Tall = mod(Tall, 2 * box_edge - 1);
Tall = min(Tall, 2 * box_edge - 1 - Tall);
end


function position_counts  = countsInPositions(Xall, box_edge)
%COUNTSINPOSITIONS. Counts the number of particles in every uniuque position.

% calculate number of particels in every unique position
[Xunique, ~, rowidx] = unique(Xall, 'rows');
n_occurrences = accumarray(rowidx, 1);

% empty array of the of particles in every position
position_counts = zeros(box_edge);
% turn coordinates to indexes
Xunique = Xunique + 1;
% sub linear index to add values
ind = sub2ind(box_edge * [1, 1], Xunique(:, 1), Xunique(:, 2));
position_counts(ind) = n_occurrences;
end