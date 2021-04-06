% pass function as parameter
function visualiseConvergence1(y)
    % create matrix for storing values
    syms f(x);
    f(x) = y;
    dataX = -10:0.02:10; % stores values in required range at evenly spaced increments
    %dataX = -5:1:5;
    dataY = zeros(1000); % creates empty matrix
    firstBad = 1001;        % set to 1001 as outside limit but 
    df = matlabFunction(diff(f));
    
    
    for i = 1:1000
        % do this for each value in dataX
        
        dataY(i) = f(dataX(i));
        %result = Newton(f, df, dataX(i), 0.00001, 100);
        result = Newton(f, df, 0, 0.00001, 100);

        if isnan(result)
            % if NaN Newton method failed
            % do nothing
        elseif isnan(firstBad)
            % do nothing, result has failed but first bad already recorded
        else
            firstBad = i; % first point where position does not lead to convergence
        end
        fprintf('Iteration : %d.\n', i);
        %disp('Iteration: ' i '\n');
    end
    
    plot(dataX(1:firstBad-1), dataY(1:firstBad-1), "-b"); % data that converges plots in blue
    hold on;
    if firstBad <= 1000
        plot(dataX(firstBad : 1000), dataY(firstBad:1000), "-r"); % data that does not converge in red
    end
end
    