% Write a modified version of Newton.m to extract multiple roots using the method of deflation.
% solving for the first root r1 of f1(x) = f(x) and then modifying the function 
% to become f2(x) = f1(x)/(x−r1).  
% This process is repeated to extract the set of roots ri from fi(x) = fi−1(x)/(x−ri−1).
% After extracting ri from fi(x) this solution should be refined by updating the initialisation 
% top 0=ri and rerunning Newton’s method on the modified function.
% (Note that at each iteration the function becomes progressively more complicated.)
% Plot the function and the positions of the roots 
function NewtonMulti(y)
    % y is the function in form @(x) (x^5)/1024+(3*x^4)/256-(5*x^3)/64-(15*x^2)/16+x+12
    runFor = 1000 - 1;
    dataX = -10:20/runFor:10;   % make array of data within bounds
    dataY = arrayfun(y, dataX); % perform function y on each element of dataX store in dataY
    
    plot(dataX(1:runFor), dataY(1:runFor), "o", "MarkerSize", 1); % plot results to graph
    hline = refline(0,0); % create a reference line
    
    
    
    % end function remove data from workspace
    clear;
end