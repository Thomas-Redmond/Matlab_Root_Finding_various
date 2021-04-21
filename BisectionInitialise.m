% Improves the initialisation of the Bisection Method.  
% Given the initial range [xmin, xmax] repeatedly subdivide this range to
% find a range that is suitable
% for the Bisection Method; i.e.f(xmin) andf(xmax) should have opposite signs
% Repeat this process for each of the subintervals until a suitable initialisation is found 
% or a pre-specified number has been considered [10].
function [a, b] = BisectionInitialise(f, a, b)
    % f : anymous function
    % a : lower bound 
    % b : higher bound
    tic; % start function timer
    limit = 20; % set limit to iterations
    
    i = 1;
    while i <= limit
        Ya = f(a);
        Yb = f(b);
        if (Ya >= 0 && Yb < 0) || (Ya < 0 && Yb >= 0)
            disp([a b]);
            return; % end function
        else
            a = (a + b) / 2; % a set to midpoint of range
            i = i + 1;
        end
    end
    
    disp([a b]);
end