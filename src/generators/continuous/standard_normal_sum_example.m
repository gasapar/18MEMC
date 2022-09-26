%% Generation of Standard Normal Sample Using Summation
%%

close all
clear variables
clc


%% Parameters

% define pdf of N(0, 1)
pdf = @(x) normpdf(x);
% sample size
n = 1e4;
% numbers of sum of elements
sum_counts = [1, 2, 3, 12, 50];


%% Generation

% create empty array for all samples
all_samples = nan(n, numel(sum_counts));

% generate for all numbers of sum of elements
for idx = 1:numel(sum_counts)
    % current value of number of sum of elements
    sum_count_now = sum_counts(idx);
    % generate using function defined at the end of this file
    all_samples(:, idx) = generate_by_summation(n, sum_count_now);
end


%% Visualisation

figure("Name", "normal_by_sum")
htl = tiledlayout("flow",...
    "Padding", "tight");

for idx = 1:numel(sum_counts)
    nexttile
    hold on
    
    % draw histogram of generated sample
    hh = histogram(all_samples(:, idx),...
        "FaceAlpha", 1,...
        "FaceColor", "black",...
        "EdgeColor", "white",...
        "Normalization", "pdf",...
        "DisplayName", "histogram");
    
    % draw pdf, N(0, 1)
    hf = fplot(pdf,...
        "LineWidth", 1.5,...
        "Color", [1, 0, 0]);
    
    xlabel("domain")
    ylabel("probability density")
    
    % add title with propper singular case
    if sum_counts(idx) == 1
        title("Using Sum of one Variable")
    else
        title("Using Sum of " + sum_counts(idx) + " Variables")
    end
    
    box on
    grid on
    
    ylim([0, 0.5])
end

nexttile
set(gca, "Visible", "off")
legend(gca(), [hh, hf], "Location", "southeast");


%% Generating Function

function sample = generate_by_summation(sample_size, sum_count)

% generate all needed realizations of U(0, 1)
r_all = rand(sample_size, sum_count);
% sum every row, creating sum of 'sum_count' values
r_sum =  sum(r_all, 2);
% substact expected value
r_sum = r_sum - 0.5 * sum_count;
% devide to obtain unit variance
sample = r_sum / sqrt(sum_count/12);
end
