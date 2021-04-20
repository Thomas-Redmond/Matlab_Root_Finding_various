% This function uses Newton.m and Ost.m for complex roots
% Creates a visulisation of the "basins of convergence" => values that
% convert to a specific point
% Assigning a unique colour to each of the roots detected, allocating to a
% pixel that converges to the root
function visualiseConvergence2(f)
    % set starting values
    % sampleRateA = 400;
    % sampleRateB = 400;
    % range of elements a and b in x lie in range [-1, 1]
    tic;
    samplingRate = 400; % testing with 20 values
    rangeOfXValues = -1:(1--1)/(samplingRate-1):1; % 400 values required this will create 20 possible values
    rangeOfValues = zeros(samplingRate, samplingRate); % 20 * 20 = 400 so create 20x20 matrix using values
    
    % get dy/dx of function given as paramenter
    syms y(x);
    y(x) = f;
    df = matlabFunction(diff(y)); % find dy/dx of function
    
    NewtonValues = zeros(samplingRate^2,1);
    OstValues = zeros(samplingRate^2,1);
    
    for i = 1: samplingRate % nasty nested for loop to create values required
        for j = 1: samplingRate
            rangeOfValues(i, j) = complex(rangeOfXValues(i), rangeOfXValues(j));
            NewtonValues((j-1) * samplingRate + i) = Newton&p(f, df, rangeOfValues(i, j), 0.00001, 100); % perform Newton
            OstValues((j-1) * samplingRate + i) = Ostrowski&p(f, df, rangeOfValues(i, j), 0.00001, 100); % perform Ost
        end
    end
    
    
    NewtonRoots = NewtonValues(1);
    OstRoots = OstValues(1);
    
    for i = 1: samplingRate^2
        %fprintf("Comparing %d vs %d\n", NewtonRoots(1), NewtonValues(i)); ||
        if isnan(real(NewtonValues(i))) && isnan(real(NewtonValues(i)))
            % bad data skipping
            %disp("Bad Data Encountered\n");
        elseif isnan(imag(NewtonValues(i))) % just complex values are nan
            NewtonValues(i) = complex(real(NewtonValues(i)), imag(NewtonValues(i)));
            j = 1;
        else
            j = 1;
            while j <= length(NewtonRoots)
                realDifference = abs(real(NewtonValues(i))) - abs(real(NewtonRoots(j)));
                imagDifference = abs(imag(NewtonValues(i))) - abs(imag(NewtonRoots(j)));
                if abs(realDifference) < 0.001 && abs(imagDifference) < 0.001
                    % Identified Match
                    j = length(NewtonRoots) + 1;
                elseif j == length(NewtonRoots)
                    % not identified append to new length
                    NewtonRoots(length(NewtonRoots) + 1) = NewtonValues(i);
                    j = length(NewtonRoots) + 1;
                else % Elements don't match, but not yet searched everything
                    j = j + 1;
                end
            end
        end
        
        if isnan(real(OstValues(i))) && isnan(real(OstValues(i)))
            % bad data skipping
            %disp("Bad Data Encountered\n");
        elseif isnan(imag(OstValues(i))) % just complex values are nan
            OstValues(i) = complex(real(OstValues(i)), imag(OstValues(i)));
            j = 1;
        else
            j = 1;
            while j <= length(OstRoots)
                realDifference = abs(real(OstValues(i))) - abs(real(OstRoots(j)));
                imagDifference = abs(imag(OstValues(i))) - abs(imag(OstRoots(j)));
                if abs(realDifference) < 0.001 && abs(imagDifference) < 0.001
                    % Identified Match
                    j = length(OstRoots) + 1;
                elseif j == length(OstRoots)
                    % not identified append to new length
                    OstRoots(length(OstRoots) + 1) = OstValues(i);
                    j = length(OstRoots) + 1;
                else % Elements don't match, but not yet searched everything
                    j = j + 1;
                end
            end
        end
        
    end
    
    
    
    
    % stores all unique values in list
    NewtonRoots = [NewtonRoots conj(NewtonRoots)];
    NewtonRoots = sort(NewtonRoots, 'ComparisonMethod','real');
    OstRoots = [OstRoots conj(OstRoots)];
    OstRoots = sort(OstRoots, 'ComparisonMethod','real');
    
    
    fig1 = figure(1);
    title('Newton');
    colorMapNewton = colormap(hsv(length(NewtonRoots)));
    imageNewton = zeros(samplingRate, samplingRate, 3);
    for i = 1:length(NewtonValues)
        % identify where to place data
        y = mod((i-1),samplingRate); % truncates value giving y co-ord in non-Matlab indexing
        x = floor( ((i-1) - y) /samplingRate);
        locX = x + 1; % Matlab appropiate indexing
        locY = y + 1; % Matlab appropiate Indexing
        if isnan(real(NewtonValues(i)))
            % bad data hence use midtone grey
            imageNewton(locX, locY, 1) = 0.5;
            imageNewton(locX, locY, 2) = 0.5; % colourScale(1, j);
            imageNewton(locX, locY, 3) = 0.5; % colourScale(1, j);
            j = length(NewtonRoots) +1; % skip next loop
        else
            j = 1; % perform next loop
        end
        while j <= length(NewtonRoots)
        % check which to place
            if abs(abs(real(NewtonRoots(j))) - abs(real(NewtonValues(i)))) <= 0.001 && abs(abs(real(NewtonRoots(j))) - abs(real(NewtonValues(i)))) <= 0.001
                imageNewton(locX, locY, :) = colorMapNewton(j, :);
                j = length(NewtonRoots) + 1;
            end
            j = j +1;
        end
    end
    imshow(imageNewton);
    
    fig1 = figure(2);
    title('Ostrowski');
    colorMapOst = colormap(hsv(length(OstRoots)));
    imageOst = zeros(samplingRate, samplingRate, 3);
    for i = 1:length(OstValues)
        % identify where to place data
        y = mod((i-1),samplingRate); % truncates value giving y co-ord in non-Matlab indexing
        x = floor( ((i-1) - y) /samplingRate);
        locX = x + 1; % Matlab appropiate indexing
        locY = y + 1; % Matlab appropiate Indexing
        if isnan(real(OstValues(i)))
            % bad data hence use midtone grey
            imageOst(locX, locY, 1) = 0.5;
            imageOst(locX, locY, 2) = 0.5; % colourScale(1, j);
            imageOst(locX, locY, 3) = 0.5; % colourScale(1, j);
            j = length(NewtonRoots) +1; % skip next loop
        else
            j = 1; % perform next loop
        end
        while j <= length(NewtonRoots)
        % check which to place
            if abs(abs(real(OstRoots(j))) - abs(real(OstValues(i)))) <= 0.001 && abs(abs(real(OstRoots(j))) - abs(real(OstValues(i)))) <= 0.001
                imageOst(locX, locY, :) = colorMapOst(j, :);
                j = length(NewtonRoots) + 1;
            end
            j = j +1;
        end
    end
    imshow(imageOst);
    toc;
end