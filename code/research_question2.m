% Research Question 2

% Purpose: This code can be used to visualize changes in the model based on varying
% k2. 

% Use: Leave the parameters as they are, for a proper comparison to the modeled
% research question 2. If you want to check for other outcomes, feel
% free to change the parameters:

% Colors for our Model
blueBase  = [0, 0, 1];     
blueLight = [0.4, 0.8, 1]; 
greenBase = [0, 0.6, 0];   
greenLight = [0.5, 1, 0.5]; 


% W0 parameter visualization
k2vec = [5, 10, 15, 25];
figure(1);
hold on
legendEntriesWater = {};

figure(2);
hold on
legendEntriesPlant = {};

for j=1:4
    % System parameters
    PPT = 0.8; 
    P = 5; 
    e = 10;
    k1 = 3;
    k2 = k2vec(j);
    W0 = 0.2;
    W = 0.2; 
    cmax = 0.5;
    d = 0.1;
    b = 0.15;
    rw = 0.1; 

    % Control parameters
    startTime = 0;
    endTime   = 50;
    timeStep  = 0.02;
    
    % Compute iteration count 
    iterations = floor((endTime - startTime)/timeStep) + 1;
    
    % Initialize vectors
    timeV   = zeros(iterations, 1);
    waterV  = zeros(iterations, 1);
    plantV  = zeros(iterations, 1);
    
    % Initialize state 
    stateW = W;
    stateP = P;
    
    % Loop
    for i = 1:iterations
        t = startTime + (i-1)*timeStep;
    
        dWdt = PPT * ((stateP + k2 * W0) / (stateP + k2)) ...
             - ((cmax * stateW) / (stateW + k1)) * stateP ...
             - (rw * stateW);
    
        dPdt = e * (cmax * (stateW / (stateW + k1))) * stateP ...
             - (d + b) * stateP;
    
        stateW = stateW + dWdt * timeStep;
        stateP = stateP + dPdt * timeStep;
    
        % store
        timeV(i)  = t;
        waterV(i) = stateW;
        plantV(i) = stateP;
    end
    
    % Plots 
    t = (j - 1) / (length(k2vec) - 1);
    waterColor = blueLight * (1 - t) + blueBase * t;
    plantColor = greenLight * (1 - t) + greenBase * t;

    figure(1)
    plot(timeV, waterV, 'Color', waterColor, 'LineWidth', 2)
    legendEntriesWater{end+1} = "Soil Water Content [mm] (K2=" + k2vec(j) + ")";

    figure(2)
    plot(timeV, plantV, 'Color', plantColor, 'LineWidth', 2)
    legendEntriesPlant{end+1} = "Plant Biomass [g/m^2] (K2=" + k2vec(j) + ")";


end 

xlim([0 inf])
ylim([0 30])

figure(1)
xlabel("Time [days]")
ylabel("Soil Water content [mm]")
title("Soil Water Dynamics for different K2 values")
legend(legendEntriesWater)


xlim([0 inf])
ylim([0 0.5])

figure(2)
xlabel("Time [days]")
ylabel("Plant Biomass [g/m^2]")
title("Plant Biomass Dynamics for different K2 values")
legend(legendEntriesPlant, 'Location', 'Southeast')

    
