
M3_d=3;
screw_space=30;
$fn=32;

module block_screws()
{
    screw_pos = screw_space/2-M3_d*2;
    translate([-screw_pos,-screw_pos,0])
        cylinder(d=M3_d,h=100,center=true,$fn=32);
    translate([-screw_pos,+screw_pos,0])
        cylinder(d=M3_d,h=100,center=true,$fn=32);
    translate([+screw_pos,-screw_pos,0])
        cylinder(d=M3_d,h=100,center=true,$fn=32);
    translate([+screw_pos,+screw_pos,0])
        cylinder(d=M3_d,h=100,center=true,$fn=32);
}

lock_height = 30;
lock_width = 10;

module locks(width, height)
{
    translate([0,-height/2-lock_width])
    {
        translate([-width/2-lock_width,0,0]) difference()
        {
            linear_extrude(3) polygon([[0,0],[lock_height,0],[0,lock_height]]);
            translate([+lock_width/2,+lock_width/2,0]) cylinder(h=10,d=M3_d,center=true);
        }
        translate([+width/2+lock_width,0,0]) difference()
        {
            linear_extrude(3) polygon([[0,0],[-lock_height,0],[0,lock_height]]);
            translate([-lock_width/2,+lock_width/2,0]) cylinder(h=10,d=M3_d,center=true);
        }
    }
}

module phone_block(width, height, z)
{

    difference()
    {
        union()
        {
            hull() linear_extrude(5)
            {
                /* Main support */
                square([width/4,height], center=true);
            
                /* Top lock */
                translate([0,height/2-lock_height/2+lock_width])
                    square([width/4,lock_height], center=true);
            
                /* Bottom lock */
                translate([0,-height/2+lock_height/2-lock_width])
                    square([width+lock_width*2,lock_height], center=true);
            }
            
            /* Top wall */
            linear_extrude(z+5)
            translate([0,height/2-lock_height/2+lock_width])
            {
                translate([0,+lock_height/2-lock_width/2,0])
                    square([width/4,lock_width], center=true);
            }

            /* Bottom walls */
            //linear_extrude(z+5)
            translate([0,-height/2+lock_height/2-lock_width])
            {
                translate([-width/2-lock_width/2,0,0]) difference()
                {
                    linear_extrude(z+5) square([lock_width,lock_height], center=true);
                    %translate([-lock_width/2,+lock_width/2,0]) cylinder(h=10,d=M3_d,center=true);
                }
                translate([+width/2+lock_width/2,0,0]) difference()
                {
                    linear_extrude(z+5) square([lock_width,lock_height], center=true);
                    translate([+lock_width/2,+lock_width/2,0]) cylinder(h=10,d=M3_d,center=true);
                }
                translate([0,-lock_height/2+lock_width/2,0])
                    linear_extrude(z+5) square([width,lock_width], center=true);
            }
        }
        
        /* Screw space */
        translate([0,0,z/2])
            cylinder(d=screw_space+M3_d*2,h=z/4,center=true);

        for(a=[0,30,60])
            rotate([0,0,a])
                block_screws();
    }

    %color("red") translate([0,0,-2]) square([width,height], center=true);
}

module top_support(width, height, z, tube_diam)
{
    screw_support = 20;
    difference()
    {
        union() //hull()
        {
            translate([0,0,z/2*3])
                cube([width/2,height/2,z*2], center=true);
            translate([0,0,z/2])
                cube([width/2+2*tube_diam/3,height/2,z], center=true);
        }
        //translate([-width/2+screw_support/2,0,2*z])
        //    cube([M3_d*3,height,z], center=true);
        translate([0,0,-2])
            rotate([90,0,0])
                cylinder(d=tube_diam,h=height,center=true);
        /* Support screws */
        translate([-width/2+tube_diam/2,-height/8,0])
            cylinder(d=M3_d,h=height,center=true,$fn=32);
        translate([-width/2+tube_diam/2,+height/8,0])
            cylinder(d=M3_d,h=height,center=true,$fn=32);
        translate([+width/2-tube_diam/2,-height/8,0])
            cylinder(d=M3_d,h=height,center=true,$fn=32);
        translate([+width/2-tube_diam/2,+height/8,0])
            cylinder(d=M3_d,h=height,center=true,$fn=32);

        /* Block screws */
        for(a=[0,30,60])
            rotate([0,0,a])
                block_screws();
    }

    //%color("red") translate([0,0,-2]) square([width,height], center=true);
}

// Wiko: 145x73
translate([-0,0,0]) phone_block(73+1, 145+1, 10);
translate([+0,0,-30]) top_support(73+1, 65, 10, 28);

translate([-0,0,20]) locks(73+1,145+1);

// Asus Zenfone2: 153x78
//translate([-50,0,0]) phone_block(78, 153, 10);
//translate([+50,0,0]) top_support(78,60,10,40);