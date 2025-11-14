% Final Assignment

% Research Question 3

figure(1);
hold on
legendEntriesWater = {};

figure(2);
hold on
legendEntriesPlant = {};

figure(3);
hold on
legendEntriesPPT = {};

blueBase  = [0, 0, 1];     % pure blue
blueLight = [0.4, 0.8, 1]; % light blue
greenBase = [0, 0.6, 0];   % pure green
greenLight = [0.5, 1, 0.5]; % light green


for j=1:2
    % system parameters
    PPT = 0 + (1 - 0) * rand;
    P = 5; 
    e = 10;
    k1 = 3;
    k2 = 5;
    W0 = 0.2;
    W = 0.2; 
    cmax = 0.5;
    d = 0.1;
    b = 0.15;
    rw = 0.1; 
    
    
    % --- control parameters ---
    startTime = 0;
    endTime   = 365;
    timeStep  = 0.02;
        
        % --- compute iteration count ---
    iterations = floor((endTime - startTime)/timeStep) + 1;
        
        % --- initialize vectors ---
    timeV   = zeros(iterations, 1);
    waterV  = zeros(iterations, 1);
    plantV  = zeros(iterations, 1);
    pptV = zeros(iterations, 1);
        
        % --- initialize state ---
    stateW = W;
    stateP = P;
    counter = 0;
        
        % --- simulation loop ---
    for i = 1:iterations
        t = startTime + (i-1)*timeStep;
        counter = counter + 1;
        if counter > 50
            PPT = rand * 0.5; % random in [0, 0.5]
            counter = 1;
        end
        
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
        pptV(i) = PPT;
    end
    
    
    % --- plots ---
    t = (j - 1) / (3);
    waterColor = blueLight * (1 - t) + blueBase * t;
    plantColor = greenLight * (1 - t) + greenBase * t;
    pptColor = blueLight * (1 - t) + blueBase * t;

    % --- plots ---
    figure(1)
    plot(timeV, waterV, 'Color', waterColor, 'LineWidth', 2)
    legendEntriesWater{end+1} = "Soil Water Content [mm] for randomized Precipitation Try " + j + "";

    figure(2)
    plot(timeV, plantV, 'Color', plantColor, 'LineWidth', 2)
    legendEntriesPlant{end+1} = "Plant Biomass [g/m^2] for randomized Precipitation Try " + j + "";

    figure(3)
    plot(timeV, pptV, 'Color', pptColor, 'LineWidth', 2)
    legendEntriesPPT{end+1} = "Precipitation Amount [mm] Try " + j + "";


end 


figure(1)
xlim([0 inf])
ylim([0 0.5])

xlabel("Time [days]")
ylabel("Soil Water content [mm]")
title("Soil Water Dynamics for randomized Precipitation")
legend(legendEntriesWater)


figure(2)
xlim([0 inf])
ylim([0 50])

xlabel("Time [days]")
ylabel("Plant Biomass [g/m^2]")
title("Vegetation Dynamics for randomized Precipitation")
legend(legendEntriesPlant)


figure(3)
xlim([0 inf])
ylim([0 1])

xlabel("Time [days]")
ylabel("Precipitation [mm]")
title("Precipitation for a Randomized Precipitation Pattern")
legend(legendEntriesPPT)


    