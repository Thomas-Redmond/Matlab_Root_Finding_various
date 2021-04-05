% pass function as parameter
function visualiseConvergence1(y)
    % create matrix for storing values
    syms f(x);
    f(x) = y;
    %dataX = -10:0.02:10; % stores values in required range at evenly spaced increments
    dataX = -5:1:5;
    dataY = zeros(1000); % creates empty matrix
    firstBad = NaN;
    df = matlabFunction(diff(f));
    
    % reduced from 1000 to 10 for testing purposes
    for i = 1:10
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
            firstBad = i;
        end
        
    end
    
    plot(dataX(1:10), dataY(1:10), "-b");
    hold on;
    %plot(dataX(firstBad+1 : 1000), dataY(firstBad+1:1000), "-r");
end
    