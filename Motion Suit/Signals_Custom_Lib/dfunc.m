%Author: Mustafa Ali #372704
%This class will help you create and manipulate discrete time functions

classdef dfunc
    
    properties 
        domain = []
        data = []
        first = 0
        len = 0
    end

    methods 
        
        %constructor -------------------------------------------------------
        function obj = dfunc(n,x,startpnt)
            
            obj.domain = n;
            obj.first = startpnt;
            obj.len = length(x);

            if startpnt >= n(1)
                x = [zeros(1, startpnt-n(1)), x];
            else
                disp("ERROR!!!!! Domain has to always be larger than the data set (start < n(1))");
            end
            if length(n) >= length(x)
                x = [x, zeros(1,length(n) - length(x))];
            else
                disp("ERROR!!!!! Domain has to always be larger than the data set (x>n at end)");
            end

            obj.data = x;
            utils.getsetMaxValue(max(x));
            utils.getsetMinValue(min(x));
            
        end

        %Shift -------------------------------------------------------------
        function result = shift(obj, offset)
            result = obj;
            f = obj.data;
            if offset > 0
                f = [zeros(1,offset), f];
                temp = f(1:length(f)-offset);
            else
                f = [f, zeros(1,offset*-1)];
                temp = f((offset*-1)+1:length(f));
            end
            result.data = temp;
            result.first = offset+result.first;
        end

        
        %Plot graph --------------------------------------------------------
        function [] = plt(obj, r, c, i, lbl)
            subplot(r,c,i);
            stem(obj.domain,obj.data);
            xlabel(lbl);
            axis([min(obj.domain), max(obj.domain), utils.getsetMinValue, utils.getsetMaxValue]), grid;
        end    
        
        %flip --------------------------------------------------------------
        function result = flip(obj)
            result = obj;
            result.data = flip(result.data);
        end
        
        %convolution -------------------------------------------------------
        %fun fact: adding starting positions of both functions gives the
        %starting position of the answer :)
        %and adding lengths of both -1 gives length of answer :)
        function result = myconv(x,h)
            offset = x.first + h.first;    
            x = x.flip;        
            x = x.shift(offset);            
            answ = zeros(size(x));
            
            for i = 1:(x.len+h.len-1)
                temp = (x.data).*(h.data);
                res = sum(temp);
                answ(i) = res;
                x = x.shift(1);
            end
            result = dfunc(x.domain,answ,offset);        
        end
    
    
    end

end