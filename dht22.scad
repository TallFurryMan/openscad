// Temperature and Humidity sensor

module DHT22()
{
    color("darkgreen") union()
    {
        translate([-35/2,-16/2,0])
            cube([35,16,2]);
        translate([35/2,0,0])
            linear_extrude(height=2)
                polygon(points=[[0,-8],[0,8],[5,6],[5,-6]]);
    }
    color("white") union()
    {
        translate([-35/2+15,-16/2,2])
            cube([20,16,10-2]);
        translate([35/2,0,2])
            linear_extrude(height=2)
                polygon(points=[[0,-8],[0,8],[5,6],[5,-6]]);
        translate([-35/2,-10/2,2])
            cube([7,10,8-2]);
    }
    color("gray") union()
    {
        translate([-35/2+7,-8/2,-2])
            cube([2,8,2]);
        translate([-35/2+14,-11/2,-2])
            cube([2,11,2]);
        translate([35/2+2,0,-1])
            cylinder(d=5,h=6,$fn=32);
    }
    color("red") union()
    {
        translate([-35/2+10,-16/2+2/2+1,2/2+2])
            cube([4,2,2],center=true);
    }
}

DHT22();