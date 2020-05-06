include <libraries/nutsnbolts-master/cyl_head_bolt.scad>
$fn=60;
board_length = 44;
board_width = 21.5;
board_height = 12;
module board()
{
    $fn = 32;
    width = board_width;
    length = board_length;
    dip = 2;
    pcb_height = 1.5;
    height = board_height;
    translate([0,0,height/2+pcb_height/2]) difference() {
        union() {
            union() {
                color("blue") translate([0,0,-height/2])
                    cube([length,width,pcb_height], center=true);
                color("grey") union() {
                    translate([-length/2+8.2/2,0,0])
                        cylinder(h=12.4-pcb_height, d=8.2, center=true);
                    translate([+length/2-8.2/2,0,0])
                        cylinder(h=12.4-pcb_height, d=8.2, center=true);
                }
                color("gold") translate([length/2-20+3/2,width/2-4,0])
                    cylinder(h = 14, d = 3, center=true);
                color("black") translate([+13/2,-width/2+13/2,-pcb_height/2])
                    cube([12.6,12.6,9],center=true);
                color("black") translate([-13/2,+width/2-12/2,-pcb_height/2-3])
                    cube([12.6,11.6,4],center=true);
                color("cyan") translate([+13-10/2,+width/2-6/2-(21.5-13-6)/2,-pcb_height/2])
                    cube([10,6,12],center=true);
            }
            //translate([0,0,0])
            //    cube([length,width,height-pcb_height], center=true);
            translate([0,0,-dip/2-pcb_height/2-height/2])
                cube([length-10*2,width,dip], center=true);
        }
        color("red") translate([(-30/2),(+17/2),-pcb_height/2])
            cylinder(h = height+pcb_height, d = 3.5, center=true);
        color("red") translate([(+30/2),(-17/2),-pcb_height/2])
            cylinder(h = height+pcb_height, d = 3.5, center=true);
    }
}

module lm2596_enclosure()
{
    width=board_width+2;
    length=board_length+10*2;
    height=board_height+2;
        
    difference() {
        union() {
            translate([0,0,-3]) {
                difference() {
                    union() {
                        translate([0,0,0.5])
                            cube([length,width,1],center=true);
                        translate([-length/2+10,0,2])
                            cube([20,width,2],center=true);
                        translate([+length/2-10,0,2])
                            cube([20,width,2],center=true);
                        translate([-length/2+9,0,board_height/2+4])
                            cube([2,width,board_height+2],center=true);
                        translate([+length/2-9,0,board_height/2+4])
                            cube([2,width,board_height+2],center=true);
                        translate([-length/2+8/2,0,board_height/2+4])
                            cube([8,8,board_height+2],center=true);
                        translate([+length/2-8/2,0,board_height/2+4])
                            cube([8,8,board_height+2],center=true);
                        translate([0,+width/2-0.5,board_height/2+2.5])
                            cube([length-16,1,board_height+5],center=true);
                        translate([0,-width/2+0.5,board_height/2+2.5])
                            cube([length-16,1,board_height+5],center=true);
                    }
                    translate([-length/2+10+5/2,+width/2-5/2,2.1])
                        cube([5,3.5,2],center=true);
                    translate([-length/2+10+5/2,-width/2+5/2,2.1])
                        cube([5,3.5,2],center=true);
                    translate([+length/2-10-5/2,+width/2-5/2,2.1])
                        cube([5,3.5,2],center=true);
                    translate([+length/2-10-5/2,-width/2+5/2,2.1])
                        cube([5,3.5,2],center=true);
                    translate([-length/2+10,+width/2-5/2-0.5,4.5])
                        cube([10,3.5,4],center=true);
                    translate([-length/2+10,-width/2+5/2+0.5,4.5])
                        cube([10,3.5,4],center=true);
                    translate([+length/2-10,+width/2-5/2-0.5,4.5])
                        cube([10,3.5,4],center=true);
                    translate([+length/2-10,-width/2+5/2+0.5,4.5])
                        cube([10,3.5,4],center=true);
                }
            }
        
            translate([0,0,board_height+8])
            {
                cube([length-16,width,1],center=true);
                cube([length-9,8,1],center=true);
            }

            translate([-length/2+4/2,0,board_height+8])
            {
                cube([4,width,2],center=true);
                translate([1,-width/2+6/2,-board_height/2])
                    cube([6,6,board_height],center=true);
                translate([1,+width/2-6/2,-board_height/2])
                    cube([6,6,board_height],center=true);
            }

            translate([+length/2-4/2,0,board_height+8])
            {
                cube([4,width,2],center=true);
                translate([-1,-width/2+6/2,-board_height/2])
                    cube([6,6,board_height],center=true);
                translate([-1,+width/2-6/2,-board_height/2])
                    cube([6,6,board_height],center=true);
            }
        }

        translate([0,0,5])
        {
            color("red") translate([(-30/2),(+17/2),-pcb_height/2])
                hole_through(name="M2", l=10, cld=0.1, h=2, hcld=0.4);
            color("red") translate([(+30/2),(-17/2),-pcb_height/2])
                hole_through(name="M2", l=10, cld=0.1, h=2, hcld=0.4 );
        }

        translate([0,0,board_height+15])
        {
            color("red") translate([-length/2+7,0,-pcb_height/2])
                hole_through(name="M2", l=22, cld=0.1, h=2, hcld=0.4);
            color("red") translate([+length/2-7,0,-pcb_height/2])
                hole_through(name="M2", l=22, cld=0.1, h=2, hcld=0.4 );
            color("red") translate([-length/2+2,0,-pcb_height/2])
                hole_through(name="M2", l=22, cld=0.1, h=2, hcld=0.4);
            color("red") translate([+length/2-2,0,-pcb_height/2])
                hole_through(name="M2", l=22, cld=0.1, h=2, hcld=0.4 );
        }
    }
}

lm2596_enclosure();
//board();
