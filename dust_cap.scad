// Dust cap system

lens_r=101/2;

use <28byj-48.scad>;
M3_d=3; // 2.5 is printed too narrow
M2_d=1.6*(3/2.5); // 1.6 enlarged in same proportions
M3_Head=2;

module ED80T()
{
    cylinder(d=101,h=20,$fn=64);
    cylinder(d=101-3*2,h=100,$fn=64);
}

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

lever_l=30;
module cap_block(R,H,B) union()
{
    bot_h=5;
    lever_w=0+R*0.2;
    lever_drop=0+H;
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
                    translate([-R-lever_l/2,0,10]) //hull()
                    {
                        cube([lever_l*1.8-m_r*2,lever_w-m_r*2,H-m_r*2],center=true);
                        //translate([0,0,-H/2+5/2])
                        //    cube([lever_l,lever_w*1.5,5],center=true);
                        translate([-lever_l/2,0,H-5])
                            cube([lever_l*0.8-m_r*2,lever_w-m_r*2,H+10-m_r*2],center=true);
                    }
                    sphere(d=m_r*2);
                }
            }
            // Cap emptiness
            translate([0,0,bot_h+0.1]) union()
            {
                cylinder(h=2*H+0.1,d1=R*2,d2=R*2.2);
                /*translate([0,0,H])
                    cylinder(h=H,d=R*2.1);*/
            }
        }
        // Stepper axis
        *rotate([0,180,0]) translate([0,24+M3_Head,-8])
            rotate([90,0,0])
                stepper_28BYJ_48();
        #translate([0,lever_w/2+0,0])
            rotate([90,0,0])
                offset_hull([lever_l/8,0,0])
                {
                    cylinder(d=6,h=1,$fn=16);
                    translate([0,0,lever_w/2])
                        cube([5,2,lever_w],center=true);
                }
        // Screws with space for head and adjustment
        #union()
        {
            screw_space(M3_Head,4,M3_d,H/2+2,[lever_l/8,0,0]);
            rotate([0,90,0]) screw_space(M3_Head,4,M3_d,lever_w+2);
            rotate([0,-90,0]) screw_space(M3_Head,4,M3_d,lever_w+2);
        }
    }
}

module holder(R,H,B)
{
    holder_w=0+R*0.1;
    holder_h=70;
    holder_d=45;
    stepper_ear_h=0.8;
    side_offset=5.5+holder_w/2+M3_Head+stepper_ear_h;
    difference()
    {
        hull()
        {
            translate([0,side_offset,holder_w/2+10])
                cube([holder_d,1+holder_w,holder_h],center=true);
            /*translate([0,-side_offset,holder_w/2+10])
                cube([holder_d,1+holder_w,holder_h],center=true);*/
            translate([holder_d/2-holder_w,0,holder_w/2+10+holder_h/3])
                cube([holder_w*6+5,1+holder_w+2*side_offset,holder_h/3],center=true);
        }
        %rotate([0,180,0])
            translate([0,24+M3_Head,-8])
                rotate([90,0,0])
                    stepper_28BYJ_48();
        translate([0,0,8]) scale([1,5,1])
            rotate([90,180,0]) scale(1.01) offset_hull([0,10,0])
            {
                // Stepper space
                cylinder(h=holder_w+stepper_ear_h+1,d=28,center=true);
                translate([-14.6/2,-17,-(holder_w+stepper_ear_h+1)/2])
                    cube([14.6,17,holder_w+stepper_ear_h+1]);
                // Stepper screws
                translate([-35/2,0,0])
                    cylinder(d=M3_d,h=holder_w+stepper_ear_h+1,center=true,$fn=12);
                translate([+35/2,0,0])
                    cylinder(d=M3_d,h=holder_w+stepper_ear_h+1,center=true,$fn=12);
            }
        #translate([holder_d/2+holder_w*6/4-1,0,holder_w/2+10+holder_h/3])
            rotate([90,0,0])
            {
                offset_hull([0,holder_h/9,0])
                    cylinder(d=2,h=holder_w*7,center=true,$fn=12);
                translate([1/2,holder_h/9,0])
                    offset_hull([1/2,0,0])
                        cylinder(d=2,h=holder_w*7,center=true,$fn=12);
                translate([1/2,-holder_h/9,0])
                    offset_hull([1/2,0,0])
                        cylinder(d=2,h=holder_w*7,center=true,$fn=12);
            }
        translate([lever_l+lens_r-1,0,-20])
            ED80T();
        translate([0,side_offset-holder_w/2-31/2,1])
        {
            cube([holder_d,30,holder_h],center=true);
            translate([20,0,-5])
                cube([holder_d,30,holder_h/2],center=true);
            translate([holder_d,holder_w*2,-5])
                cube([holder_d,30,holder_h/2],center=true);
        }
        // Argh, leave space for cap!
        translate([0,0,-25])
            cube([holder_d+5,30,holder_h/2],center=true);
    }
}

%translate([lever_l+lens_r,0,-20]) ED80T();
holder(lens_r,20,50);
rotate([0,180-180*sin(180*$t),0])
    cap_block(lens_r,20,50);
