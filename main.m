clc;
clear;
close all;

datasetPath = 'dataset/';

audioFiles = dir(fullfile(datasetPath, '*.wav'));

features = [];
labels = [];

for i = 1:length(audioFiles)

    fileName = audioFiles(i).name;
    filePath = fullfile(datasetPath, fileName);

    [featureVector, emotion] = extractFeatures(filePath);

    features = [features; featureVector];
    labels = [labels; string(emotion)];

end

save('features/features.mat', 'features', 'labels');

disp('Feature Extraction Completed');