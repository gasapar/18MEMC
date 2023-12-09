%% Generation of Sample of Isotropic Directions in d-dimensional space
%%

close all
clear variables
clc


%% Parameters

sample_size = 5e2;
% dimension
sapce_dimension = 3;
% flag to run animation, try to run this script with true
run_animation = true;


%% Generation
% The aim is to generate isotroic directions in general $d$-dimensional space.
% Used property is that random vector
% $Y = \frac{X}{||X||_2}$
% is uniform on $d$-dimensional unit sphere if
% $X = (X_1, \ldots, X_d)$ where $X_i\sim\mathcal{N}(0, 1)$.
%
% Note that random vector $Y$ has unit norm.

% generate array of n times d elements from N(0, 1);
X = randn(sample_size, sapce_dimension);
% compute norm of every row
X_norm = sqrt(sum(X.^2, 2));
% compute Y
Y = X ./ X_norm;


%% Vizualization

% draw only if dimension can be worked with
projection_note = "";
switch sapce_dimension
    case 1
        % if only 1d, do not continue
        return
    case 2
        % if only 2d, add third coordinate with only zero values
        Y = [Y, zeros(sample_size, 1)];
    case 3
        % 3d case can be drawn without changes
    otherwise
        % if higher dimensions, only projection to 3d will be shown
        projection_note = " (projection)";
end

hf = figure( ...
    "Name", "isotropic_in_nd",...
    "Color", "white");
hold on

% draw random points
scatter3(Y(:, 1), Y(:, 2), Y(:, 3), ". black",...
    "DisplayName", "Random Sample")
% draw point (0, 0, 0) for orientation
scatter3(0, 0, 0, "filled", "red",...
    "DisplayName", "(0, 0, 0)")

% remove axis to look better in 3d
axis vis3d off

% add legend with title
hl = legend("Location", "southeast");
title(hl, "Isotropic Directions in " + sapce_dimension + "d" + projection_note)

% run animation while figure window is open
angl = 1;
while isgraphics(hf) && run_animation
    view(angl, 90 - abs(angl - 180))
    angl = mod(angl + 1, 360);
    drawnow
end
