% pass function as parameter
function visualiseConvergence1(y)    
    % Function takes approximately 135 seconds for 1000 iteration
    tic;    % start function speed timer
    runFor = 10; % change variable to change for iterations on testdata

    syms f(x);
    f(x) = y;   % store function given as parameter as symbolic
    df = matlabFunction(diff(f));   % store differentiated function as df
    dataX = -10:(20/runFor):10; % stores values in required range at evenly spaced increments
    dataY = arrayfun(y , dataX); % performs function y on each element of dataX storing in dataY
    firstBad = runFor+1;        % set to just outside limit
    
    
    
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
    
    GraphNewton = graph();
    
    
    hold on;
    if firstBad <= runFor
        plot(dataX(firstBad - 1 : firstBad), dataY(firstBad - 1 : firstBad), "-black"); % plots data that between converge and not
        plot(dataX(firstBad : runFor), dataY(firstBad:runFor), "-r"); % data that does not converge in red
    end
    plot(dataX(1:firstBad-1), dataY(1:firstBad-1), "-b"); % data that converges plots in blue
    
    title("Newton graph for function: " + char(y));
    legend("Data not available", "Does not converge within limit", "Converges");
    
    toc;
    clear;
end
    