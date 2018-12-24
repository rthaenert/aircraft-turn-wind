function tests = test_arc_sample_wind
    tests = functiontests(localfunctions);
end

function test_half_circle_right(~)
    center = [100 100];
    r = 100;
    wind_displacement = 10;
    [x,y] = arc_sample_wind(center, pi, pi, r, 2, 'R', wind_displacement, 0);
    verify_boundaries(x,y, [center(1)-r 100], [center(1)+r+wind_displacement 100]);
end

function test_half_circle_left(~)
    r = 100;
    center = [500 500];
    wind_displacement = 10;
    [x,y] = arc_sample_wind(center, 3*pi/2, pi/2, r, 2, 'L', wind_displacement, 0);
    verify_boundaries(x,y,[center(1) center(2)-r],[center(1)+r+wind_displacement center(2)]);
end

function test_left_right(~)
    r = 100;
    wind_displacement = 50;
    [x_r,y_r] = arc_sample_wind([0 0], 3*pi/2, pi/2, r, 2, 'R', wind_displacement, pi);
    verify_boundaries(x_r,y_r,[0 -r],[-r-wind_displacement 0]);
    [x_l,y_l] = arc_sample_wind([0 0], 3*pi/2, pi/2, r, 2, 'L', wind_displacement, pi);
    verify_boundaries(x_l,y_l,[0 -r],[r-wind_displacement 0]);
end

function test_quarter_right_quadrant_four(~)
    r = 100;
    wind_displacement = 500;
    [x,y] = arc_sample_wind([0 0], 0, pi/2, r, 2, 'R', wind_displacement, pi);
    verify_boundaries(x,y,[r 0],[-wind_displacement -r]);
end

function verify_boundaries(x,y,s,e)
    precision = 1e-5;
    err_start = sprintf('start point should be at [%d %d] but is at [%d %d]', s(1), s(2), x(1), y(1));
    err_end = sprintf('end point should be at [%d %d] but is at [%d %d]', e(1), e(2), x(2), y(2));
    assert(abs(x(1)-s(1)) < precision, err_start);
    assert(abs(x(2)-e(1)) < precision, err_end);
    assert(abs(y(1)-s(2)) < precision, err_start);
    assert(abs(y(2)-e(2)) < precision, err_end);
end