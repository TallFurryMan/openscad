// Dust cap system

lens_r=80;

include <motors/28byj-48.scad>;

module cap_block(R,H,B) union()
{
    bot_h=5;
    lever_l=40;
    lever_w=5+R*0.1;
    lever_drop=B-10;
    translate([lever_l+R,0,-bot_h-lever_drop]) difference()
    {
        m_r=3;
        union()
        {
            cylinder(h=H+bot_h,d1=R*2+5,d2=R*2.1+5);
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
        }
        // Cap emptiness
        #translate([0,0,bot_h+0.1]) union()
        {
            cylinder(h=2*H+0.1,d1=R*2,d2=R*2.2);
            /*translate([0,0,H])
                cylinder(h=H,d=R*2.1);*/
        }
        // Axis
        #translate([-lever_l-R,0,bot_h+lever_drop])
            rotate([90,0,0])
                translate([0,0,-40/2])
                    cylinder(d=8,h=40);
    }
}

cap_block(lens_r,20,50);
rotate([90,0,0])
    stepper_28BYJ_48();