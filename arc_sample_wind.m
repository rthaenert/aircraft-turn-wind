function [x,y] = arc_sample_wind(circle_center, start_angle, drawing_angle_delta, a, steps, direction, wind_displacement_m, wind_target_direction_rad)
% arc_sample_wind(circle_center, start_angle, drawing_angle_delta, a, steps, direction, wind_displacement_m, wind_target_direction_rad)

% transform coordinate system: mirror on y-axis + 90°
new_start_angle = wrapTo2Pi(-start_angle-pi/2);

rotation = 0;
if wind_target_direction_rad ~= 0
    rotation = wind_target_direction_rad;
    new_start_angle = wrapTo2Pi(new_start_angle+rotation);
end
if direction == 'L'
    t = linspace(new_start_angle,new_start_angle-drawing_angle_delta,steps);
else
    t = linspace(new_start_angle,new_start_angle+drawing_angle_delta,steps);
end
r = wind_displacement_m/drawing_angle_delta;

x = r*t-a*sin(t);
y = r-a*cos(t)-r;

% FIXME
transformation = wrapTo2Pi(angdiff(3*pi/2,start_angle));

% rotate back
if rotation ~= 0
    Rx = [cos(rotation) -sin(rotation);...
        sin(rotation) cos(rotation)];
    R = Rx*[x;y];
    x = R(1,:);
    y = R(2,:);

    x = x - cos(rotation) * r * rotation;
    y = y - sin(rotation) * r * rotation;
end

% adapt for transformation
x = x - cos(wind_target_direction_rad) * r * transformation + circle_center(1);
y = y - sin(wind_target_direction_rad) * r * transformation + circle_center(2);
end

