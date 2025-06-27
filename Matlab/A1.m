clc; clear;close all;
addpath("Signals_Custom_Lib");


%init
if (~exist('device', 'var') || isempty(device))
    device = serialport("COM3", 9600); 
end


imu1 = IMU();
i = 1;
samples=25;
data = readline(device);

%___________
h = figure;
plotHandleX = plot(NaN, 'r-');
hold on;
plotHandleY = plot(NaN, 'g-');
plotHandleZ = plot(NaN, 'b-');
plotHandleMag = plot(NaN, 'k-');
ylim([-2 2]);  % Adjust based on the expected range of your data
%___________
tempX = zeros(1,samples);
tempY = zeros(1,samples);
tempZ = zeros(1,samples);
tempMag = zeros(1,samples);


tic;
t1=0;
t2=0;
v=0;
d=0;
while true
    try
        
        %% main loop
        [x,y,z,gx,gy,gz] = str2vector(readline(device));
        imu1.accelerometer = imu1.accelerometer.update(x, y, z, i);
        
        imu1.gyroscope=imu1.gyroscope.update(gx,gy,gz,i)
        [tempX(i),tempY(i),tempZ(i), tempMag(i)] = imu1.accelerometer.getAccel();
        imu1.accelerometer.showAccel();
        imu1.accelerometer.showRaw;
        imu1.accelerometer.showMedian();
        imu1.accelerometer.showAvg();
        imu1.accelerometer.showMode();
        
        disp(" ");
        


        i = i+1;
        if mod(i, 2) == 0
          t1=toc;
        else
          t2=toc;
        end
        dt=abs(t2-t1);

        if (i==samples)
            i=1;
            tempX = zeros(1,samples);
            tempY = zeros(1,samples);
            tempZ = zeros(1,samples);
            tempMag = zeros(1,samples);
        end
        plt(plotHandleX, plotHandleY, plotHandleZ, plotHandleMag, tempX, tempY, tempZ, tempMag);
        [a, b, c, mag] = imu1.accelerometer.getAccel();
        % pitch = rad2deg(atan2(c,sqrt(a^2+b^2)))
        % roll  = rad2deg(atan2(b,sqrt(a^2+c^2)))
        % 
        % if(round(mag,1)~=1)
        %      [v,d] = getDistance(mag,dt,v,d);
        % end
        % d



    catch ME
        disp("Error reading data from serial port: ");
        disp(ME.message);
        break;
    end
end


clear device;







function [x,y,z,gx,gy,gz] = str2vector(str)
    values = str2double(strsplit(str, ','));
    x = values(1);
    y = values(2);
    z = values(3);
    gx = values(4);
    gy = values(5);
    gz = values(6);

end


function [] = plt(plotHandleX, plotHandleY, plotHandleZ,plotHandleMag, arrX, arrY, arrZ,arrMag)
    set(plotHandleX, 'XData', 1:length(arrX), 'YData', arrX);
    set(plotHandleY, 'XData', 1:length(arrY), 'YData', arrY);
    set(plotHandleZ, 'XData', 1:length(arrZ), 'YData', arrZ);
    set(plotHandleMag, 'XData', 1:length(arrMag), 'YData', arrMag);
    drawnow;
end

function [v,d] =getDistance(a,dt,v,d)
    v1=a*dt;
    v=v+v1;
    d1=v*dt;
    d=d+d1;
    % d = 0.5*a*dt^2 + d;
end
