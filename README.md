# Real-Time-Speech-Emotion-Detection-System-using-MATLAB
The Real Time Speech Emotion Recognition System is a MATLAB-based machine learning project that analyzes human speech and automatically detects the emotional state of a speaker. The system processes audio signals, extracts meaningful speech features, and classifies emotions using an AI model trained on emotional speech datasets.

---

## Project Overview

This project combines Speech Signal Processing, Machine Learning, and MATLAB GUI Development to detect human emotions from voice recordings.

The system allows users to:

* Record audio in real time
* Upload speech audio files
* Play uploaded recordings
* Visualize speech waveforms
* Generate speech spectrograms
* Detect emotions automatically
* Maintain prediction history through an interactive dashboard

The project demonstrates the practical application of AI in Human-Computer Interaction (HCI), Sentiment Analysis, and Intelligent Communication Systems.

---

## Features

### Audio Processing

* Real-time audio recording
* Audio file upload (.wav)
* Audio playback functionality
* Automatic preprocessing

### Signal Visualization

* Speech waveform analysis
* Spectrogram generation
* Frequency-domain visualization
* Interactive dashboard display

### Emotion Recognition

* Happy
* Sad
* Angry
* Neutral

### AI Integration

* Automatic feature extraction
* Machine Learning based classification
* Real-time emotion prediction
* Detection history tracking

---

## Dashboard Preview

### Main Dashboard Features

* Record Audio
* Upload Audio
* Play Audio
* Speech Waveform Display
* Speech Spectrogram Display
* Emotion Detection Panel
* Detection History Table
* Real-Time Status Monitoring

---

## System Architecture

Speech Input → Preprocessing → Feature Extraction → Trained ML Model → Emotion Prediction → Dashboard Visualization

---

## Feature Extraction

The following speech features are extracted from each audio sample:

* MFCC (Mel Frequency Cepstral Coefficients)
* Zero Crossing Rate (ZCR)
* Signal Energy
* RMS Energy
* Pitch Mean
* Pitch Standard Deviation
* Spectral Centroid
* Spectral Spread

Total Features Extracted: **21**

---

## Machine Learning Model

### Algorithm

Random Forest Classifier (TreeBagger)

### Training Dataset

RAVDESS-based emotional speech dataset

### Emotion Classes

| Emotion Code | Emotion |
| ------------ | ------- |
| 01           | Neutral |
| 03           | Happy   |
| 04           | Sad     |
| 05           | Angry   |

### Model Features

* 200 Decision Trees
* Multi-class Classification
* Speech Feature-Based Prediction

---

## Requirements

### Software

* MATLAB R2025a

### Toolboxes

* Audio Toolbox
* Signal Processing Toolbox
* Statistics and Machine Learning Toolbox

---

## How to Run

### 1. Feature Extraction

```matlab
main
```

### 2. Train Model

```matlab
trainModel
```

### 3. Test Prediction

```matlab
predictEmotion
```

### 4. Real-Time Emotion Detection

```matlab
realtimeTest
```

### 5. Launch Dashboard

```matlab
serDashboard
```

---

## Workflow

1. User uploads or records speech.
2. Audio is preprocessed automatically.
3. Speech features are extracted.
4. Features are passed to the trained model.
5. Emotion is predicted.
6. Dashboard displays:

   * Waveform
   * Spectrogram
   * Predicted Emotion
   * Detection History

---

## Applications

* Human-Computer Interaction
* Emotion-Aware Virtual Assistants
* Customer Sentiment Analysis
* Mental Health Monitoring
* Smart Communication Systems
* E-Learning Platforms
* Call Center Analytics

---

## Future Improvements

* Deep Learning (CNN/LSTM) Integration
* Additional Emotion Classes
* Multilingual Emotion Detection
* Web-Based Deployment
* Cloud Integration
* Mobile Application Support
* Real-Time Streaming Analysis

---

## Author

**Bhavya Solanki**

B.Tech – Electronics & Communication Engineering (ECE) <br>
AI & Machine Learning Enthusiast

---

## Acknowledgements

* MATLAB
* MathWorks Audio Toolbox
* RAVDESS Dataset
* Signal Processing Toolbox

---

### ⭐ If you found this project useful, consider starring the repository!
