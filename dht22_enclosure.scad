// DHT22 enclosure, connected to the focuser

use <DHT22.scad>;

M3_d=3; // 2.5 is printed too narrow
M2_d=1.6*(3/2.5); // 1.6 enlarged in same proportions

module DHT22_enclosure()
{
    difference()
    {
        union()
        {
            translate([3,0,13/2-3])
                cube([44,18,13], center=true);
            translate([-10,9.5,-3])
                cylinder(d=4,h=13,$fn=32);
            translate([-10,-9.5,-3])
                cylinder(d=4,h=13,$fn=32);
            // Screw wall
            translate([23/2-19,14,-2])
                minkowski()
                {
                    cube([21,10,2], center=true);
                    cylinder(d=2,h=1,$fn=12);
                }
        }
        union()
        {
            scale(1.01) DHT22();
            // All-length space
            translate([3,0,10/2+2])
                cube([45,10,10], center=true);
            // Sensor space
            translate([27/2-1,0,10/2+5])
                cube([27,20,10], center=true);
            // Connector space
            translate([12/2-20,0,6/2+2]) scale(1.01)
                cube([12,10,6], center=true);
            // DHT back space
            translate([16/2-18,0,11/2])
                cube([16,16,11], center=true);
            translate([10/2+10,0,10/2-1])
                cube([10,5,10], center=true);
            translate([-10,9.5,2])
                cylinder(d=M2_d,h=10,$fn=32);
            translate([-10,-9.5,2])
                cylinder(d=M2_d,h=10,$fn=32);
            // Screw holes
            #translate([0,0,0])
                rotate([0,0,90])
                    translate([15,0,-5])
                        for(x = [0:15:20*0.8])
                            translate([0,x,0]) cylinder(h=10,d=M3_d,$fn=12);
        }
    }
}

module DHT22_cover() color("green") difference()
{
    union()
    {
        translate([18/2-19,0,2/2+10])
            cube([18,18,2], center=true);
        translate([8/2-19,0,2/2+8])
            cube([8,10,2], center=true);
        translate([-10,9.5,10])
            cylinder(d=4,h=2,$fn=32);
        translate([-10,-9.5,10])
            cylinder(d=4,h=2,$fn=32);
    }
    translate([-10,9.5,9])
        cylinder(d=M2_d*1.1,h=4,$fn=32);
    translate([-10,-9.5,9])
        cylinder(d=M2_d*1.1,h=4,$fn=32);
}

DHT22_enclosure();
DHT22_cover();