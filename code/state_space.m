% Final Assignment

% system parameters
PPT = 0.8; % find appropriate values
P = [5, 5, 30, 30];
e = 10;
k1 = 3;
k2 = 5;
W0 = 0.2;
W = [0.2, 1, 0.2, 1];
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


figure;
% --- initialize state ---
for j=1:4

    stateW = W(j);
    stateP = P(j);
    
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
        waterV(i) = stateW;
        plantV(i) = stateP;
    end
    scatter(waterV, plantV)
    hold on
end
% --- plots ---
xlabel("Soil water [mm]")
ylabel("Plant density [g/m^2]")
title("Water-Vegetation State Space Diagram")
legend("Soil Water and Plant Density")
hold off