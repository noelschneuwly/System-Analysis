% Null Isocline Determination
% Use:
% Leave the parameters as they are, for a proper comparison to the modeled
% research questions. If you want to check for another equilibrium, feel
% free to change the parameters:

PPT = 0.8; 
e = 10;
k1 = 3;
k2 = 5;
W0 = 0.2;
cmax = 0.5;
d = 0.1;
b = 0.15;
rw = 0.1;

% Grid, to represent every point in our Area of Interest

W = linspace(0.01, 1, 400);
P = linspace(0.01, 50, 400);
[Wg, Pg] = meshgrid(W, P);

% Calculate the derivatives at every position in our grid

dWdt = PPT .* ((Pg + k2*W0) ./ (Pg + k2)) ...
       - (cmax .* Wg ./ (Wg + k1)) .* Pg ...
       - rw .* Wg;

dPdt = e .* (cmax .* (Wg ./ (Wg + k1))) .* Pg ...
       - (d+b) .* Pg;

% Plot our derivatives only if they are 0

figure; hold on;

redlight = [1, 0.4, 0.4];

contour(Wg, Pg, dWdt, [0 0], 'b', 'LineWidth', 3); % W-nullcline
contour(Wg, Pg, dPdt, [0 0], 'r', 'LineWidth', 3); % P-nullcline
yline(0, 'Color', redlight , 'LineWidth', 3)

xlabel('Soil water W');
ylabel('Plant biomass P');
title('Null Isoclines and Equilibrium Point');
legend('W-nullcline', 'P-nullcline (non-trivial)', 'P-nullcline (trivial)', 'Location', 'NorthEast');

xlim([0 1]);
ylim([0 50]);
grid on; box on;