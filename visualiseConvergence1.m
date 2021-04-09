% pass function as parameter
function visualiseConvergence1(y)    
    tic;    % start function speed timer
    
    runFor = 1000-1; % change variable to change for iterations on testdata; 
    % will run 1000 times at setting 1000 -1 as MATLAB upper limits are inclusive
    % change first number to have correct result
    
    % store function given as parameter as symbolic
    syms f(x);
    f(x) = y; % create symbolic expression for differentiation
    sym_df = diff(f);   % create differentiated function
    
    df = matlabFunction(sym_df); % convert to numerical rather than symbolic
    
    dataX = -10:(20/runFor):10; % stores values in required range at evenly spaced increments
    dataY = arrayfun(y, dataX); % performs function y on each element of dataX storing in dataY
    
    firstGoodNewton = NaN;  % unknown if input gives success
    firstGoodOst = NaN;
    
    firstBadNewton = runFor+1;        % set to just outside limit
    firstBadOst = runFor+1;
    
    for i = 1:runFor
        % do this for each value in dataX
        resultNewton = Newton(y, df, dataX(i), 0.00001, 100);
        resultOst = Ostrowski(y, df, dataX(i), 0.00001, 100);
        
        
        if isnan(firstGoodNewton) && ~isnan(resultNewton) 
            % first good Newton only just encountered
            % may be first input OR a different number
            firstGoodNewton = i;
        end
        
        if isnan(firstGoodOst) && ~isnan(resultOst) 
            % first good Ost only just encountered
            % may be first input OR a different number
            firstGoodOst = i;
        end
        
        
        
        % evaluate this only if the first good data has been returned -
        % otherwised skipped
        if isnan(resultNewton) && firstBadNewton == runFor + 1
            % Newton timed-out + first bad not already recorded
            firstBadNewton = i;
        end
        if isnan(resultOst) && firstBadOst == runFor + 1
            % Newton timed-out + first bad not already recorded
            firstBadOst = i;
            disp(firstBadOst);
        end
        
        % display current iteration for debugging purposes
        %fprintf('Iteration : %d.\n', i);
        
    end
    % PLOTTING DATA SECTION

    % plot non-converging results up to the first converging result
    hold on; % allow multiple lines on same axis
    if isnan(firstGoodNewton) % input data NEVER converged so all should be red
        firstGoodNewton = runFor;
    end
    if isnan(firstGoodOst) % input data NEVER converged so all should be red
        firstGoodOst = runFor;
    end
    % if no convergences occured this will plot all data
    % if convergence occurred this will plot lines up to and including the
    % first good - First good dot gets overwritten at later stage
   
   graph1 = figure(1);
   plot(dataX(1:firstGoodNewton), dataY(1:firstGoodNewton), "or", "MarkerSize", 1);
    
   if firstBadNewton <= runFor
        % if non-convergence occurred after convergence input
        % this need to be plotted in RED
        plot(dataX(firstBadNewton : runFor), dataY(firstBadNewton : runFor), "or", "MarkerSize", 1);
   end
   
   % Good data will overwrite old bad data in overlapping segments
   plot(dataX(firstGoodNewton : firstBadNewton), dataY(firstGoodNewton : firstBadNewton), "ob","MarkerSize", 1);
   
   title("Newton graph for function: " + char(y));
   
   % PLOTTING FOR OST GRAPH
   
   graph2 = figure(2);
   hold on;
   plot(dataX(1:firstGoodOst), dataY(1:firstGoodOst), "or", "MarkerSize", 1);
    
   if firstBadOst <= runFor
        % if non-convergence occurred after convergence input
        % this need to be plotted in RED
        disp("First bad");
        plot(dataX(firstBadOst : runFor), dataY(firstBadOst : runFor), "or", "MarkerSize", 1);
   end
   
   % Good data will overwrite old bad data in overlapping segments
   plot(dataX(firstGoodOst : firstBadOst), dataY(firstGoodOst : firstBadOst), "ob","MarkerSize", 1);
   
   title("Ost graph for function: " + char(y));
   
   hold off;
   toc;
   clear;
end
    