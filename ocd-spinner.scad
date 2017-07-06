include <MCAD/units/metric.scad>
include <MCAD/shapes/2Dshapes.scad>

angle = 130;
bearing_diameter = 22.3;
hub_diameter = 29;
wall_thickness = 1;
arm_width = 5;
arm_length1 = 40;
arm_length2 = 2 * arm_length1 * cos (angle / 2);


$fs = 0.4;
$fa = 1;

module arm (length)
{
    translate ([0, -arm_width / 2])
    square ([length, arm_width]);

    translate ([length + 1, 0])
    circle (d = 19);
}

module place_arms (i)
{
    if (i == 1) {
        rotate (90 + angle / 2, Z)
        children ();

        rotate (90 - angle / 2, Z)
        children ();
    } else {
        rotate (-90, Z)
        children ();
    }
}

module nut ()
{
    circle (d = 14.53, $fn = 6);
}

linear_extrude (height = 7)
difference () {
    offset (r = -3)
    offset (r = 3)
    union () {
        translate ([0, 1])
        circle (d = hub_diameter);

        place_arms (1)
        arm (arm_length1);

        place_arms (2)
        arm (arm_length2);
    }

    circle (d = bearing_diameter);

    place_arms (1)
    translate ([arm_length1, 0])
    nut ();

    place_arms (2)
    translate ([arm_length2, 0])
    nut ();
}
