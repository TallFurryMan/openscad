include <libraries/nutsnbolts-master/cyl_head_bolt.scad>;

$fn = 128;

module inner_circle(scope_d=160, height=20) {
    border=scope_d/40;
    difference() {
        cylinder(d=scope_d, h=height/2, center=true);
        cylinder(d=scope_d-border*2, h=height/2+1, center=true);
    }
}

module outer_circle(scope_d=160, height=40) {
    space=scope_d/16;
    border=scope_d/40;
    // pi*d' = P + space = pi*d + space thus d' = d + space/pi
    scope_dp=scope_d+/*border+*/space/PI;
    opening_angle=asin(space/2/scope_dp);
    difference() {
        union() {
            hull() {
                cylinder(d=scope_dp+border*2, h=height, center=true);
                // Screw holds for the cap
                for (a=[60,180,300])
                    rotate([0,0,a])
                        translate([scope_dp/2+border,0,0])
                            cylinder(d=6, h=height, center=true);
            }
            translate([scope_dp/2+border/2,0,0])
            {
                // Two sides of the locker, holed by the difference
                cube([border*2+space*2,space*2.5,height], center=true);
                // Reinforcement on both sides
                for (a=[45,-45]) translate([space*1.3,0,0])
                    rotate([0,0,a])
                        translate([-border*4.2,0,0])
                            cube([border*4,space,height], center=true);
            }
        }
        // Inner hole
        cylinder(d=scope_dp, h=height+1, center=true);
        // Two sides for closing the locker
        for (a=[-opening_angle,+opening_angle])
            rotate([0,0,a])
                translate([scope_dp/2+border/2,0,0])
                    cube([space*4,space,height+1], center=true);
        // Screw holes for the locker
        translate([space+scope_dp/2+border/2,space-border/2,0])
        {
            translate([0,0,+height*0.55/2])
                rotate([90,0,0]) {
                    translate([0,0,-space/4]) nutcatch_parallel(name="M3", l=border);
                    translate([0,0,space*3]) hole_through(name="M3", l=space*4);
                }
            translate([0,0,-height*0.55/2])
                rotate([90,0,0]) {
                    translate([0,0,-space/4]) nutcatch_parallel(name="M3", l=border);
                    translate([0,0,space*3]) hole_through(name="M3", l=space*4);
                }
        }
        // Screw holes for the cap
        for (a=[60,180,300])
            rotate([0,0,a])
                translate([scope_dp/2+border,0,height/2+1])
                    hole_threaded(name="M3", l=height+2);
        // Screw holes to hold the whole
        for (a=[60,180,300])
            rotate([0,0,a]) {
                translate([scope_dp/2+border*4,0,+height*0.25])
                    rotate([0,90,0])
                        hole_threaded(name="M3", l=border*4+2);
                translate([scope_dp/2+border*4,0,-height*0.3])
                    rotate([0,90,0])
                        hole_threaded(name="M3", l=border*4+2);
                translate([scope_dp/2+border*4,0,-height*0.4])
                    rotate([0,90,0])
                        hole_threaded(name="M4", l=border*4+2);
            }
    }
}

module cap(scope_d=160) {
    space=scope_d/16;
    border=scope_d/40;
    // Use the scope diameter, not the outer circle diameter!
    // Except printing is not precise enough...
    // pi*d' = P + space = pi*d + space thus d' = d + space/pi
    scope_dp=scope_d+/*border+*/space/PI;
    opening_angle=asin(space/2/scope_dp);
    translate([0,0,0]) difference() {
        hull() {
            // cap itself
            cylinder(d=scope_d+/*border+*/border*2, h=2);
            // Screw holds for the cap
            for (a=[60,180,300])
                rotate([0,0,a])
                    translate([(scope_d+border+border*2)/2,0,0])
                        cylinder(d=6, h=2);
        }
        // Cap inner hole
        translate([0,0,-1]) cylinder(d=scope_d-border*3,h=4);
        // Screw holes for the cap
        for (a=[60,180,300])
            rotate([0,0,a])
                translate([(scope_d+border+border*2)/2,0,4])
                    hole_through(name="M3", l=4+2);
    }
}

// ED80T
scope_diameter=102;
// Orion guidescope
//scope_diameter=57;

/*translate([0,scope_diameter*+1.1,1*height])*/ color("red") inner_circle(scope_d=scope_diameter, height=scope_diameter*0.6*2/3);
//translate([0,scope_diameter*+0.0,0*height]) color("blue") outer_circle(scope_d=scope_diameter, height=scope_diameter*0.6);
/*translate([0,scope_diameter*-1.1,0])*/ color("green") cap(scope_d=scope_diameter);