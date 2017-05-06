include <motors/28byj-48.scad>

M3_d=2.5;

module connector_block() difference()
{
    height = 30;
    int_diameter = 28;
    union()
    {
        difference()
        {
            cylinder(h=height,d=int_diameter+4);
            scale(1.05) translate([0,0,12]) cylinder(h=height,d=int_diameter);
        }
        d = int_diameter/2;
        rotate([0,0,0]) translate([0,d,15]) cube([8,1,height], center=true);
        rotate([0,0,90]) translate([0,d,15]) cube([6,1,height], center=true);
        rotate([0,0,180]) translate([0,d,15]) cube([8,1,height], center=true);
        rotate([0,0,270]) translate([0,d,15]) cube([6,1,height], center=true);
    }
    scale(1.05) union()
    {
        translate([0,0,-1])
        {
            cylinder(h=1.5+1,d=9);
            cylinder(h=5+1,d=5,$fn=16);
            translate([0,0,10]) cylinder(h=4+1,d=9);
            translate([-2.5,-1.5,0]) cube([5,3,10+1]);
        }
    }
    #color("red") rotate([90,0,0])
        translate([0,10-3,-(int_diameter+4+1)/2])
            cylinder(h=int_diameter+4+1,d=2.5,$fn=12);
    
    #color("blue") 
    {
        d = int_diameter/2+1;
        rotate([0,0,0]) translate([0,d,15]) cube([6,4,30.5], center=true);
        rotate([0,0,90]) translate([0,d,15]) cube([4,4,30.5], center=true);
        rotate([0,0,180]) translate([0,d,15]) cube([6,4,30.5], center=true);
        rotate([0,0,270]) translate([0,d,15]) cube([4,4,30.5], center=true);
    }
}

module lock() union()
{
    difference()
    {
        union()
        {
            cylinder(h=6,d=28+5+4);
            translate([0,(29+5+4)/2+1,6/2])
                cube([10,10,6], center=true);
        }
        #translate([0,0,-0.5])
            cylinder(h=6+1,d=28+4+0.5);
        #translate([-2,(29+4+4)/2-4,-0.5])
            cube([4,12,7]);
        #rotate([0,90,0])
            translate([-3,(29+4+4)/2+3,0])
                cylinder(d=M3_d,h=12,center=true,$fn=12);
        #rotate([0,90,0])
            translate([-3,(29+4+4)/2+3,5])
                cylinder(d=M3_d+1,h=8,center=true,$fn=12);
    }
}

module focuser_knobs()
{
    //connector_block();
    translate([0,0,axis_slack])
    {
        // Millimetric knob
        translate([0,0,15]) cylinder(h=18,d=26);
        // Main knob
        translate([0,0,15+18]) cylinder(h=19,d=45);
        // Axis knob block narrow
        translate([0,0,15+18+19]) cylinder(h=8,d=25);
        // Axis knob block larger
        translate([0,0,15+18+19+8]) difference()
        {
            cylinder(h=7,d=29);
            #translate([0,0,7-3.5/2])
                rotate([-90,0,0])
                    cylinder(h=20,d=3.5);
        }
        // Focuser mount block
        //translate([0,0,15+18+19+8+7]) cube([
    }
    // Axis
    cylinder(h=200,d=1);
}

stepper_center = 20;
// Slack to mount system
axis_slack=8;
width=50;
length=65+axis_slack;
// Back holder width
hol_w=7;
difference()
{
    axis_offset = 17;
    
    // The focuser holder
    translate([-width/2,0,0]) union()
    {
        color("yellow") union()
        {
            difference()
            {
                cube([width,length+1,5]);
                // Center emptyness
                #minkowski()
                {
                    translate([width/4,12,-1])
                        cube([width/2,length-15-hol_w,1]);
                    cylinder(h=7,d=15,$fn=24);
                }
                // Screw holes
                #translate([0,0,-1])
                {
                    translate([5,3,0]) cylinder(h=10,d=M3_d,$fn=12);
                    translate([width-5,3,0]) cylinder(h=10,d=M3_d,$fn=12);
                    translate([5,length-3,0]) cylinder(h=10,d=M3_d,$fn=12);
                    translate([width-5,length-3,0]) cylinder(h=10,d=M3_d,$fn=12);
                }
            }
            // Straighteners
            str_w=3;
            str_h=5;
            translate([0,0,5]) difference()
            {
                union()
                {
                    // +1 ugly fix :(
                    cube([str_w,length+1,str_h]);
                    translate([width-str_w,0,0]) cube([str_w,length+1,str_h]);
                }
                // Screw holes
                #translate([-1,15,2.5]) rotate([0,90,0])
                    for(x = [0:15:width])
                        translate([0,x,0]) cylinder(h=width+2,d=M3_d,$fn=12);
            }
        }

        // Stepper holder
        color("green") rotate([90,0,0]) difference()
        {
            union() translate([0,stepper_center-30,0])
            {
                cube([width,25,hol_w]);
                translate([width/2,25,0])
                    cylinder(h=hol_w,d=width);
            }
            // Screws holes
            #translate([width/2,stepper_center,hol_w/2]) rotate([-90,0,0]) 
            {
                tube_l=70;
                translate([0,0,-tube_l/2])
                    cylinder(h=tube_l,d=M3_d,$fn=12);
                rotate([0,120,0])
                    translate([0,0,-tube_l/2])
                        cylinder(h=tube_l,d=M3_d,$fn=12);
                rotate([0,-120,0])
                    translate([0,0,-tube_l/2])
                        cylinder(h=tube_l,d=M3_d,$fn=12);
            }
        }

        // Block holder
        color("green") rotate([90,0,0])
        {
            translate([width/2,stepper_center-30,-length-hol_w])
            {
                difference()
                {
                    union()
                    {
                        translate([-width/2,0,0])
                            cube([width,38,hol_w]);
                        translate([0,38,0])
                            cylinder(h=hol_w,d=width);
                    }
                    // Narrow axis space
                    #translate([0,40,hol_w/2])
                        scale(1.05)
                            cube([25,45,hol_w+2],center=true);
                    #translate([0,38,-1])
                        scale(1.05)
                            cylinder(h=hol_w+2,d=29);
                    // Screws
                    #translate([0,38,hol_w/2]) rotate([-90,0,0]) 
                    {
                        tube_l=70;
                        translate([0,0,-tube_l/2])
                            cylinder(h=tube_l,d=M3_d,$fn=12);
                        rotate([0,120,0])
                            translate([0,0,-tube_l/2])
                                cylinder(h=tube_l,d=M3_d,$fn=12);
                        rotate([0,-120,0])
                            translate([0,0,-tube_l/2])
                                cylinder(h=tube_l,d=M3_d,$fn=12);
                    }
                }
            }
        }

        /*color("purple") translate([0,22+15+18+19+1,5])
        {
            translate([width/4,24,13])
                cube([width/2,50,20]);
            translate([width/2,50,0])
                cylinder(h=50,d=3,$fn=12);
        }*/
    }
    
    // Non-effective connector and focus knobs for verification
    %color("lightgrey")
        translate([0,0,stepper_center+8])
            rotate([-90,0,0])
                focuser_knobs();
    
    // Remove everything under the models
    #translate([-width/2-1,-50,-20]) cube([width+2,length*2,20]);
    // Stepper location - we're interested in the larger shaft only, not the axis
    translate([0,-18,stepper_center])
        rotate([90,0,180])
            scale(1.05)
                stepper_28BYJ_48();
    // Stepper locks
    #translate([35/2,0,stepper_center])
        rotate([90,0,0])
            cylinder(h=15,d=M3_d,center=true,$fn=12);
    #translate([-35/2,0,stepper_center])
        rotate([90,0,0])
            cylinder(h=15,d=M3_d,center=true,$fn=12);
    // Space for Stepper cables
    //#translate([-10/2,-15/2,stepper_center-30+10/2+1]) cube([10,10,10]);
    #translate([-23/2,-8,stepper_center-30-1]) cube([23,10,60]);
}

// The bottom cover
translate([-100,0,0])
{
    difference()
    {
        translate([width/2,length/2,10/2]) minkowski()
        {
            cube([width-5,length-5,10], center=true);
            cylinder(h=2,d=5,$fn=24);
            /*
            minkowski()
            {
                translate([width/4,12,1])
                    cube([width/2,length-15-hol_w,1]);
                cylinder(h=2,d=14,$fn=24);
            }
            */
        }
        
        // Borders
        #translate([0,0,2])
        {
            translate([-1,-1,0]) cube([12,8,20]);
            translate([width-12+1,-1,0]) cube([12,8,20]);
            translate([-1,length-8+1,0]) cube([12,8,20]);
            translate([width-12+1,length-8+1,0]) cube([12,8,20]);
        }
        
        // ULN driver
        #translate([width/2,27+0.5,10])
        {
            scale(1.05) cube([35,37,10], center=true);
        }
        
        // Arduino Nano v3
        #translate([width/2,56,10])
        {
            scale(1.05) cube([43,18,15], center=true);
            // BUGBUG
            translate([0,0,10]) scale(1.05) cube([50,10,7], center=true);
        }

        // Screw holes
        #translate([0,0,-1])
        {
            translate([5,3,0]) cylinder(h=10,d=M3_d,$fn=12);
            translate([width-5,3,0]) cylinder(h=10,d=M3_d,$fn=12);
            translate([5,length-3,0]) cylinder(h=10,d=M3_d,$fn=12);
            translate([width-5,length-3,0]) cylinder(h=10,d=M3_d,$fn=12);
        }
    }
}    



%translate([0,-18,stepper_center])
    rotate([90,0,180])
        stepper_28BYJ_48();

%translate([60,0,0])
    connector_block();
%translate([100,0,0])
    lock();

