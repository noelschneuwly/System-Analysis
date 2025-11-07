% Final Assignment

% Research Question 1


% --- W0 parameter visualization ---
w0vec = [0.2, 0.5, 0.7, 0.9];
figure(1);
hold on
legendEntriesWater = {};

figure(2);
hold on
legendEntriesPlant = {};

blueBase  = [0, 0, 1];     % pure blue
blueLight = [0.4, 0.8, 1]; % light blue
greenBase = [0, 0.6, 0];   % pure green
greenLight = [0.5, 1, 0.5]; % light green

for j=1:4
    % system parameters
    PPT = 0.8; % find appropriate values
    P = 5; % initial value
    e = 10;
    k1 = 3;
    k2 = 5;
    W0 = w0vec(j);
    W = 0.2; % initial value
    cmax = 0.5;
    d = 0.1;
    b = 0.15;
    rw = 0.1; % find appropria9te value 

    % --- control parameters ---
    startTime = 0;
    endTime   = 50;
    timeStep  = 0.02;
    
    % --- compute iteration count ---
    iterations = floor((endTime - startTime)/timeStep) + 1;
    
    % --- initialize vectors ---
    timeV   = zeros(iterations, 1);
    waterV  = zeros(iterations, 1);
    plantV  = zeros(iterations, 1);
    
    % --- initialize state ---
    stateW = W;
    stateP = P;
    
    % --- simulation loop ---
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
    
    
    % --- plots ---
    t = (j - 1) / (length(w0vec) - 1);
    waterColor = blueLight * (1 - t) + blueBase * t;
    plantColor = greenLight * (1 - t) + greenBase * t;

    % --- plots ---
    figure(1)
    plot(timeV, waterV, 'Color', waterColor, 'LineWidth', 2)
    legendEntriesWater{end+1} = "Water (W0=" + w0vec(j) + ")";

    figure(2)
    plot(timeV, plantV, 'Color', plantColor, 'LineWidth', 2)
    legendEntriesPlant{end+1} = "Plant (W0=" + w0vec(j) + ")";


end 

xlim([0 inf])
ylim([0 35])

figure(1)
xlabel("Time [days]")
ylabel("Soil Water content [mm]")
title("Water Dynamics for different W0 values")
legend(legendEntriesWater)

xlim([0 inf])
ylim([0 0.6])

figure(2)
xlabel("Time [days]")
ylabel("Plant Biomass [g/m^2]")
title("Vegetation Dynamics for different W0 values")
legend(legendEntriesPlant, 'Location', 'Southeast')
    
