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
    tic;
    
    runFor = 1000 - 1;
    dataX = -10:20/runFor:10;   % make array of data within bounds
    dataY = arrayfun(y, dataX); % perform function y on each element of dataX store in dataY
    
    syms f(x);
    f(x) = y;
    df = matlabFunction(diff(f)); % differentiate the function

    
    % CALL NEWTON
    limit = 10; % set upper limit of roots to find
    resultsNewtonArray = zeros(1, limit); % create empty array to store results
    FuncString = [func2str(y)];
    % casting function to string for function manipulation
    
    funcBody = [FuncString(1:4) + "(" + FuncString(5:strlength(FuncString)) + ")"]; % adding extra brackets for multiplication  later
        
    found = 0;
    index = 1;
    while found == 0 && index <= runFor
        resultNewton = Newton(y, df, dataX(index), 0.00001, 100); % keep checking until root found
        if isnan(resultNewton) % result no found, try again
            index = index + 1;
            continue; % loop through
        else % root found
            found = 1;
                % break out of loop
        end
    end
        

    for i = 1:limit - 1
        resultsNewtonArray(i) = resultNewton; % store value permanently
        
        funcBody = funcBody+ "*(1/x-" + resultNewton + ")"; % update function body to now include division
        
        f(x) = str2sym(funcBody); % convert to symbolic function as string => numeric no good
        y = matlabFunction(f); % convert to numeric function
        df = matlabFunction(diff(f)); % perform differentiation again // not sure if neceressary
        
        resultNewton = Newton(y, df, resultsNewtonArray(i), 0.00001, 100); % using previous value for root
    end
    
    hold on;
    graph1 = figure(1);
    plot(dataX(1:runFor), dataY(1:runFor), "ob", "MarkerSize", 1); % plot results to graph
    hline = refline(0,0); % create a reference line
    plot(resultsNewtonArray(1:size(resultsNewtonArray)), [0*size(resultsNewtonArray)], "or", "MarkerSize", 3); % plot root results on graph in big red blips
    hold off;
    
    
    % end function remove data from workspace
    clear;
    toc;
end