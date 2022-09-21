%% Generation of PDF Reports From All Example Scripts
%%
close all
clear variables
clc


report_folder = fullfile(cd, "reports");
mkdir(report_folder)

for file = dir("src/**/*_example.m").'

    [~, core_name, extension] = fileparts(file.name);
    
    old_name = fullfile(file.folder, file.name);
    new_name = fullfile(file.folder, core_name + ".mlx");
    new_name = new_name{1};
    report_name = fullfile(report_folder, core_name + "_report.pdf");
    report_name = report_name{1};   
    
    matlab.internal.liveeditor.openAndSave(old_name, new_name);
    
    save()
    matlab.internal.liveeditor.executeAndSave(new_name);
    load()
    
    matlab.internal.liveeditor.openAndConvert(new_name, report_name);
    
    delete(new_name)    
end

delete("matlab.mat")
