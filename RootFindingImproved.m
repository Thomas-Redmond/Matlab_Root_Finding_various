% More efficent Root finding method
% Runs BisectionInit.m
% Runs Bisection.m 5 times
% Runs Ost to find final answer

% Test Data
% @(x) (x^5)/1024+(3*x^4)/256-(5*x^3)/64-(15*x^2)/16+x+12
% 0
% 1
% 0.00001
% 100
function p = RootFindingImproved(f, a, b, TOL, N0)
    [a, b] = BisectionInitialise2(f, a, b); % Return better starting positions
    p = Bisection(f, a, b, TOL, 5); % run 5 times for better starting value
    p = Ostrowski(f, df, p, TOL, N0);
    
    printf("Value Returned = %d", p);
    clear;
end