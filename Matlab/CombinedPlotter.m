clc; clear; close all;

fileNum = 1;

load('myDataZ.mat');
imu1 = imuObjects{fileNum};

%______________________ acc
h = figure;
plotHandleX = plot(NaN, 'r-');
hold on;
plotHandleY = plot(NaN, 'g-');
plotHandleZ = plot(NaN, 'b-');
plotHandleMag = plot(NaN, 'k--');
%ylim([-2 2]);  % Adjust based on the expected range of your data
%______________________ gyro
h2 = figure;
plotHandleX2 = plot(NaN, 'r-');
hold on;
plotHandleY2 = plot(NaN, 'g-');
plotHandleZ2 = plot(NaN, 'b-');
plotHandleMag2 = plot(NaN, 'k--');
%ylim([-2 2]);  % Adjust based on the expected range of your data
%______________________


plt(plotHandleX, plotHandleY, plotHandleZ, plotHandleMag, ...
    imu1.accelerometer.arrX, ...
    imu1.accelerometer.arrY, ...
    imu1.accelerometer.arrZ, ...
    imu1.accelerometer.arrMag);

plt(plotHandleX2, plotHandleY2, plotHandleZ2, plotHandleMag2, ...
    imu1.gyroscope.arrX, ...
    imu1.gyroscope.arrY, ...
    imu1.gyroscope.arrZ, ...
    imu1.gyroscope.arrMag);

function [] = plt(plotHandleX, plotHandleY, plotHandleZ, plotHandleMag, ...
    arrX, arrY, arrZ, arrMag)
    set(plotHandleX, 'XData', 1:length(arrX), 'YData', arrX);
    set(plotHandleY, 'XData', 1:length(arrY), 'YData', arrY);
    set(plotHandleZ, 'XData', 1:length(arrZ), 'YData', arrZ);
    set(plotHandleMag, 'XData', 1:length(arrMag), 'YData', arrMag);
    drawnow;
end
