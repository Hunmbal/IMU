classdef IMU
    properties
        accelerometer Sensor;
        gyroscope Sensor;
    end

    methods
        %init
        function obj = IMU()
            obj.accelerometer = Sensor();
            obj.gyroscope = Sensor();
        end

    end

end
