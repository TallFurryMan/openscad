use <motors/28byj-48.scad>

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
module focuser_holder() difference()
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
module bottom_cover() rotate([0,0,0]) translate([-width/2,0,0]) union()
{
    // Brim
    //translate([0,0,0]) cylinder(h=2,d=4);

    %translate([25,26.5,-5]) bottom_inter_cover();

    difference()
    {
        translate([width/2,length/2,0]) union()
        {
            minkowski()
            {
                translate([0,0,1/2]) cube([width-9,length-5,1], center=true);
                //translate([-width/2-2/2,-length/2+2/2,0]) cube([width+2,8+2,20]);
                //translate([width-12+1,-1,0]) cube([12,8,20]);
                //translate([-width/2-2/2,+length/2-2/2,0]) cube([width+2,8+2,20]);
                //translate([width-12+1,length-8+1,0]) cube([12,8,20]);
                cylinder(h=1,d=5,$fn=8);
                //sphere(d=5,$fn=8);
            }
            minkowski()
            {
                translate([0,0,10/2+3]) cube([width-18,length-15,14], center=true);
                cylinder(h=1,d1=5,d2=2,$fn=8);
            }
        }

        // Room for stepper - mirrored just because
        #translate([width*0.5,1,1]) cube([width*0.5,7,3], center=true);
        #translate([width*0.5,length-1,1]) cube([width*0.5,7,3], center=true);

        // ULN driver - was inverted! so added mirror()
        translate([width/2,length/2,-0.1]) rotate([0,0,90]) mirror([0,1,0]) union()
        {
            w=35; h=32;
            // Space for pcb
            translate([0,0,5/2]) cube([w+1.5,h+1.5,7], center=true);
            // Space for pcb components
            translate([-7/2,0,15/2]) cube([26-5,29,10], center=true);
            // Holes are weird - x at 1.7, y at 3 from border
            // Adjusted 1.7 at 2.2 for top holes after first iteration
            translate([-w/2+1.7,-h/2+3,0]) cylinder(h=15,d=M3_d,$fn=12);
            translate([+w/2-2.2,+h/2-3,0]) cylinder(h=15,d=M3_d,$fn=12);
            translate([-w/2+1.7,+h/2-3,0]) cylinder(h=15,d=M3_d,$fn=12);
            translate([+w/2-2.2,-h/2+3,0]) cylinder(h=15,d=M3_d,$fn=12);
            // Connector spaces
            translate([6.9,6.5,2]) cube([6,8,8]); // small resistor
            translate([6.9,-14.5,2]) cube([6,22,5]); // extra for leds
            translate([0.5,-h/2+2,0]) cube([6,15,20]);
            translate([-w/2+4,-h/2+3,0]) cube([4,12,20]);
            translate([-w/2+5,10,0]) cube([12,4,20]);
            // Led holes
            for(ofs = [4,9,14,19])
                translate([10,-h/2+ofs,0])
                    cylinder(d=4.5,h=20,$fn=12);
        }
        
        // Screw holes
        #translate([0,0,-1/2]) union()
        {
            translate([5,3,0]) cylinder(h=3,d=M3_d,$fn=12);
            translate([width-5,3,0]) cylinder(h=3,d=M3_d,$fn=12);
            translate([5,length-3,0]) cylinder(h=3,d=M3_d,$fn=12);
            translate([width-5,length-3,0]) cylinder(h=3,d=M3_d,$fn=12);
        }
        
        // Remove everything under the models
        //translate([-1,-length/2,-20]) cube([width+2,length*2,20]);
    }
}

module bottom_inter_cover()
{
    w=35; h=32; // d=1.3*M3_d;
    translate([0,0,2/2]) rotate([0,0,90]) difference()
    {
        union()
        {
            cube([w+1,h+1,2], center=true);
            /*
            translate([-w/2+1.7,-h/2+3,1]) cylinder(h=2,d=d,$fn=12);
            translate([+w/2-2.2,+h/2-3,1]) cylinder(h=2,d=d,$fn=12);
            translate([-w/2+1.7,+h/2-3,1]) cylinder(h=2,d=d,$fn=12);
            translate([+w/2-2.2,-h/2+3,1]) cylinder(h=2,d=d,$fn=12);
            */
        }
        translate([0,0,2]) cube([w-3,h-3,4], center=true);
        // Holes are weird - x at 1.7, y at 3 from border
        // Adjusted 1.7 at 2.2 for top holes after first iteration
        translate([0,0,-3])
            for(ofs = [[-w/2+1.7,-h/2+3,0], [+w/2-2.2,+h/2-3,0], [-w/2+1.7,+h/2-3,0], [+w/2-2.2,-h/2+3,0]])
                translate(ofs)
                    cylinder(h=15,d=M3_d,$fn=12);
    }
}

// The Arduino box
module arduino_box()
{
    width=32;
    length=45;
    // Arduino Nano v3
    pin_h=8; pin_w=3;
    pcb_h=2; pcb_w=18; pcb_l=45;
    icsp_h=11;
    //translate([width/2,length/2,-0.1])
    difference()
    {
        translate([2,5/2,]) union()
        {
            minkowski()
            {
                union()
                {
                    cube([16,pcb_l,15]);
                    translate([-4,pcb_l/2,15/2])
                        cube([3,2,15], center=true);
                }
                cylinder(h=1,d=5,$fn=8);
            }
            translate([21.5,2.5,0]) rotate([0,-90,0]) minkowski()
            {
                cube([width*0.9,length-5,2]);
                cylinder(h=1,d=5,$fn=8);
            }
        }
        // Inners
        scale(1.01) union()
        {
            // Arduino space
            translate([10,3+pcb_l/2,pin_h+icsp_h/2]) cube([18,pcb_l,pcb_h+icsp_h], center=true);
            translate([10-pcb_w/2+pin_w/2,3+pcb_l/2,pin_h/2-1/2]) cube([pin_w,pcb_l,pin_h], center=true);
            translate([10+pcb_w/2-pin_w/2,3+pcb_l/2,pin_h/2-1/2]) cube([pin_w,pcb_l,pin_h], center=true);
            // USB plug
            translate([10,pcb_l/2-1,14+1]) cube([11,pcb_l,10], center=true);
        }
        // Cover
        translate([20/2+0.001,0,16-0.001])
            rotate([0,180,0])
                translate([0,0,0])
                    arduino_cover();
        // Cover screw hole
        #translate([-3,pcb_l/2+5/2,-5/2])
            cylinder(d=M3_d,h=22,$fn=8);
        // Screw holes
        #translate([25,0,0])
            rotate([0,-90,0])
                translate([25,10,0])
                    for(x = [0:15:length*0.8])
                        translate([0,x,0]) cylinder(h=10,d=M3_d,$fn=12);
        // Remove everything under the models
        translate([-10,-length/2,-20]) cube([width+10*2,length*2,20]);
    }
}

module arduino_cover()
{
    width=32;
    length=45;
    // Arduino Nano v3
    pin_h=8; pin_w=4;
    pcb_h=2; pcb_w=18; pcb_l=45;
    icsp_h=11;
    cover_h=2;
    translate([-20/2,0,-2]) difference()
    {
        union()
        {
            translate([2,5/2,0]) minkowski()
            {
                union()
                {
                    cube([16,pcb_l,cover_h-1]);
                    translate([20,pcb_l/2,1/2])
                        cube([3,2,cover_h-1], center=true);
                }
                cylinder(h=1,d=5,$fn=8);
            }
            // Ears
            translate([-1,pcb_l/2+5/2,cover_h/2])
                cube([1,10,cover_h], center=true);
            //translate([-3,pcb_l/2+10/2,0]) cube([1,10,5]);
            //translate([-3+1,pcb_l/2+10/2,2+3]) rotate([-90,0,0]) cylinder(h=10,d=1.5,$fn=8);
            //translate([26-4,pcb_l/2+10,0]) cube([1,10,5]);
            //translate([24-3+1,pcb_l/2+10,2+3]) rotate([-90,0,0]) cylinder(h=10,d=1.5,$fn=8);
            //translate([-3,pcb_l/2-15,0]) cube([1,10,5]);
            //translate([-3+1,pcb_l/2-15,2+3]) rotate([-90,0,0]) cylinder(h=10,d=1.5,$fn=8);
            //translate([17.5,pcb_l/2-10/2,0]) cube([1,10,3]);
            //translate([18+0.5,pcb_l/2-10/2,3]) rotate([-90,0,0]) cylinder(h=10,d=1.5,$fn=8);
            // USB catch-up - higher, as USB plug doesn't get it the hole actually
            translate([20/2,1.5,cover_h+1/2]) cube([10.5,3,1], center=true);
        }
        // Screw hole
        translate([18+5,pcb_l/2+5/2,-5/2])
            cylinder(d=M3_d,h=8,$fn=8);
        // Led space
        translate([20/2,30+5/2,1]) cube([11,3,cover_h+1], center=true);
        // Reset hole
        translate([20/2,26+5/2,-0.5]) cylinder(h=cover_h+1,d=2,$fn=8);
        // ICSP hole
        translate([20/2,44,1]) cube([8,6,cover_h+1], center=true);
        // Remove everything under the models
        //translate([-5,-length/2,-20]) cube([width,length*2,20]);
    }
}

*focuser_holder();
*translate([0,-18,stepper_center])
    rotate([90,0,180])
        stepper_28BYJ_48();

translate([-55,0,16]) rotate([0,180,0]) bottom_cover();
translate([-55,-23,0]) bottom_inter_cover();
*translate([-120,0,0]) arduino_box();
*translate([-150,0,2]) arduino_cover();
*translate([60,0,0]) connector_block();
*translate([100,0,0]) lock();

