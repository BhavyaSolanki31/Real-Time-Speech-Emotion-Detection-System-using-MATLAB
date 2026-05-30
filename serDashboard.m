clc;
clear;
close all;

%% LOAD MODEL
load('models/emotionModel.mat');

global ax1 ax2 model currentAudio currentFs ...
       emotionLabel statusLabel historyTable

%% MAIN WINDOW
fig = uifigure( ...
    'Name','Real Time Speech Emotion Recognition Dashboard', ...
    'Position',[100 50 1600 900], ...
    'Color',[0.05 0.05 0.08]);

%% HEADER
header = uipanel(fig,...
    'Position',[0 820 1600 80],...
    'BackgroundColor',[0 0.45 0.74]);

uilabel(header,...
    'Text','REAL TIME SPEECH EMOTION RECOGNITION SYSTEM',...
    'FontSize',30,...
    'FontWeight','bold',...
    'FontColor','white',...
    'Position',[30 15 800 50]);

clockLabel = uilabel(header,...
    'Text',datestr(now,'yyyy-mm-dd HH:MM:SS'),...
    'FontSize',20,...
    'FontWeight','bold',...
    'FontColor','white',...
    'Position',[1200 20 350 40]);

%% CLOCK TIMER
clockTimer = timer( ...
    'ExecutionMode','fixedRate', ...
    'Period',1, ...
    'TimerFcn',@(~,~)updateClock());

start(clockTimer);

%% BUTTONS

recordBtn = uibutton(fig,'push',...
    'Text','🎤 RECORD AUDIO',...
    'Position',[80 730 260 50],...
    'FontSize',22,...
    'FontWeight','bold',...
    'BackgroundColor',[0 0.75 0],...
    'FontColor','white',...
    'ButtonPushedFcn',@(btn,event)recordAudio());

uploadBtn = uibutton(fig,'push',...
    'Text','📂 UPLOAD AUDIO',...
    'Position',[390 730 260 50],...
    'FontSize',22,...
    'FontWeight','bold',...
    'BackgroundColor',[0 0.5 0.85],...
    'FontColor','white',...
    'ButtonPushedFcn',@(btn,event)uploadAudio());

playBtn = uibutton(fig,'push',...
    'Text','▶ PLAY AUDIO',...
    'Position',[700 730 260 50],...
    'FontSize',22,...
    'FontWeight','bold',...
    'BackgroundColor',[0.9 0.35 0.05],...
    'FontColor','white',...
    'ButtonPushedFcn',@(btn,event)playAudio());

%% STATUS LABEL
statusLabel = uilabel(fig,...
    'Text','STATUS : READY',...
    'Position',[1150 730 350 40],...
    'FontSize',26,...
    'FontWeight','bold',...
    'FontColor',[0 1 0]);

%% WAVEFORM PANEL
wavePanel = uipanel(fig,...
    'Title','Speech Waveform',...
    'Position',[40 360 720 350],...
    'FontSize',18,...
    'ForegroundColor','white',...
    'BackgroundColor',[0.12 0.12 0.15]);

ax1 = uiaxes(wavePanel,...
    'Position',[40 30 630 270]);

ax1.Color = [0.15 0.15 0.17];
ax1.XColor = 'white';
ax1.YColor = 'white';

%% SPECTROGRAM PANEL
specPanel = uipanel(fig,...
    'Title','Speech Spectrogram',...
    'Position',[800 360 720 350],...
    'FontSize',18,...
    'ForegroundColor','white',...
    'BackgroundColor',[0.12 0.12 0.15]);

ax2 = uiaxes(specPanel,...
    'Position',[40 30 630 270]);

ax2.Color = [0.15 0.15 0.17];
ax2.XColor = 'white';
ax2.YColor = 'white';

%% EMOTION PANEL
emotionPanel = uipanel(fig,...
    'Title','Emotion Detection',...
    'Position',[40 40 550 260],...
    'FontSize',18,...
    'ForegroundColor','white',...
    'BackgroundColor',[0.12 0.12 0.15]);

emotionLabel = uilabel(emotionPanel,...
    'Text','NO EMOTION DETECTED',...
    'Position',[60 110 450 60],...
    'FontSize',34,...
    'FontWeight','bold',...
    'HorizontalAlignment','center',...
    'FontColor','white');

%% HISTORY PANEL
historyPanel = uipanel(fig,...
    'Title','Detection History',...
    'Position',[650 40 870 260],...
    'FontSize',18,...
    'ForegroundColor','white',...
    'BackgroundColor',[0.12 0.12 0.15]);

historyTable = uitable(historyPanel,...
    'Position',[20 20 820 180],...
    'ColumnName',{'File','Emotion','Time'},...
    'Data',{});

%% INITIAL VARIABLES
currentAudio = [];
currentFs = 44100;

%% ================= RECORD AUDIO =================
function recordAudio()

global currentAudio currentFs 

    statusLabel.Text = 'STATUS : RECORDING';
    statusLabel.FontColor = [1 0 0];

    recObj = audiorecorder(44100,16,1);

    recordblocking(recObj,5);

    audio = getaudiodata(recObj);

    fs = 44100;

    currentAudio = audio;
    currentFs = fs;

    fileName = 'Recorded Audio';

    processAudio(audio,fs,fileName);

end

%% ================= UPLOAD AUDIO =================
function uploadAudio()

global currentAudio currentFs

    [file,path] = uigetfile('*.wav');

    if isequal(file,0)
        return;
    end

    fullFile = fullfile(path,file);

    [audio,fs] = audioread(fullFile);

    if size(audio,2) > 1
        audio = mean(audio,2);
    end

    currentAudio = audio;
    currentFs = fs;

    processAudio(audio,fs,file);

end

%% ================= PLAY AUDIO =================
function playAudio()

global currentAudio currentFs 

    if isempty(currentAudio)
        uialert(fig,'No audio available','Error');
        return;
    end

    sound(currentAudio,currentFs);

end

%% ================= PROCESS AUDIO =================
function processAudio(audio,fs,fileName)

global ax1 ax2 model emotionLabel statusLabel historyTable

    statusLabel.Text = 'STATUS : PROCESSING';
    statusLabel.FontColor = [1 1 0];

    drawnow;

    %% WAVEFORM
    cla(ax1);

    plot(ax1,audio,...
        'Color',[0 1 0],...
        'LineWidth',1.2);

    title(ax1,'Speech Waveform','Color','white');

    xlabel(ax1,'Samples','Color','white');

    ylabel(ax1,'Amplitude','Color','white');

    grid(ax1,'on');

    %% SPECTROGRAM

cla(ax2);

window = 256;
noverlap = 200;
nfft = 256;

[s,f,t,p] = spectrogram(audio,window,noverlap,nfft,fs);

surf(ax2,t,f,10*log10(abs(p)),...
    'EdgeColor','none');

view(ax2,2);

axis(ax2,'tight');

colormap(ax2,jet);

title(ax2,'Speech Spectrogram','Color','white');

xlabel(ax2,'Time','Color','white');

ylabel(ax2,'Frequency','Color','white');

ax2.XColor = 'white';
ax2.YColor = 'white';

    %% FEATURE EXTRACTION
    %% USE SAME FEATURE EXTRACTION AS TRAINING

tempFile = fullfile('recordings','dashboard_temp.wav');

audiowrite(tempFile,audio,fs);

[featureVector,~] = extractFeatures(tempFile);

disp('Feature Vector Size:')
disp(size(featureVector))

    %% PREDICTION
    disp(size(featureVector))
   prediction = predict(model,featureVector);
   disp('--------------------')
disp('Dashboard Prediction')
disp(prediction)
disp(featureVector(1:5))
disp('--------------------')
if iscell(prediction)
    prediction = prediction{1};
end

predictedEmotion = string(prediction);

    if iscell(prediction)
        predictedEmotion = string(prediction{1});
    else
        predictedEmotion = string(prediction);
    end

    %% UPDATE EMOTION
    emotionLabel.Text = "EMOTION : " + upper(predictedEmotion);
    disp(['Displayed Emotion = ', char(predictedEmotion)])

    switch lower(char(predictedEmotion))

        case 'happy'
            emotionLabel.FontColor = [0 1 0];

        case 'sad'
            emotionLabel.FontColor = [0 0.7 1];

        case 'angry'
            emotionLabel.FontColor = [1 0 0];

        case 'neutral'
            emotionLabel.FontColor = [1 1 1];

        otherwise
            emotionLabel.FontColor = [1 1 0];
    end

    %% STATUS COMPLETE
    statusLabel.Text = 'STATUS : COMPLETED';
    statusLabel.FontColor = [0 1 0];

    %% UPDATE HISTORY
    oldData = historyTable.Data;

    newRow = { ...
        fileName,...
        char(predictedEmotion),...
        datestr(now,'HH:MM:SS')};

    historyTable.Data = [oldData; newRow];

end

%% ================= CLOCK UPDATE =================
function updateClock()

    clockLabel.Text = datestr(now,'yyyy-mm-dd HH:MM:SS');

end

%% ================= CLEANUP =================
fig.CloseRequestFcn = @(src,event)closeDashboard();

function closeDashboard()

    try
        stop(clockTimer);
        delete(clockTimer);
    catch
    end

    delete(fig);

end