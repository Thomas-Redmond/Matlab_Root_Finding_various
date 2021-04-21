function NewtonMulti(f, df, p0, TOL, N0)
    tic;
    % data for plotting line to graph
    runFor = 1000;
    dataX = -10:20/runFor:10;
    dataY = arrayfun(f, dataX); % perform function y on each element of dataX store in dataY
    
    syms y(x);

    strF = func2str(f); % convert current function to string
    stringFunction = strF(1:4) + "(" + strF(5:strlength(strF))+ ")"; % store current function
    arrayRoots = [];
    limit = 10; % limit for number of roots to find
    
    
    for j = 1:limit % code for handling Newton method
        
        % NEWTON METHOD CODE
        i = 1;
        while i <= N0 % continue whilst max iterations not exceeded
            p = p0 - f(p0)/df(p0); % main function
            if abs(p - p0) < TOL % if difference between p and p0 is under TOL FOUND ANSWER
                break;
            end
            i = i + 1; % coninue loop
            p0 = p; % set this p value as guess
        end
        % END NEWTON METHOD BREAK RESOLVES HERE 
        p0 = 0; % set root to next starting position
        % MUST be non-root due to approximation error
        if isnan(p)
             break; % no more roots leave function
        end
        arrayRoots(j) = p; % store root value permanently
        stringFunction = stringFunction + "*(1/(x-" + p + "))"; % update 
        tempY = str2sym(stringFunction);
        f = matlabFunction(tempY); % convert tempY => syms => Numeric Function
        df = matlabFunction(diff(tempY));

    end
    
    hold on;
    graph1 = figure(1);
    plot(dataX(1:runFor), dataY(1:runFor), "ob", "MarkerSize", 1); % plot results to graph
    hline = refline(0,0); % create a reference line
    disp(arrayRoots);
    disp(size(arrayRoots));
    for i = 1:length(arrayRoots)
        if arrayRoots(i) <= 10 && arrayRoots(i) >= -10 % if within bounds include
            plot(arrayRoots(i), 0 , "or", "MarkerSize", 5);
        end
    end
    %plot(arrayRoots(1:size(arrayRoots)), [0, 0, 0, 0, 0, 0, 0, 0, 0, 0] , "or", "MarkerSize", 3); % plot root results on graph in big red blips
    hold off;
    clear;
    toc;

end