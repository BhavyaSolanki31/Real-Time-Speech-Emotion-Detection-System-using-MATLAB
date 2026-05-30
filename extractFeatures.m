function [featureVector, emotion] = extractFeatures(filePath)

[audio, fs] = audioread(filePath);

if size(audio,2) > 1
    audio = mean(audio,2);
end

audio = audio ./ max(abs(audio));

%% MFCC
coeffs = mfcc(audio,fs);
mfccMean = mean(coeffs,1);

%% Zero Crossing Rate
zcr = zerocrossrate(audio);
zcrMean = mean(zcr);

%% Energy
energy = sum(audio.^2);

%% RMS
rmsVal = rms(audio);

%% Pitch
pitchVals = pitch(audio,fs);
pitchMean = mean(pitchVals);
pitchStd = std(pitchVals);

%% Spectral Centroid
X = abs(fft(audio));
f = (0:length(X)-1)*(fs/length(X));

spectralCentroid = sum(f'.*X)/sum(X);

%% Spectral Spread
spectralSpread = sqrt(sum(((f'-spectralCentroid).^2).*X)/sum(X));

%% Feature Vector
featureVector = [ ...
    mfccMean ...
    zcrMean ...
    energy ...
    rmsVal ...
    pitchMean ...
    pitchStd ...
    spectralCentroid ...
    spectralSpread];

%% Emotion Label Extraction
[~,name,~] = fileparts(filePath);

parts = split(name,'-');

if length(parts) >= 3

    emotionCode = parts{3};

    switch emotionCode
        case '01'
            emotion = "Neutral";

        case '03'
            emotion = "Happy";

        case '04'
            emotion = "Sad";

        case '05'
            emotion = "Angry";

        otherwise
            emotion = "Unknown";
    end

else
    emotion = "Unknown";
end

end