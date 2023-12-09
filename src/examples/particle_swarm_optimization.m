%% Find Minimum of the Function Using Particle Swarms
%%

close all
clear variables
clc


%% Arguments

space_dimension = 2;

% function to find the minimum of
x_opt =  [1, 1];
Q_form = [1, 1; 1, 3];
objective_function  = @(x)  sum((x - x_opt) .* ((x - x_opt) * Q_form), 2);

inital_search_range = [
    -5, -5; ... 
    5, 5; ...   
    ];

population_size  = 100;
survival_ratio = 0.4;
number_of_generations = 8;


%% Generate Initial Population

population = rand(population_size, space_dimension);
population = population .* diff(inital_search_range) + inital_search_range(1, :);

population_eval = objective_function(population);


%% Generation Evolution

generation_history = evaluateGeneration(population, population_eval);

for idx = 2:number_of_generations
    population = evolvePopulation(population, population_eval, survival_ratio);
    population_eval = objective_function(population);

    generation_history(end + 1) = evaluateGeneration(population, population_eval);
end


%% Plot Generations


figure
tiledlayout("flow", ...
    "TileSpacing", "tight", ...
    "Padding","compact")

for idx = 1:numel(generation_history)

    nexttile
    hold on

    plotInputs(objective_function, x_opt, inital_search_range)

    pop_now = generation_history(idx).Population;
    scatter(pop_now(:, 1), pop_now(:, 2), ". black")

    title("Generation " + idx)

    xlim(inital_search_range(:, 1))
    ylim(inital_search_range(:, 2))
    
    axis equal
    box on
    grid on
end



%% Function

function new_population = evolvePopulation(population, population_eval, survival_ratio)

pop_size = size(population, 1);

% get quntive based on sorvival ratio
q_value = quantile(population_eval, survival_ratio);
is_good = population_eval < q_value;
% select only better part of the population
population = population(is_good, :);

% statistics of the filtered population
population_average = mean(population);
population_covariance = cov(population);

% new population
new_population = mvnrnd(population_average, population_covariance, pop_size);
end


function result_struct = evaluateGeneration(population, population_eval)

result_struct.Population = population;
result_struct.Values = population_eval;
[result_struct.MinValue, result_struct.MinIdx] = ...
    min(result_struct.Values, [], 1);
result_struct.XOpt = result_struct.Population(result_struct.MinIdx, :);
end


function plotInputs(fun, x_opt, ranges)
arguments
    fun (1, 1) function_handle
    x_opt (1, 2) double
    ranges (2, 2) double
end

% plot function contours
f = @(x, y) fun([x(:), y(:)]);
fcontour(@(x, y) arrayfun(f, x, y), ranges(:).')

% plot optimum
scatter(x_opt(1), x_opt(2), "x red")
end
