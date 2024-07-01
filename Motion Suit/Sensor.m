classdef Sensor 
    properties (Access = public)
        x
        y
        z
        arrX;
        arrY;
        arrZ;
    end

    methods (Access = public)

        function obj = Sensor()
            obj.arrX= zeros(1, 1000);
            obj.arrY= zeros(1, 1000);
            obj.arrZ= zeros(1, 1000);
        end
        function obj = update(obj, x,y,z, i)
            obj.x = x;            
            obj.arrX(i) = x;
            obj.y = y;            
            obj.arrY(i) = y;
            obj.z = z;            
            obj.arrZ(i) = z; 
        end
        function [avgX, avgY, avgZ] = getaverage(obj)
            avgX=mean(obj.arrX);
            avgY=mean(obj.arrY);
            avgZ=mean(obj.arrZ);
        end
        function [modeX, modeY, modeZ] = getmode(obj)
            modeX=mode(obj.arrX);
            modeY=mode(obj.arrY);
            modeZ=mode(obj.arrZ);
        end
        function [medX, medY, medZ] = getmedian(obj)
            medX=median(obj.arrX);
            medY=median(obj.arrY);
            medZ=median(obj.arrZ);
        end
        function [] = show(obj)
            fprintf("Accelerometer = %.2f,%.2f,%.2f \n", obj.x, obj.y, obj.z);
        end
        function [] = showAvg(obj)
            [avgX, avgY, avgZ] = getaverage(obj);
            fprintf("Accelerometer Avg = %.2f,%.2f,%.2f \n", avgX, avgY, avgZ);
        end
        function [] = showMedian(obj)
            [medX, medY, medZ] = getmedian(obj);
            fprintf("Accelerometer Median = %.2f,%.2f,%.2f \n", medX, medY, medZ);
        end
        function [] = showMode(obj)
            [modeX, modeY, modeZ] = getmode(obj);
            fprintf("Accelerometer Mod = %.2f,%.2f,%.2f \n", modeX, modeY,modeZ);
        end

    end

end 

