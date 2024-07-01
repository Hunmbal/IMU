clc; clear;
addpath("Signals_Custom_Lib");


%init
if (~exist('device', 'var') || isempty(device))
    device = serialport("COM3", 9600); 
end


imu1 = IMU();
i = 1;
samples=1000;
data = readline(device);
%_______________________________
h = figure;
plotHandle = plot(imu1.accelerometer.arrZ);
ylim([17600 17800]);  % Adjust based on the expected range of your data
%_______________________________

while true
    try
        %% main loop
        [x,y,z] = str2vector(readline(device));
        imu1.accelerometer = imu1.accelerometer.update(x, y, z, i);
        imu1.accelerometer.showAvg();
        imu1.accelerometer.showMedian();
        imu1.accelerometer.showMode();
        disp(" ")

        i = i+1;
        if (i==samples)
            i=1;
        end
        
        plt(plotHandle, imu1.accelerometer.arrZ);




    catch ME
        disp("Error reading data from serial port: ");
        disp(ME.message);
        break;
    end
end


clear device;







function [x,y,z] = str2vector(str)
    values = str2double(strsplit(str, ','));
    x = values(1);
    y = values(2);
    z = values(3);
end


function [] = plt(plotHandle, arr) 
    set(plotHandle, 'data', arr);
    drawnow;    
end




