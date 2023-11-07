include <nutsnbolts/cyl_head_bolt.scad>;

$fn=128;
module hole(w=5,d=6,h=20,t=0,td=10) {
    hull() {
        translate([-w,0,-0.01])
            cylinder(h=h+0.01,d=d);
        translate([+w,0,-0.01])
            cylinder(h=h+0.01,d=d);
    }
    if (t>0)
        hull() {
            translate([+w,0,h-t-0.01])
                cylinder(h=t+0.01,d=td);
            translate([-w,0,h-t-0.01])
                cylinder(h=t+0.01,d=td);
        }
}
module base() {
    len=170; gwi=64; ground=131; hei=30; ghei=0; bwi=38;
    difference() {
        translate([len/2,0,0])
            rotate([0,-90,0])
                minkowski() {
                    linear_extrude(height=len)
                        polygon([[0,0],[hei,0],[ghei,gwi],[0,gwi]]);
                    sphere(r=0);
                }
        // Block holes
        /*
        ang=-atan(hei/gwi);
        translate([0,sin(ang)*gwi/2,0])
            rotate([ang,0,0])
                translate([-len/2+7,15,0])
                    hole(h=hei+5,t=0,w=3,d=4);
        translate([0,sin(ang)*gwi/2,0])
            rotate([ang,0,0])
                translate([-len/2+7,46,0])
                    hole(h=hei+5,t=0,w=3,d=4);
        translate([0,sin(ang)*gwi/2,0])
            rotate([ang,0,0])
                translate([len/2-7,15,0])
                    hole(h=hei+5,t=0,w=3,d=4);
        translate([0,sin(ang)*gwi/2,0])
            rotate([ang,0,0])
                translate([len/2-7,46,0])
                    hole(h=hei+5,t=0,w=3,d=4);
        */
        // Ground holes
        translate([-ground/2,10,0])
            hole(h=hei,t=10,w=10);
        translate([+ground/2,10,0])
            hole(h=hei,t=10,w=10);
        translate([-35,47,0])
            rotate([0,0,90*0])
                hole(h=19,t=15,w=10);
        translate([+35,47,0])
            rotate([0,0,90*0])
                hole(h=19,t=15,w=10);
        // Block ground support
        /*translate([len/2-bwi,gwi-4,-0.001])
            cube([bwi+.001,4.001,30.001]);
        translate([-len/2-0.001,gwi-4,-0.001])
            cube([bwi+.001,4.001,10.001]);*/
    }
    translate([-len/2,-70,0])
        cube([len,110-40,hei]);
    translate([-len/2,-70,0])
        cube([len/2+2,4,hei*3+5]);
    translate([-len/2,-70,hei*3+5])
        cube([len/2+2,70,2]);    
}


module holder() {
    w=110;
    he=80;
    translate([0,-w+40,0])
    difference() {
        // box
        minkowski() {
            m=0;
            translate([m,m,m])
                cube([60-m*2,w-m*2,he+40-m*2]);
            sphere(r=m);
        }
        // rounded top
        translate([30,-1+0,he+5])
            rotate([-90,0,0])
                difference() {
                    cylinder(d=100,h=w+2);
                    translate([0,0,-0.01])
                        scale(1.01) cylinder(d=60,h=w+2);
                    translate([-52,0,-0.01])
                        scale(1.01) cube([w+14,w,w+2]);
                }
        // screw headroom
        translate([40/2,-1,he-(10+47)/2])
            cube([20,w+2,10+47]);
        // motor hole
        hull() {
            translate([30,w+2,he+5])
                rotate([90,0,0])
                    cylinder(d=47, h=w+5);
            translate([30,w+2,he-5])
                rotate([90,0,0])
                    cylinder(d=47, h=w+5);
        }
        translate([30,w+2,he]) for(a=[-90:120:360])
            rotate([0,a,0])
                translate([47/2,0,0])
                    rotate([0,-a,0])
                        rotate([90,0,0]) hull() {
                            translate([0,+5,0]) cylinder(d=6, h=w+5);
                            translate([0,-5,0]) cylinder(d=6, h=w+5);
                        }
        
            /*translate([30,w+2,he-5])
            {
                rotate([90,0,0])
                    cylinder(d=47, h=w+5);
                for(a=[-90:120:360]) rotate([0,a,0])
                    translate([47/2,0,0])
                        rotate([90,0,0])
                            translate([-1,0,0])
                                cylinder(d=6, h=w+5);
            }*/
        
        hd=3;
        // reducer holder
        union() {
            translate([30-7,4/2+6+w-40,he*2])
                hole_through("M3",l=200);
            translate([30+7,4/2+6+w-40,he*2])
                hole_through("M3",l=200);
            translate([30-7,40-(4/2+6)+w-40,he*2])
                hole_through("M3",l=200);
            translate([30+7,40-(4/2+6)+w-40,he*2])
                hole_through("M3",l=200);
        }
        // side holders
        union() {
            translate([w,40/2+w-40,he-10])
                rotate([0,90,0])
                    hole_through("M3",l=200);
            translate([w,40/2+w-40,he+10])
                rotate([0,90,0])
                    hole_through("M3",l=200);
            translate([w,40/2+w-40,he])
                rotate([0,90,0])
                    hole_through("M3",l=200);
            translate([w,40/2+w-100,he-10])
                rotate([0,90,0])
                    hole_through("M3",l=200);
            translate([w,40/2+w-100,he+10])
                rotate([0,90,0])
                    hole_through("M3",l=200);
            translate([w,40/2+w-100,he])
                rotate([0,90,0])
                    hole_through("M3",l=200);
        }
        // cable holder
        translate([-5,15,he])
            rotate([0,90,0])
                hole();
    }
}

module nodemcu() {
    cube([58,32,3], center=true);
    translate([58/2-10/2,-10/2,2/2])
        cube([10,10,2]);
    translate([0,0,18]) {
        translate([+53/2,+25/2,0])
            hole_through("M3",l=52-21);
        translate([+53/2,-25/2,0])
            hole_through("M3",l=52-21);
        translate([-53/2,+25/2,0])
            hole_through("M3",l=52-21);
        translate([-53/2,-25/2,0])
            hole_through("M3",l=52-21);
    }
    translate([-40/2,+25/2+1-3/2,-10])
        cube([40,3,12]);
    translate([-40/2,-25/2-1-3/2,-10])
        cube([40,3,12]);
}

module bts7960() {
    union() {
        union() {
            rotate([0,0,90]) {
            translate([0,0,3/2])
                cube([50,50,3], center=true);
            translate([-50/2+10/2+1,5,14/2])
                cube([10,20,14], center=true);
            translate([-50/2+10/2+1,-10,18/2])
                cylinder(d=10,h=18, center=true);
            translate([+50/2-2.5-1,0,10/2])
                cube([2.5*2,30,10], center=true);
            }
            heatsink_height=21;
            scale(1.05) translate([0,0,-heatsink_height/2])
                cube([50,34,heatsink_height], center=true);
        }
        // square holes
        translate([0,0,18]) {
            translate([+20,+20,0])
                hole_through("M3",l=52-21);
            translate([+20,-20,0])
                hole_through("M3",l=52-21);
            translate([-20,+20,0])
                hole_through("M3",l=52-21);
            translate([-20,-20,0])
                hole_through("M3",l=52-21);
        }
    }
}

module dcdc() {
    union() {
        union() {
            translate([0,0,3/2])
            cube([21,44,3], center=true);
            translate([0,0,15/2+3])
                cube([21,25,15], center=true);
        }
        translate([0,0,10/2]) {
            translate([-21/2+2.5,-30/2,10])
                hole_through("M3",l=25);
            translate([+21/2-2.5,+30/2,10])
                hole_through("M3",l=25);
        }
    }
}

difference() {
    union() {
        color("yellow") translate([0,0,0]) base();
        holder();
    }
    translate([-40,-20,35])
        rotate([0,0,-180])
            nodemcu();
    translate([-30,-70+5,60])
        rotate([-90,0,0])
            bts7960();
    translate([-70,-70+5,63])
        rotate([-90,0,0])
            dcdc();
    translate([-70,-55,35])
        rotate([0,0,-180])
            hole_through("M3",l=10);
}