
module body()
{
    union()
    {
        cylinder(h = 19, d = 28, center = [0,0,0]);
        translate([-14.6/2,-17,19-16]) cube([14.6,17,16]);
    }
}

module ear()
{
    translate([-35/2,0,19-0.8/2])
    {
        difference()
        {
            union()
            {
                cylinder(h=0.8, d=7, center=true);
                translate([0,-7/2,-0.8/2])
                {
                    cube([7,7,0.8]);
                }
            }
            cylinder(h=0.8+0.1, d=4.2, center=true);
        }
    }
}

module axis()
{
    translate([0,8,19])
    {
        cylinder(h=1.5, d=9);
        difference()
        {
            cylinder(h=10, d=5);
            #translate([-3,(+5-3)/2,4]) cube([3*2,2,6]);
            #translate([-3,(-5+3)/2-2,4]) cube([3*2,2,6]);
        }
    }
}

module stepper_28BYJ_48()
{
    body();
    ear();
    mirror(v=[-1,0,0]) ear();
    axis();
}

stepper_28BYJ_48();