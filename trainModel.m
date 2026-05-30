clc;
clear;

load('features/features.mat')

labels = categorical(labels);

model = TreeBagger(200,...
                   features,...
                   labels,...
                   'Method','classification');

if ~exist('models','dir')
    mkdir('models');
end

save('models/emotionModel.mat','model');

disp('Training Completed');