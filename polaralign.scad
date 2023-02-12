$fn=128;
difference() {
    union() {
        difference() {
            cylinder(d=40,h=20,center=false); // Holder external ring
            translate([0,0,+4])
                cylinder(d=36.05,h=10,center=false); // Mount polar align ring
            translate([0,0,45])
                rotate([90,0,0])
                    cylinder(d=72,h=40,center=true);
        }
        cylinder(d=31.5,h=22,center=false); // Tube for laser
    }
    translate([0,0,-1])
        cylinder(d=25.55,h=40,center=false); // Laser body - hollow
    /*%translate([0,0,-7])
        sphere(d=31,$fn=64);*/
}