square_width = 80;

$fn=32;
difference()
{
    minkowski() {
        cube([square_width,square_width,1],center=true);
        cylinder(h=3,r=2);
    }
    union() {
        space = square_width/3;
        for (x = [0:3]) {
            for (y = [0:3]) {
                translate([(x-2)*space,(y-2)*space,0]) cylinder(h=8,r=6,center=true);
        for (a = [0:3]) {
            rotate(45,[0,0,1])
                translate([square_width/2-5,square_width/2-5,0])
                    cylinder(h=8,r=3,center=true);
        }
    }}}
}