clc; clear;
addpath('Signals_Custom_Lib');


%init
% if (~exist('device', 'var') || isempty(device))
%     device = serialport('COM3', 9600); 
% end

bt = bluetooth('IMU_device', 1);


imu1 = IMU();
i=1;
samples=1000;
% data = readline(device);
data = readline(bt);

%___________ acc
h = figure;
plotHandleX = plot(NaN, 'r-');
hold on;
plotHandleY = plot(NaN, 'g-');
plotHandleZ = plot(NaN, 'b-');
ylim([-2 2]);  % Adjust based on the expected range of your data
tempX = zeros(1,1000);
tempY = zeros(1,1000);
tempZ = zeros(1,1000);
%___________ gyro
% h2 = figure;
% plotHandleX2 = plot(NaN, 'r-');
% hold on;
% plotHandleY2 = plot(NaN, 'g-');
% plotHandleZ2 = plot(NaN, 'b-');
% %ylim([-2 2]);  % Adjust based on the expected range of your data
% tempX2 = zeros(1,1000);
% tempY2 = zeros(1,1000);
% tempZ2 = zeros(1,1000);
%___________



while true
    try
        % [x,y,z,a,b,c] = str2vector(readline(device));
        [x,y,z,a,b,c] = str2vector(readline(bt));
        % imu1.gyroscope = imu1.gyroscope.update(a,b,c, i);
        imu1.accelerometer = imu1.accelerometer.update(x, y, z, i);

        [tempX(i),tempY(i),tempZ(i)] = imu1.accelerometer.getAccel();
        % [tempX2(i),tempY2(i),tempZ2(i)] = imu1.gyroscope.getGyro();

        % i
        % imu1.gyroscope.showRaw();
        % imu1.gyroscope.showMedian();
        % imu1.gyroscope.showAvg();
        % imu1.gyroscope.showMode();
        disp(' ');
        % 
                % i
        imu1.accelerometer.showRaw();
        imu1.accelerometer.showMedian();
        imu1.accelerometer.showAvg();
        imu1.accelerometer.showMode();
        disp(' ');
        % 


        i = i+1;
        if (i==samples)
            i=1;
            tempX = zeros(1,1000);
            tempY = zeros(1,1000);
            tempZ = zeros(1,1000);
            % tempX2 = zeros(1,1000);
            % tempY2 = zeros(1,1000);
            % tempZ2 = zeros(1,1000);
        end
        plt(plotHandleX, plotHandleY, plotHandleZ, tempX, tempY, tempZ);
        %plt(plotHandleX2, plotHandleY2, plotHandleZ2, tempX2, tempY2, tempZ2);



     catch ME
        disp('Error reading data from serial port: ');
        disp(ME.message);
     break;
    end
   
end

function [x,y,z,a,b,c] = str2vector(str)
    values = str2double(strsplit(str, ','));
    x = values(1);
    y = values(2);
    z = values(3);
    a = values(4);
    b = values(5);
    c = values(6);
end

function [] = plt(plotHandleX, plotHandleY, plotHandleZ, arrX, arrY, arrZ)
    set(plotHandleX, 'XData', 1:length(arrX), 'YData', arrX);
    set(plotHandleY, 'XData', 1:length(arrY), 'YData', arrY);
    set(plotHandleZ, 'XData', 1:length(arrZ), 'YData', arrZ);
    drawnow;
end