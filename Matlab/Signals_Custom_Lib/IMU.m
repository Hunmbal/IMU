classdef IMU
    properties
        accelerometer Sensor;
        gyroscope Sensor;
    end

    methods
        %init
        function obj = IMU()
            obj.accelerometer = Sensor('Accelerometer');
            obj.gyroscope = Sensor('Gyroscope');
        end

    end

end
