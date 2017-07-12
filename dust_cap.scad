// Dust cap system

lens_r=80;

use <28byj-48.scad>;
M3_d=3; // 2.5 is printed too narrow
M2_d=1.6*(3/2.5); // 1.6 enlarged in same proportions
M3_Head=2;

module offset_hull(ofs=[0,0,0])
{
    // Works with 1-level deep objects...
    for(c=[0:$children-1])
        hull()
        {
            translate(-ofs) children(c);
            translate( ofs) children(c);
        }
}

module screw_space(head_d,head_h,drill_d,drill_h,hull_ofs=[0,0,0])
{
    offset_hull(hull_ofs)
    {
        cylinder(d=head_d,h=drill_h,$fn=12);
        translate([0,0,drill_h-1])
            cylinder(d=drill_d*2.0,h=head_h,$fn=12);
    }
}

module cap_block(R,H,B) union()
{
    bot_h=5;
    lever_l=40;
    lever_w=0+R*0.1;
    lever_drop=B-10;
    m_r=1;
    difference()
    {
        translate([lever_l+R,0,-bot_h-lever_drop]) difference()
        {
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
        }
        // Stepper axis
        #translate([0,lever_w/2+0,0])
            rotate([90,0,0])
                offset_hull([2,0,0])
                {
                    cylinder(d=6,h=1,$fn=16);
                    translate([0,0,lever_w/2])
                        cube([5,2,lever_w],center=true);
                }
        // Screw with space for head and adjustment
        #translate([0,0,0]) union()
            screw_space(M3_Head,4,M3_d,12,[2,0,0]);
    }
}

module holder(R,H,B)
{
    holder_w=0+R*0.1;
    holder_h=60;
    stepper_ear_h=0.8;
    translate([0,5.5+holder_w/2+M3_Head+stepper_ear_h,holder_w/2+10])
        cube([50,1+holder_w,60],center=true);
}

cap_block(lens_r,20,50);
*holder(lens_r,20,50);