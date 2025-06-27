clc;
addpath("Signals_Custom_Lib\");
tools = utils(1,4);

speeds = load('speeds.mat').speedValues;  
count = length(speeds);  

zimus = load('myDataZ.mat').imuObjects;


arrX = zeros(1,count);
arrY = zeros(1,count);
arrZ = zeros(1,count);
arrMag = zeros(1,count);

for i = 1:count

    [arrX(i), arrY(i), arrZ(i), arrMag(i)] = ...
        zimus{i}.gyroscope.getaverage;
    var="z";
end

%figure
tools.plot(speeds, arrX, 1, var+" ::X", 'r-');
tools.plot(speeds, arrY, 2, var+" ::Y", 'b-');
tools.plot(speeds, arrZ, 3, var+" ::Z", 'g-');
%arrMag = arrX + arrY;
tools.plot(speeds, arrMag, 4, var+" ::Mag", 'k--');
arrX



% n = 0:18;
% temp = (speeds-0.506099)/0.0101521;
% 
% bandpass = u(n,0) - u(n,1);
% new_fft = fft(arrZ) .* bandpass;
% new_f = ifft(new_fft);
% 
% tools.plot(speeds, temp, 3, var+" ::X", 'r-');
% tools.fplot(n,fft(temp),4, "Fourier", 'b-');
% 
% tools.plot(speeds, new_f, 5, var+" ::X", 'r-');
% tools.fplot(1:19,new_fft,6, "Fourier", 'b-');





