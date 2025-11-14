% Final Assignment

% --- coloring ---
greenBase = [0, 0.6, 0];   % pure green
greenLight = [0.5, 1, 0.5]; % light green


figure;
hold on
legendEntriesPlant = {};
% --- initialize state ---
for j=1:4
    
    % system parameters
    PPT = 0.8; % find appropriate values
    P = [5, 5, 30, 30];
    e = 10;
    k1 = 3;
    k2 = 5;
    W0 = 0.2;
    W = [0, 1, 0, 1];
    cmax = 0.5;
    d = 0.1;
    b = 0.15;
    rw = 0.1; % find appropriate value
    
    % --- control parameters ---
    startTime = 0;
    endTime   = 1000;
    timeStep  = 0.02;
    
    % --- compute iteration count ---
    iterations = floor((endTime - startTime)/timeStep) + 1;
    
    % --- initialize vectors ---
    waterV  = zeros(iterations, 1);
    plantV  = zeros(iterations, 1);
    stateW = W(j);
    stateP = P(j);
    
    % --- simulation loop ---
    for i = 1:iterations
    
        dWdt = PPT * ((stateP + k2 * W0) / (stateP + k2)) ...
             - ((cmax * stateW) / (stateW + k1)) * stateP ...
             - (rw * stateW);
    
        dPdt = e * (cmax * (stateW / (stateW + k1))) * stateP ...
             - (d + b) * stateP;
    
        stateW = stateW + dWdt * timeStep;
        stateP = stateP + dPdt * timeStep;
    
        % store
        waterV(i) = stateW;
        plantV(i) = stateP;
    end

    % coloring
    t = (j - 1) / 3;
    plantColor = greenLight * (1 - t) + greenBase * t;
    
    % plot
    scatter(waterV, plantV, 15, plantColor, 'filled')
    legendEntriesPlant{end+1} = "Plant Biomass & Soil Water Content for initial value: (" + P(j) + ", " + W(j) + ")";
end
% --- plots ---


equilibriumW = waterV(end);
equilibrumP = plantV(end);
scatter(waterV(end), plantV(end), 45, [0,0,1], 'filled')
legendEntriesPlant{end+1} = "Point of Equilibrium: (" + equilibrumP + " g/m^2, " + equilibriumW + " mm)";

xlabel("Soil water content [mm]")
ylabel("Plant Biomass [g/m^2]")
title("Soil Water - Plant Biomass State Space Diagram")
legend(legendEntriesPlant)

xlim([0 inf])
ylim([0 45])
axis manual

hold off