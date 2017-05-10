include <motors/28byj-48.scad>

M3_d=3; // 2.5 is printed too narrow
M2_d=1.6*(3/2.5); // 1.6 enlarged in same proportions

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
    offset=24;
    //connector_block();
    translate([0,0,axis_slack])
    {
        // Millimetric knob
        translate([0,0,offset]) cylinder(h=18,d=26);
        // Main knob
        translate([0,0,offset+18]) cylinder(h=15,d=45);
        // Axis knob block narrow
        translate([0,0,offset+18+15]) cylinder(h=8,d=25);
        // Axis knob block larger
        translate([0,0,offset+18+15+8]) difference()
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
length=45+axis_slack;
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
                    cylinder(h=7,d=8,$fn=4);
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
            str_h=10;
            translate([0,0,5]) difference()
            {
                union()
                {
                    // +1 ugly fix :(
                    cube([str_w,length+1,str_h]);
                    translate([width-str_w,0,0]) cube([str_w,length+1,str_h]);
                }
                // Screw holes
                #translate([-1,15,str_h/2]) rotate([0,90,0])
                    for(x = [0:15:length*0.8])
                        translate([0,x,0]) cylinder(h=width+2,d=M3_d,$fn=12);
            }
        }

        // Stepper holder
        color("green") rotate([90,0,0]) difference()
        {
            translate([0,stepper_center-30,0]) union() 
            {
                cube([width,25,hol_w*2]);
                translate([width/2,25,0])
                    cylinder(h=hol_w*2,d=width);
            }
            // Screws holes
            /*
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
            */
            // Space for Stepper cables
            //#translate([-10/2,-15/2,stepper_center-30+10/2+1]) cube([10,10,10]);
            percent=0.35;
            #translate([width*(1-percent)/2,50,-1])
                rotate([90,0,0]) cube([width*percent,hol_w*2+2,60]);
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
                        {
                            cube([width,38,hol_w]);
                            translate([width*0.2/2,0,0])
                                cube([width*0.8,68,hol_w]);
                        }
                        translate([0,38,0])
                            cylinder(h=hol_w,d=width);
                    }
                    // Locker
                    #translate([-width/2,62,hol_w/2])
                        rotate([0,90,0])
                        {
                            cylinder(h=width,d=M3_d,$fn=12);
                            translate([0,0,width/2])
                                cylinder(h=width/2,d=M3_d+1,$fn=12);
                        }
                    // Narrow axis space
                    #translate([0,45,hol_w/2])
                        scale(1.05)
                            cube([25,45,hol_w+2],center=true);
                    #translate([0,38,-1])
                        scale(1.01) // 1.05 too large
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
    translate([-width/2-1,-length/2,-20]) cube([width+2,length*2,20]);
    // Stepper location - we're interested in the larger shaft only, not the axis
    translate([0,-18,stepper_center])
        rotate([90,0,180])
            scale([1.01,1.01,1.2]) // 1.05 too large, but leave space for cables
                stepper_28BYJ_48();
    // Stepper locks
    #translate([35/2,-hol_w,stepper_center])
        rotate([90,0,0])
        {
            cylinder(h=hol_w*3,d=M3_d,center=true,$fn=12);
            translate([0,0,-length-10]) cylinder(h=hol_w*3,d=2*M3_d,center=true,$fn=12);
        }
    #translate([-35/2,-hol_w,stepper_center])
        rotate([90,0,0])
        {
            cylinder(h=hol_w*3,d=M3_d,center=true,$fn=12);
            translate([0,0,-length-10]) cylinder(h=hol_w*3,d=2*M3_d,center=true,$fn=12);
        }
}

// The bottom cover
translate([-80,0,0])
{
    difference()
    {
        translate([width/2,length/2,0]) union()
        {
            minkowski()
            {
                cube([width-9,length-5,1], center=true);
                //translate([-width/2-2/2,-length/2+2/2,0]) cube([width+2,8+2,20]);
                //translate([width-12+1,-1,0]) cube([12,8,20]);
                //translate([-width/2-2/2,+length/2-2/2,0]) cube([width+2,8+2,20]);
                //translate([width-12+1,length-8+1,0]) cube([12,8,20]);
                cylinder(h=1,d=5,$fn=8);
                //sphere(d=5,$fn=8);
            }
            minkowski()
            {
                translate([0,0,10/2+1]) cube([width-18,length-18,12], center=true);
                cylinder(h=1,d=5,$fn=8);
            }
        }

        // Room for stepper
        #translate([width*0.5,2,0]) cube([width*0.5,6,5], center=true);

        // ULN driver
        #translate([width/2,length/2,-0.1]) rotate([0,0,90]) union()
        {
            w=35; h=32;
            translate([0,0,5/2]) scale(1.01) cube([w,h,5], center=true);
            translate([0,0,10/2]) scale(1.01) cube([26,28,10], center=true);
            // Holes are weird - x at 1.7, y at 3 from border
            translate([-w/2+1.7,-h/2+3,0]) cylinder(h=15,d=M3_d,$fn=12);
            translate([+w/2-1.7,+h/2-3,0]) cylinder(h=15,d=M3_d,$fn=12);
            translate([-w/2+1.7,+h/2-3,0]) cylinder(h=15,d=M3_d,$fn=12);
            translate([+w/2-1.7,-h/2+3,0]) cylinder(h=15,d=M3_d,$fn=12);
            // Connector spaces
            translate([0,-h/2+2,0]) cube([6,15,20]);
            translate([-w/2+5,-h/2+5,0]) cube([4,10,20]);
            // Led holes
            translate([10,-h/2+5,0]) cylinder(d=5,h=20);
            translate([10,-h/2+10,0]) cylinder(d=5,h=20);
            translate([10,-h/2+15,0]) cylinder(d=5,h=20);
            translate([10,-h/2+20,0]) cylinder(d=5,h=20);
        }
        
        // Screw holes
        #translate([0,0,-1]) union()
        {
            translate([5,3,0]) cylinder(h=10,d=M3_d,$fn=12);
            translate([width-5,3,0]) cylinder(h=10,d=M3_d,$fn=12);
            translate([5,length-3,0]) cylinder(h=10,d=M3_d,$fn=12);
            translate([width-5,length-3,0]) cylinder(h=10,d=M3_d,$fn=12);
        }
        
        // Remove everything under the models
        translate([-1,-length/2,-20]) cube([width+2,length*2,20]);
    }
}    

// The Arduino box
translate([-120,0,0])
{
    width=32;
    length=49;
    // Arduino Nano v3
    pin_h=8; pin_w=4;
    pcb_h=2; pcb_w=18; pcb_l=48;
    icsp_h=11;
    //translate([width/2,length/2,-0.1])
    difference()
    {
        translate([0,5/2,-2]) union()
        {
            // BUGBUG: minkowski of union results in non-manifold
            minkowski()
            {
                cube([20,length,21]);
                cylinder(h=1,d=5,$fn=8);
            }
            minkowski()
            {
                cube([width,length,3]);
                cylinder(h=1,d=5,$fn=8);
            }
        }
        // Ears
        #translate([-3,pcb_l/2,21-5]) union()
            for(xyz = [[0,15,0],[24,15,0],[0,-15,0],[24,-15,0]])
                translate(xyz) cube([2,10,2]);
        // Inners
        #scale(1.01) union()
        {
            // Arduino space
            #translate([10,3+pcb_l/2,pin_h+icsp_h/2]) cube([18,pcb_l,pcb_h+icsp_h], center=true);
            #translate([10-pcb_w/2+pin_w/2,3+pcb_l/2,pin_h/2-1/2]) cube([pin_w,pcb_l,pin_h], center=true);
            #translate([10+pcb_w/2-pin_w/2,3+pcb_l/2,pin_h/2-1/2]) cube([pin_w,pcb_l,pin_h], center=true);
            // USB plug
            #translate([10,pcb_l/2-1,14+1]) cube([11,pcb_l,10], center=true);
        }
        // Screw holes
        #translate([30,15,-1])
            for(x = [0:15:length*0.8])
                translate([0,x,0]) cylinder(h=10,d=M3_d,$fn=12);
        // Remove everything under the models
        translate([-5,-length/2,-20]) cube([width+5*2,length*2,20]);
    }

    // Cover
    translate([-35,0,0]) difference()
    {
        union()
        {
            translate([0,5/2,-2]) minkowski()
            {
                cube([20,length,3]);
                cylinder(h=1,d=5,$fn=8);
            }
            // Ears
            translate([-4,pcb_l/2+15,0]) cube([2,10,6]);
            translate([-3+1,pcb_l/2+15,2+3]) rotate([-90,0,0]) cylinder(h=10,d=1.75,$fn=8);
            translate([26-4,pcb_l/2+15,0]) cube([2,10,6]);
            translate([24-3+1,pcb_l/2+15,2+3]) rotate([-90,0,0]) cylinder(h=10,d=1.75,$fn=8);
            translate([-4,pcb_l/2-15,0]) cube([2,10,6]);
            translate([-3+1,pcb_l/2-15,2+3]) rotate([-90,0,0]) cylinder(h=10,d=1.75,$fn=8);
            translate([26-4,pcb_l/2-15,0]) cube([2,10,6]);
            translate([24-3+1,pcb_l/2-15,2+3]) rotate([-90,0,0]) cylinder(h=10,d=1.75,$fn=8);
            // USB catch-up
            translate([20/2,1.5,2.5]) cube([10.5,3,1.5], center=true);
        }
        // Led space
        #translate([20/2,29+5/2,0]) cube([11,3,5], center=true);
        // Reset hole
        #translate([20/2,24+5/2,-5/2]) cylinder(h=5,d=2,$fn=8);
        // Remove everything under the models
        translate([-5,-length/2,-20]) cube([width,length*2,20]);
    }
}

%translate([0,-18,stepper_center])
    rotate([90,0,180])
        stepper_28BYJ_48();

%translate([60,0,0])
    connector_block();
%translate([100,0,0])
    lock();

