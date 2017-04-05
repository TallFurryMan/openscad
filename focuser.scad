include <motors/28byj-48.scad>

difference()
{
    cylinder(h=30,d=28+4);
    scale(1.05) union()
    {
        translate([0,0,-1])
        {
            cylinder(h=1.5+1,d=9);
            cylinder(h=4+1,d=5);
            translate([0,0,10]) cylinder(h=4+1,d=9);
            translate([-2.5,-1.5,0]) cube([5,3,10+1]);
        }
        translate([0,0,12]) cylinder(h=30,d=28);
    }
    rotate([90,0,0]) translate([0,10-3,0])
    {
        translate([0,0,-(28+4+1)]) cylinder(h=(28+4+1)*2,d=2.5);
        rotate([0,0,0]) translate([0,0,-(28+4+1)])
        {
            cylinder(h=28+4+1-15,d=7);
            cylinder(h=2,r1=4,r2=2);
        }
        rotate([-180,0,0]) translate([0,0,-(28+4+1)])
        {
           cylinder(h=28+4+1-15,d=7);
        }
    }
}

//translate([0,-8,-19]) stepper_28BYJ_48();