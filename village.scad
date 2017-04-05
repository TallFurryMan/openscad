module maison1()
{
union() {color("beige") cube([5,3,3]);
translate([0,0,3]) color("red") polyhedron([
    [0,0,0],
    [5,0,0],
    [5,3,0],
    [0,3,0],
    [5-0.1,1.5,2],
    [0+0.1,1.5,2]],[
    [0,1,4,5],
    [2,3,5,4],
    [1,2,4],
    [0,5,3]]);
}
}
module eglise()
{
union()
{
    color("beige") cube([2,3,6]);
    maison1();
    translate([0,0,6]) color("red") polyhedron([
        [0,0,0],
        [2,0,0],
        [2,3,0],
        [0,3,0],
        [1,1.5,2]],[
        [0,1,4],
        [1,2,4],
        [2,3,4],
        [3,0,4]]);
}
}

module arbre(tronc=3,feuillage=1.5)
{
    color("brown") cylinder(h=tronc,d=0.5);
    translate([0,0,tronc]) color("green") sphere(feuillage);
}
module socle() cube([13,10,0.5]);

scale(10) union() {
    color("brown") socle();
    eglise();
    translate([8,0,0]) maison1();
    translate([8,6,0]) maison1();
    translate([2,7.3,0]) scale([1.5,1.5,1.5]) arbre();
    translate([4,8,0]) arbre();
    //translate([2.5,5.5,0]) arbre();
    //translate([4,5,0]){ cylinder(h=5,d=1); translate([0,0,5]) sphere(2);}
    translate([4,5,0]) arbre(tronc=5,feuillage=2);
    translate([8,3,0]) color("green"){
        cube([5,3,0.6]); 
        translate([2,1.5,1]) sphere(0.7);
    }
    color("green") for(x=[1:7]) translate([x,9.5,0.9]) sphere(0.5);
    color("green") for(y=[0:5]) translate([1,y+3.5,0.9]) sphere(0.5);
}