% Final Assignment

% system parameters
PPT = 0.8; % find appropriate values
P = 5; % initial value
e = 10;
k1 = 3;
k2 = 5;
W0 = 0.2;
W = 0.1; % initial value
cmax = 0.5;
d = 0.1;
b = 0.15;
rw = 0.1; % find appropriate value

% --- control parameters ---
startTime = 0;
endTime   = 100;
timeStep  = 0.1;

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

    dWdt = PPT * ((stateP + k2 * W0) / (stateP + k2)) * stateW ...
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
figure;
plot(timeV, waterV)
hold on
plot(timeV, plantV)
xlabel("Time [days]")
ylabel("Amount of Soil Water and Plant Growth")
title("Water-Vegetation Model for Desert Areas")
legend("Soil Water", "Plants")
