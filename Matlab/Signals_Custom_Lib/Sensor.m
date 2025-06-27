classdef Sensor 
    properties (Access = public)
        name;
        x;
        y;
        z;
        mag;
        arrX;
        arrY; 
        arrZ;
        arrMag;
    end

    methods (Access = public)

        function obj = Sensor(name)
            % Constructor
            samples = 25;
            obj.name = name;
            obj.arrX = zeros(1, samples);
            obj.arrY = zeros(1, samples);
            obj.arrZ = zeros(1, samples);
            obj.arrMag = zeros(1, samples);
        end

        function obj = update(obj, x, y, z, i)
            % Update sensor data and store in arrays
            obj.x = x;        
            obj.y = y;            
            obj.z = z;            
            obj.arrX(i) = x;
            obj.arrY(i) = y;
            obj.arrZ(i) = z; 
            temp = norm([x,y,z]);
            obj.mag = temp;
            obj.arrMag(i) = temp;
        end

        function [avgX, avgY, avgZ, avgMag] = getaverage(obj)
            % Calculate averages
            avgX = mean(obj.arrX);
            avgY = mean(obj.arrY);
            avgZ = mean(obj.arrZ);
            avgMag = mean(obj.arrMag);
        end

        function [modeX, modeY, modeZ, modeMag] = getmode(obj)
            % Calculate mode
            modeX = mode(obj.arrX);
            modeY = mode(obj.arrY);
            modeZ = mode(obj.arrZ);
            modeMag = mode(obj.arrMag);
        end

        function [medX, medY, medZ, medMag] = getmedian(obj)
            % Calculate median
            medX = median(obj.arrX);
            medY = median(obj.arrY);
            medZ = median(obj.arrZ);
            medMag = median(obj.arrMag);
        end

        function showRaw(obj)
            % Display raw sensor values
            fprintf('%s Raw = %.2f, %.2f, %.2f\n', obj.name, obj.x, obj.y, obj.z);
        end

        function showAvg(obj)
            % Display average values
            [avgX, avgY, avgZ] = obj.getaverage();
            fprintf('%s Avg = %.2f, %.2f, %.2f\n', obj.name, avgX, avgY, avgZ);
        end

        function showMedian(obj)
            % Display median values
            [medX, medY, medZ] = obj.getmedian();
            fprintf('%s Median = %.2f, %.2f, %.2f\n', obj.name, medX, medY, medZ);
        end

        function showMode(obj)
            % Display mode values
            [modeX, modeY, modeZ] = obj.getmode();
            fprintf('%s Mode = %.2f, %.2f, %.2f\n', obj.name, modeX, modeY, modeZ);
        end

        function [a, b, c, mag] = getAccel(obj)
            % Calculate acceleration and magnitude
            % a = (1/16370) * (obj.x - 102);
            % b = (1/16390) * (obj.y - 168);
            % c = (1/16290) * (obj.z + 1483);
            a = (1/4091) * (obj.x - 109);
            b = (1/4095) * (obj.y - 45);
            c = (1/4170) * (obj.z + 150);
            obj.mag = sqrt(a^2 + b^2 + c^2);
            mag = obj.mag;
        end

        function [a, b, c] = getGyro(obj)
            % Retrieve gyroscope data
            a = obj.x;
            b = obj.y;
            c = obj.z;
        end

        function showAccel(obj)
            % Display acceleration values
            [a, b, c, obj.mag] = obj.getAccel();
            fprintf('%s Accel = %.2f, %.2f, %.2f, Mag = %.2f\n', obj.name, a, b, c, obj.mag);
        end

        function showGyro(obj)
            % Display gyroscope values
            [a, b, c] = obj.getGyro();
            fprintf('%s Gyro = %.2f, %.2f, %.2f\n', obj.name, a, b, c);
        end
    end
end


