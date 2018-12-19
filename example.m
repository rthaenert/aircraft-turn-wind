r = 400; % radius
circle_center = [500 500];
start_angle=0;
drawing_angle_delta=6*pi; % draw three turns in wind
steps = 1000;
wind_displacement_m = 2000; % 1000m is the windshift during the turns
wind_target_direction_rad= 0; % wind from west

[x,y] = arc_sample_wind(circle_center, start_angle, drawing_angle_delta, r, steps, 'L', wind_displacement_m, wind_target_direction_rad);
z = linspace(0,2000,steps); % upward spiralling
plot3(x,y,z, 'LineWidth', 1.5);
grid on;
axis equal;
