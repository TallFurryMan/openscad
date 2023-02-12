// Filter wheel

$fn = 128;

// Main cylinder
Rm = 100; // Radius
Hm = 30; // Height
Nm = 8; // Narrowness

// Optical hole
Ro = 0.75*Rm/2; // Radius, external
Do = Rm - Ro - 5; // Center offset from wheel center
Ho = Hm + 10; // Representative height
No = 4; // Narrowness
Ho2 = 2*Ho;

// Rotator access
Dr = 0.2*Rm; // Hollowed depth
Ar = acos(1-Dr/Rm); // Resulting angle

// Rotator keyhole
Rk = 10;

// Filter wheel
Rw = 0.9*Rm; // Wheel radius
Hw = Hm/3; // Height
Rf = 0.6*Ro; // Filter Radius
Nf = 5; // Number of filters
Ff = 9; // Font
Gf = 130; // Gear count
Gb = Rw*sin(360/Gf)/2; // Gear half base
Gh = Gb*sin(60); // Gear height

// Screws
Rs = 4;

module filter_wheel(wheel_angle)
{
rotate([0,0,90]) difference()
{
    difference()
    {
        union()
        {
            color([0.5,0.5,0.5])
                cylinder(r = Rm, h = Hm, center = true);
            color([0.4,0.4,0.4])
                translate([Do,0,0])
                {
                    cylinder(r = Ro, h = Ho, center = true);
                    cylinder(r = Ro-No, h = Ho2, center = true);
                }
        }
        translate([Do,0,0])
            cylinder(r = Ro-No*2, h = Ho2*1.1, center = true);
    }
    cylinder(r = Rm - Nm, h = Hm - Nm*2, center = true);
    translate([0,-(Rm-Dr/2),Hm/2])
        cube([2*Rm,Dr,Hm], center = true);
    translate([0,-(Rm-Dr),Hm/2])
        cylinder(r = Rk, h = Hm, center = true);
}
difference()
{
    union()
    {
        cylinder(r = Rw, h = Hw, center = true);
        color([0.3,0.2,0.2]) for(a = [0:Nf-1])
            rotate([0,0,a*360/Nf-wheel_angle*360])
                translate([Do+Ro/2,0,Hw/2*1.1])
                    text(text = str(a+1), size = Ff, halign = "center", valign = "center");
        for(a = [0:Gf])
            rotate([0,0,a*360/Gf-wheel_angle*360])
                translate([Rw-Rw*(1-cos(360/Gf)),0,0])
                    linear_extrude(height = Hw, center = true)
                        polygon([[Gh,0],[0,-Gb],[0,+Gb]]);
    }
    for(a = [0:Nf-1])
    {
        rotate([0,0,a*360/Nf+90-wheel_angle*360])
            translate([Do,0,0])
                cylinder(r = Rf, h = Hw*1.1, center = true);
    }
}
for(a = [0:4])
    rotate([0,0,a*90+45])
        translate([Rm-Rs,0,0])
            cylinder(r = Rs, h = Hm*1.1, center = true);
cylinder(r = Rs, h = Hm*1.1, center = true);
}


// Motor holder
Hh = 10; // Holder height
Wh = 30; // Holder width
Ws = Wh; // Side support width
Ns = 10; // Side support narrowness
Whh = 15; // Holder hole width
Hhh = 5; // Holder hole height

module motor_holder_section()
{
    polygon([[Whh/2,Hhh],[Whh/2,0],[Wh/2,0],[Wh/2,Hh],
             [-Wh/2,Hh],[-Wh/2,0],[-Whh/2,0],[-Whh/2,Hhh]]);
}

module motor_holder_removal(side) render()
{
    translate([-side,0,0])
        cube([2*side,side,Hm]);
    translate([-side,-side,0])
        cube([side,side,Hm]);
    rotate([0,0,90-Ar])
        translate([-side,-side,0])
            cube([side,side,Hm]);
};

/*
module motor_holder_curved(radius)
translate([0,-radius,0])
rotate([0,0,90])
{
    render() difference()
    {
        rotate_extrude(convexity = 2)
            translate([radius,0,0])
                motor_holder_section();
        motor_holder_removal(radius+Whh);
    }
    translate([(radius+Wh)*cos(Ar),-(radius+Wh)*sin(Ar),0])
    rotate([0,0,-Ar])
    mirror([1,0,0])
    color("green") render() difference()
    {
        rotate_extrude(convexity = 2)
            translate([Wh,0,0])
                motor_holder_section();
        motor_holder_removal(Wh+Whh);
    }
}

translate([0,0,Hm/2]) union()
{
    length = Rm*cos(Ar) + Wh*cos(Ar);
    motor_holder_curved(length);
    mirror([0,1,0]) motor_holder_curved(length);
    %rotate([90,0,0])
        rotate([0,-90,0])
            linear_extrude(height = Rm)
                motor_holder_section();
}
*/
/*for (s = [0,180]) rotate([s,0,0]) difference()
{
    Ar2 = Ar - asin(Wh/2/Rm);
    for (a = [0,180+Ar2,180-Ar2])
        rotate([0,0,a])
            translate([-Rm/2,0,Hm/2+Hh/2])
                cube([Rm,Wh,Hh], center = true);
    for (a = [0,180+Ar2,180-Ar2])
        rotate([0,0,a])
            translate([-Rm/2,0,Hm/2+Hh/2])
                translate([0,0,-Hhh/2])
                    cube([Rm*1.1,Whh,Hhh*1.1], center = true);
}
*/

module holder_wheel_side()
translate([0,0,Hh+Hhh])
{
    rotate([90,0,270])
        linear_extrude(height = Rm, convexity = 2)
            motor_holder_section();
        rotate([90,0,90])
            linear_extrude(height = Rm*cos(Ar), scale = [Rm/Whh*sin(Ar),1], convexity = 2)
                motor_holder_section();
}
holder_wheel_side();
rotate([180,0,0]) holder_wheel_side();

// Motor holder
Rg = Rw/Nf;
Hg = Hw/2;
Wmh = Rg*4; // Holder width

module holder_motor_block(wheel_angle)
translate([Rm*2,0])
{
    Gf = 130*Rg/Rw; // Gear count
    Gb = Rg*sin(360/Gf)/2; // Gear half base
    Gh = Gb*sin(60); // Gear height
    color("red") cylinder(r=1,h=100,center=true);
    render() difference()
    {
        translate([Rm*cos(Ar)+Wmh/2,0])
            cube([Wmh,2*Rm*sin(Ar),Hm+Hh*2], center = true);
        cylinder(r = Rw, h = Hm, center = true);
        translate([Rw+Rg+Gh,0,Hg/2])
            cylinder(r = Rg, h = 1.1*Hw/2, center = true);
    }
    color("pink")
        translate([Rw+Rg+Gh,0,Hg/2])
        {
            difference()
            {
                union()
                {
                    cylinder(r = Rg, h = Hw/2, center = true);
                    for(a = [0.5:Gf+0.5])
                        rotate([0,0,a*360/Gf+wheel_angle*360*(Rw/Rg)])
                            translate([Rg-Rg*(1-cos(360/Gf)),0,0])
                                linear_extrude(height = Hg, center = true)
                                    polygon([[Gh,0],[0,-Gb],[0,+Gb]]);
                }
                rotate([0,0,wheel_angle*360*(Rw/Rg)])
                {
                    translate([-Rg*0.95-Gh,0])
                        cube([Rg*0.1+Gh*2,Rg*2,1.1*Hw/2], center = true);
                    /*translate([+Rg*0.95+Gh,0])
                        cube([Rg*0.1+Gh*2,Rg*2,1.1*Hw/2], center = true);*/
                }
            }
        }
}
holder_motor_block(wheel_angle = $t)

translate([-Rm-Ns,0,0])
    cube([Ns,Ws,Hm+Hh*2], center = true);

filter_wheel(wheel_angle = $t);