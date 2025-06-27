clc; clear; close all;

addpath("Signals_Custom_Lib");
tools = utils(4,1);

%% Declarations
MAG = 2/500;
n = 0:499; % Define highpass filter
highpass = u(n, 1) - u(n, 250);


%% Load data
zimus = load('myDataZ.mat').imuObjects;
speeds = load('speeds.mat').speedValues; 



for i = 1:19
        fileNum = i; % Change file num here 
        imu1 = zimus{fileNum};
    
%% testing DC offset for sum
        % temp = abs((imu1.accelerometer.arrX.^2 + imu1.accelerometer.arrY.^2 + imu1.accelerometer.arrZ.^2).^(1));
        % % tools.splot(temp, 4, "MAGG", "c-");
        % % plotFFT(temp, highpass, n, 'c-', 'MAGG', 4, MAG, tools);
        % M = (fft(temp)); M(1)*MAG
        calculatePower(imu1.accelerometer.arrX)
        calculatePower(imu1.accelerometer.arrY)
        calculatePower(imu1.accelerometer.arrZ)
        calculatePower(imu1.accelerometer.arrMag)
        
    
%% Plot Time-Domain Data
        % figure("Name", "Accelerometer | Speed =" + speeds(fileNum));
        % tools.splot(imu1.accelerometer.arrX, 1, "X", "r-");
        % tools.splot(imu1.accelerometer.arrY, 2, "Y", "g-");  
        % tools.splot(imu1.accelerometer.arrZ, 3, "Z", "b-");
        % tools.splot(imu1.accelerometer.arrMag, 4, "MAG", "c-");
        
        
%% Plot Frequency-Domain Data
        % figure("Name", "Accelerometer Fourier | Speed =" + speeds(fileNum));
        % plotFFT(imu1.accelerometer.arrX, highpass, n, 'r-', 'X', 1, MAG, tools);
        % plotFFT(imu1.accelerometer.arrY, highpass, n, 'g-', 'Y', 2, MAG, tools);
        % plotFFT(imu1.accelerometer.arrZ, highpass, n, 'b-', 'Z', 3, MAG, tools);
        % plotFFT(imu1.accelerometer.arrMag, highpass, n, 'c-', 'MAG', 4, MAG, tools);
        
        
%% Output Algorithm %Extract peaks for each axis
        % locsX = extractPeaks(imu1.accelerometer.arrX, highpass);
        % locsY = extractPeaks(imu1.accelerometer.arrY, highpass);
        % locsZ = extractPeaks(imu1.accelerometer.arrZ, highpass);
        % locsMag = extractPeaks(imu1.accelerometer.arrMag, highpass);
        % 
        % allLocs = [locsX, locsY, locsZ, locsMag];
        % mostRepeatedLoc = mode(allLocs);
        % finalResult = 23.6617 * mostRepeatedLoc - 15.8953;        
        % 
        % X = abs(fft(imu1.accelerometer.arrX)); X(mostRepeatedLoc)*MAG
        % Y = abs(fft(imu1.accelerometer.arrY)); Y(mostRepeatedLoc)*MAG
        % Z = abs(fft(imu1.accelerometer.arrZ)); Z(mostRepeatedLoc)*MAG
        % M = abs(fft(imu1.accelerometer.arrMag)); M(mostRepeatedLoc)*MAG
end



%% Functions

function plotFFT(signal, filter, n, color, label, plotNum, MAG, tools)
    % Compute FFT
    fftSignal = fft(signal) .* filter;
    ampSignal = abs(fftSignal);
    threshold = 0.1 * max(ampSignal);
    filteredFFT = fftSignal .* (ampSignal > threshold & ampSignal > 0.01);
    
    % Apply MAG scaling
    filteredFFT = filteredFFT * MAG;
    
    % Plot
    tools.plot(n, abs(filteredFFT), plotNum, label, color);
end

function locs = extractPeaks(signal, filter)
    % Compute FFT
    fftSignal = fft(signal) .* filter;
    ampSignal = abs(fftSignal);
    threshold = 0.1 * max(ampSignal);
    
    % Apply filtering conditions
    validIndices = (ampSignal > threshold) & (ampSignal > 0.1);
    filteredFFT = fftSignal .* validIndices;
    
    % Find peaks
    [~, locs] = findpeaks(abs(filteredFFT), 'SortStr', 'descend', 'NPeaks', 5);
end

function power = calculatePower(signal)
    X = fft(signal);
    power = sum(abs(X).^2) / length(X); % Average power
end


