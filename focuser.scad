include <motors/28byj-48.scad>

module connector_block() difference()
//union()
{
    cylinder(h=30,d=28+4);
    scale(1.05) union()
    {
        translate([0,0,-1])
        {
            cylinder(h=1.5+1,d=9);
            cylinder(h=5+1,d=5,$fn=16);
            translate([0,0,10]) cylinder(h=4+1,d=9);
            translate([-2.5,-1.5,0]) cube([5,3,10+1]);
        }
        translate([0,0,12]) cylinder(h=30,d=28);
    }
    #color("red") rotate([90,0,0]) translate([0,10-3,0])
    {
        translate([0,0,-(28+4+1)/2]) cylinder(h=28+4+1,d=2.5,$fn=12);
    }
    
    #color("blue") 
    {
        rotate([0,0,0]) translate([0,28/2+1,15]) cube([6,2,30.5], center=true);
        rotate([0,0,90]) translate([0,28/2+1,15]) cube([4,2,30.5], center=true);
        rotate([0,0,180]) translate([0,28/2+1,15]) cube([6,2,30.5], center=true);
        rotate([0,0,270]) translate([0,28/2+1,15]) cube([4,2,30.5], center=true);
    }
}

module lock() union()
{
    difference()
    {
        union()
        {
            cylinder(h=6,d=28+5+4);
            translate([0,(29+5+4)/2+1,6/2]) cube([10,10,6], center=true);
        }
        translate([0,0,-0.5]) cylinder(h=6+1,d=28+4+0.5);
        #translate([-2,(29+4+4)/2-4,-0.5]) cube([4,12,7]);
        #rotate([0,90,0]) translate([-3,(29+4+4)/2+3,0]) cylinder(d=2.5,h=12,center=true,$fn=12);
    }
}

//translate([0,-8,-19]) stepper_28BYJ_48();
translate([40,0,0]) connector_block();
translate([80,0,0]) lock();