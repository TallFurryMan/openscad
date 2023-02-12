include <../libraries/nutsnbolts-master/cyl_head_bolt.scad>;

$fn=128;

SPH_XD=115.46; // Diamètre total
SPH_ID=100.4;  // Diamètre intérieur
SPH_W=2.21;    // Epaisseur
SPH_X=(SPH_XD-SPH_ID)/2; // Bordure

module dome(_center=true) {
    /*if ($preview)*/ {
        sph_d=SPH_ID+SPH_W;
        sph_w=SPH_W;
        sph_x=SPH_X;
        add_h=sin(1.5)*SPH_ID/2;
        difference() {
            color("white", alpha=0.2) union() {
                translate([0,0,sph_w/2])
                    linear_extrude(height=sph_w, center=_center)
                        circle(d=sph_d+sph_x*2, $fn=64);
                translate([0,0,add_h])
                    sphere(d=sph_d, $fn=32);
            }
            color("white", alpha=0.2) union() {
                sphere(d=sph_d-sph_w, $fn=32);
                for(a=[45:90:360])
                    rotate([0,0,a])
                        translate([(SPH_XD-3)/2,0,sph_w+1]) /* 5mm holes */
                            hole_through(name="M3", l=sph_w*3);
                translate([0,0,-sph_d/4])
                    cube([ceil(sph_d)+sph_x*2,ceil(sph_d)+sph_x*2,ceil(sph_d/2)], center=_center);
            }
        }
    }
}

/*
module rasp_sm(_center=true) {
    rpi_l=98;//85.6;
    rpi_w=70;//53.98;
    rpi_h=30;//17;
    cube([rpi_l,rpi_w,rpi_h], center=_center);
    color("red") translate([rpi_l,0,0]) cube([
}
*/

module asi120mc(_center = true) {
    asi_d1 = 62;
    asi_h1 = 23;
    asi_d2 = 51;
    asi_h2 = 30.5;
    asi_d3 = 28;
    asi_h3 = 41;
    difference() {
        translate([0,0,-asi_h1/2]) {
            color("red") translate([0,0,asi_h1/2])
                cylinder(h=asi_h1, d=asi_d1, center=_center);
            color("red") translate([0,0,asi_h2/2])
                cylinder(h=asi_h2, d=asi_d2, center=_center);
            color("black") translate([0,0,asi_h3/2+2]) /* 2mm for lens bulb */
                cylinder(h=asi_h3, d=asi_d3, center=_center);
        }
        color("red") for(a=[45:90:360])
            rotate([0,0,a])
                translate([(asi_d1-5-1)/2,0,-1]) /* 5mm holes */
                    hole_through(name="M4", l=12);
    }
    color("gray") {
        translate([asi_d1/2+15,0,-asi_h1/2+8])
            cube([30,15+1,15+1], center=_center);
        translate([asi_d1/2+60,0,-asi_h1/2+8])
            cube([120,10,10], center=_center);
    }
}

module body(bod_h=10,_center=true) {
    bod_add = 2;
    bod_d=SPH_XD+SPH_W+bod_add;
    //bod_h=h;
    bod_w=SPH_XD-SPH_ID;
    han_l=50;
    asi_d1 = 62;
    sup_h = 15;
    difference() {
        union() {
            difference() {
                color("white") union() {
                    cylinder(h=bod_h, d=bod_d, center=_center);
                    translate([bod_d/2+han_l/2-10,0,0])
                        cube([han_l,bod_d/2.5,bod_h], center=_center);
                }
                color("white") union() {
                    translate([0,0,(bod_h>20?4:0)+1])
                        cylinder(h=bod_h, d=asi_d1, center=_center);
                    translate([0,0,(bod_h>20?4:-2)])
                        cylinder(h=bod_h+(bod_h>20?-5:-1), d=bod_d-bod_w, center=_center);
                    translate([0,0,bod_h/2+0.5]) difference() {
                        cylinder(h=2, d=bod_d-bod_w/4, center=_center);
                        cylinder(h=2.1, d=bod_d-bod_w/4-2, center=_center);
                    }
                }
            }
            if (bod_h>20)
                color("white") translate([0,0,-sup_h/2-5])
                    cylinder(h=sup_h,d=asi_d1+4*2, center=_center);
        }
        color("white") union() {
            for(a=[45:90:360])
                rotate([0,0,a])
                    translate([(bod_d-5-bod_add)/2,0,bod_h/2+(bod_h>20?2:2)])
                        if (bod_h>20)
                            hole_threaded(name="M3", l=bod_h+(bod_h>20?-2:4));
                        else
                            hole_through(name="M3", l=bod_h+(bod_h>20?-2:4));
            if (bod_h>20) {
                translate([bod_d-40,+17,bod_h/2+(bod_h>20?2:2)])
                    hole_through(name="M3", l=bod_h+(bod_h>20?-2:4));
                translate([bod_d-40,-17,bod_h/2+(bod_h>20?2:2)])
                    hole_through(name="M3", l=bod_h+(bod_h>20?-2:4));
            } else {
                translate([bod_d-40,+17,bod_h/2+(bod_h>20?2:2)])
                    hole_threaded(name="M3", l=bod_h+(bod_h>20?-2:4));
                translate([bod_d-40,-17,bod_h/2+(bod_h>20?2:2)])
                    hole_threaded(name="M3", l=bod_h+(bod_h>20?-2:4));
            }
            if (bod_h>20) {
                translate([bod_d/2+han_l/2-10,0,bod_h/2-15+0.5])
                    cube([han_l+10,20,30+1], center=_center);
                // ASI support
                for(a=[45:90:360])
                    rotate([0,0,a])
                        translate([(asi_d1-5-1)/2,0,-sup_h/2+7]) /* 5mm holes */
                            hole_through(name="M4", l=20);
            }
        }
    }
}

difference() {
    union() {
        translate([0,0,50.1]) dome();
        translate([0,0,45.1]) body(bod_h=10);
        translate([0,0,20]) body(bod_h=40);
        rotate([0,90,0]) rasp();
        translate([0,0,27]) asi120mc();
    }
    color("gray") union() {
        rotate([0,0,-45]) translate([0,-100,-10]) cube([400,100,1000]);
        translate([0,-100,-10]) cube([400,100,1000]);
    }
}