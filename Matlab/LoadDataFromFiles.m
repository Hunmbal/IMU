clc; clear; close all;
addpath("Signals_Custom_Lib");

speedValues = [0, 30, 60, 120, 180, 240, 300, 360, 420, 480, 540,600, 660, 720, 780, 840, 900, 960, 1020]; % Define the speed values corresponding to your files
numFiles = length(speedValues);
imuObjects = cell(1, numFiles); %Create SPACES for many IMUs


% 1st loop: Loops thru files (only checking z files rn)
for i = 1:numFiles

    filename = sprintf('file_3.00_%.2f_z.txt', speedValues(i));    
    fullPath = fullfile('3_imu', filename);
        
    if exist(fullPath, 'file') ~= 2 % Check if the file exists
        fprintf('File not found: %s\n', fullPath);continue;
    end
        
    fid = fopen(fullPath, 'r'); % Open the file for reading
    if fid == -1
        error('Failed to open file: %s\n', fullPath);
    end
        
    imuObjects{i} = IMU(); % Creates a new IMU object and stores in one of the spaces we created above
    
    
    lineIndex = 1;
    % 2nd loop: reads all the 500 lines one by one
    while ~feof(fid)

        line = fgetl(fid);
        data = sscanf(line, 'AX: %f, AY: %f, AZ: %f, GX: %f, GY: %f, GZ: %f');
        
        line2 = fgetl(fid);

        ax = data(1);
        ay = data(2);
        az = data(3);
        gx = data(4);
        gy = data(5);
        gz = data(6);
        
        % Update accelerometer and gyroscope
        imuObjects{i}.accelerometer = imuObjects{i}.accelerometer.update(ax, ay, az, lineIndex);
        imuObjects{i}.gyroscope= imuObjects{i}.gyroscope.update(gx, gy, gz, lineIndex);

        lineIndex = lineIndex + 1;
    end
    
    fprintf('%s done %.0flines_____________________________\n', fullPath, lineIndex-1);
    fclose(fid);
end
fprintf("files read = %d \n", i);
save('speeds.mat', 'speedValues');
save('myDataZ_3.mat', 'imuObjects'); %Saves data in matlab format so that it can be used again




