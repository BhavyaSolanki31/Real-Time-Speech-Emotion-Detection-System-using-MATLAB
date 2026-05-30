clc;
clear;

load('models/emotionModel.mat');

recObj = audiorecorder(44100,16,1);

disp('Start Speaking...');

recordblocking(recObj,5);

disp('Recording Complete');

audio = getaudiodata(recObj);

audiowrite('recordings/test.wav', audio, 44100);

[featureVector, ~] = extractFeatures('recordings/test.wav');

prediction = predict(model,featureVector);

if iscell(prediction)
    prediction = prediction{1};
end

predictedEmotion = string(prediction);
disp(['Emotion Detected: ', char(prediction)]);