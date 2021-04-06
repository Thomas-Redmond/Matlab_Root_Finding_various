% pass function as parameter
function visualiseConvergence1(y)    
    tic;    
% create matrix for storing values
    runFor = 1000; % change variable to change 

    syms f(x);
    f(x) = y;
    df = matlabFunction(diff(f));
    dataX = -10:(20/runFor):10; % stores values in required range at evenly spaced increments
    dataY = arrayfun(y , dataX); % performs function y on each element of dataX storing in dataY
    firstBad = runFor+1;        % set to 1001 as outside limit but 
    
    
    
    for i = 1:runFor
        % do this for each value in dataX
        result = Newton(f, df, dataX(i), 0.00001, 100);

        if isnan(result) && firstBad == runFor + 1
            % Newton timed-out + first bad not already recorded
            firstBad = i;
        end
        % display current iteration for debugging purposes
        %fprintf('Iteration : %d.\n', i);
        
    end
    
    plot(dataX(1:firstBad-1), dataY(1:firstBad-1), "-b"); % data that converges plots in blue
    hold on;
    if firstBad <= runFor
        plot(dataX(firstBad : runFor), dataY(firstBad:runFor), "-r"); % data that does not converge in red
    end
    toc;
end
    