clc
function [I] =Simpson(x,y)
%This function uses the the Simpson 1/3 rule to integrate a set of data
%Note- If the array has an odd number of spaces the Tapezoidal rule will be
%applied to the last interval.
%   x- values depicting the spacing between each y value along the x axis
%   y- the data points for each corresponding x value
%   I- the integral of the data

n=length(x);
m=length(y);
sum1=0;
sum2=0;

if n~=m
    error('Inputs are not the same length.')
end

s=linspace(x(1),x(n),n);

if isequal(s,x)==0
    error('Interval spacing is not even.')
end

if mod(n-1,2)==1
    for i=1:2:n-1
        sum1=sum1+y(i);
    end
    for j=2:2:n-2
        sum2=sum2+y(j);
    end
    I=((x(2)-x(1))/3)*(y(1)+4*sum1+2*sum2+y(n));
else
    warning('One tapezoidal iteration used')
    for i=1:2:n-2
        sum1=sum1+y(i);
    end
    for j=2:2:n-3
        sum2=sum2+y(j);
    end
    trap=(x(n)-x(n-1))*((y(n)+y(n-1))/2);
    I=((x(2)-x(1))/3)*(y(1)+4*sum1+2*sum2+y(n-1))+trap;
end

end

