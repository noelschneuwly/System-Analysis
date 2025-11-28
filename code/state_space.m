% State Space Portrait

% Purpose: This code can be used to visualize the stability of the
% equilibrium determined using the "null_isocline.m" code.

% Use: Leave the parameters as they are , for a proper comparison to the modeled
% null isoclines in the paper. If you want to check for other equilibria, feel
% free to change the parameters in the "null_isocline.m" code and in this code as well:

% Colors for our Model
greenBase = [0, 0.6, 0];   % pure green
greenLight = [0.5, 1, 0.5]; % light green


figure;
hold on
legendEntriesPlant = {};

% Initialize state
for j=1:4
    % System parameters
    PPT = 0.8; 
    P = [30, 5, 30, 5];
    e = 10;
    k1 = 3;
    k2 = 5;
    W0 = 0.2;
    W = [0, 0, 1, 1];
    cmax = 0.5;
    d = 0.1;
    b = 0.15;
    rw = 0.1; 
    
    % Control parameters
    startTime = 0;
    endTime   = 1000;
    timeStep  = 0.02;
    
    % Compute iteration count 
    iterations = floor((endTime - startTime)/timeStep) + 1;
    
    % Initialize vectors
    waterV  = zeros(iterations, 1);
    plantV  = zeros(iterations, 1);
    stateW = W(j);
    stateP = P(j);
    
    %Simulation loop 
    for i = 1:iterations
    
        dWdt = PPT * ((stateP + k2 * W0) / (stateP + k2)) ...
             - ((cmax * stateW) / (stateW + k1)) * stateP ...
             - (rw * stateW);
    
        dPdt = e * (cmax * (stateW / (stateW + k1))) * stateP ...
             - (d + b) * stateP;
    
        stateW = stateW + dWdt * timeStep;
        stateP = stateP + dPdt * timeStep;
    
        waterV(i) = stateW;
        plantV(i) = stateP;
    end
    % Plot
    t = (j - 1) / 3;
    plantColor = greenLight * (1 - t) + greenBase * t;
    
    scatter(waterV, plantV, 15, plantColor, 'filled')
    legendEntriesPlant{end+1} = "Plant Biomass & Soil Water Content for initial value: (" + P(j) + ", " + W(j) + ")";
end

equilibriumW = waterV(end);
equilibrumP = plantV(end);
scatter(waterV(end), plantV(end), 45, [0,0,1], 'filled')
legendEntriesPlant{end+1} = "Point of Equilibrium: (" + equilibrumP + " g/m^2, " + equilibriumW + " mm)";

xlabel("Soil water content [mm]")
ylabel("Plant Biomass [g/m^2]")
title("Soil Water - Plant Biomass State Space Diagram")
legend(legendEntriesPlant)

xlim([0 1])
ylim([0 50])
axis manual

hold off