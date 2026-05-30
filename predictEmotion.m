clc;
clear;

load('models/emotionModel.mat');

[file, path] = uigetfile('*.wav');

filePath = fullfile(path, file);

[featureVector, ~] = extractFeatures(filePath);

prediction = predict(model,featureVector);

if iscell(prediction)
    prediction = prediction{1};
end

predictedEmotion = string(prediction);

disp(['Predicted Emotion: ', char(prediction)]);