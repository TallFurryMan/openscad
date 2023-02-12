// Dust cap system

M4_d=2.7;
lens_r=80+5;

use <motors/28byj-48.scad>;

B608ZZ_dout=22;
B608ZZ_din=8;
B608ZZ_w=7;

module B608ZZ()
{
    difference()
    {
        cylinder(d=B608ZZ_dout,h=B608ZZ_w,$fn=32,center=true);
        cylinder(d=B608ZZ_din,h=B608ZZ_w*1.1,$fn=32,center=true);
    }
}

module cap_block(R,H,B) union()
{
    thick=3;
    lever_l=40;
    lever_w=5+R*0.1;
    lever_drop=B-10;
    translate([lever_l+R,0,-thick-lever_drop]) difference()
    {
        m_r=3;
        union()
        {
            cylinder(h=H+thick,d1=R*2+thick,d2=R*2.1+thick);
            minkowski()
            {
                translate([-R-lever_l/2,0,H/2]) hull()
                {
                    cube([lever_l*1.6-m_r*2,lever_w-m_r*2,H-m_r*2],center=true);
                    //translate([0,0,-H/2+5/2])
                    //    cube([lever_l,lever_w*1.5,5],center=true);
                    translate([-lever_l/2,0,B/2])
                        cube([lever_l*0.6-m_r*2,lever_w-m_r*2,B-m_r*2],center=true);
                }
                sphere(d=m_r*2);
            }
            // Stepper axis
            translate([-lever_l-R,40/2,thick+lever_drop])
                rotate([90,0,0])
                    stepper_axis();
        }
        // Cap emptiness
        #translate([0,0,thick+0.1]) union()
        {
            cylinder(h=2*H+0.1,d1=R*2,d2=R*2.2);
            /*translate([0,0,H])
                cylinder(h=H,d=R*2.1);*/
        }
        // Arrayed emptiness
        /*translate([-R/2,0,0])
            cylinder(h=thick+0.1,d=R,$fn=3);*/
        // Screw hole
        #translate([-lever_l-R,0,thick+lever_drop])
            translate([0,0,-60/2])
                cylinder(d=M4_d,h=60,$fn=12);
        // Stepper
        /*#translate([-lever_l-R,0,thick+lever_drop])
            translate([0,40,-8])
                rotate([90,0,0])
                    scale(1.01)
                        stepper_28BYJ_48();*/
    }
}

module stepper_axis()
{
    h=40;
    difference()
    {
        cylinder(d=B608ZZ_din,h=h,$fn=32);
        translate([0,-8,-21])
            scale(1.01)
                #stepper_28BYJ_48();
        translate([0,B608ZZ_din-3,h/2])
            #cube([B608ZZ_din,B608ZZ_din/2,B608ZZ_din/2],center=true);
        translate([0,B608ZZ_din*1.2/2,5])
            rotate([90,0,0])
                #cylinder(d=M4_d,h=B608ZZ_din*1.2,$fn=12);
    }
}

module holder() union()
{
    translate([0,-16,0])
        cube([40,10,60],center=true);
    translate([0,+16,0])
        cube([40,10,60],center=true);
    translate([0,0,35])
        cube([40,36,10],center=true);
}

//B608ZZ();
cap_block(lens_r,20,50);
translate([-50,0,0]) stepper_axis();
//holder();