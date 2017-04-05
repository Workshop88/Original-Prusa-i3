// PRUSA iteration3
// Y frame corners
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
// and D. Scott Williamson

horizontal_rod_radius=4.4;
horizontal_rod_length=270;
horizontal_rod_bridge_radius=2.6;

longitudinal_rod_radius=5.4;
longitudinal_rod_length=270;

washer_radius=11;
washer_height=10;

smooth_rod_radius=4.2;
smooth_rod_length=10;

corner_width=18;
corner_height=22;
corner_depth=49;

lm8uu_keepout_radius=8;
lm8uu_keepout_length=270;

ziptie_width=3.5;
ziptie_length=30;
ziptie_height=2;

// Default facets for cylinders
$fn=30;

module corner_base()
{	
	translate([-9,-11,0])cube([18,22,49]);
}

module corner_holes()
{
	translate([-11,-11,0]){
		// Top hole
		translate([0,11,30]) rotate([0,90,0]) translate([0,0,-5]) cylinder(h = horizontal_rod_length, r=horizontal_rod_radius);
		// Top hole bridge
		translate([0,8.8,30]) rotate([0,90,0]) translate([0,0,-5]) cylinder(h = horizontal_rod_length, r=horizontal_rod_bridge_radius, $fn=6);

		// Bottom hole
		translate([0,11,10]) rotate([0,90,0]) translate([0,0,-5]) cylinder(h = horizontal_rod_length, r=horizontal_rod_radius);
		// Bottom hole bridge
		translate([0,8.8,10]) rotate([0,90,0]) translate([0,0,-5]) cylinder(h = horizontal_rod_length, r=horizontal_rod_bridge_radius, $fn=6);

		// Middle hole
		translate([11,0,20]) rotate([0,0,90]) rotate([0,90,0]) translate([0,0,-5]) cylinder(h = longitudinal_rod_length, r=longitudinal_rod_radius);

		// Washer hole
		translate([11,-3,20]) rotate([0,0,90]) rotate([0,90,0]) translate([0,0,-5]) cylinder(h = washer_height, r=washer_radius);

		// Top smooth rod insert
		// Smooth rod place
		translate([11,2.75,47]) rotate([0,90,90]) cylinder(h = smooth_rod_length, r=smooth_rod_radius); 
		// Ziptie
		translate([-5,6,41])  cube([ziptie_length,ziptie_width,ziptie_height]);

		// LM8UU keepout
		difference()
		{
			translate([11,12.5,46]) rotate([0,90,90]) cylinder(h = lm8uu_keepout_length, r=lm8uu_keepout_radius);
			translate([21,12.5,62]) rotate([0,90,90]) cube([20,20,30]);
		} 

		// Top smooth rod clearance knockout
		translate([21,12.5,57]) rotate([0,90,90]) cube([15.2,20,20]);
	}
}


module corner_fancy()
{
	// Side corner cutouts
	translate([-8,-9,0]) rotate([0,0,-45-180]) translate([-15,0,-1]) cube([30,30,51]);
	translate([8,-9,0]) rotate([0,0,45-180]) translate([-15,0,-1]) cube([30,30,51]);

	// Top corner cutouts
	translate([7,0,49]) rotate([0,45,0]) translate([-15,-15,0]) cube([30,30,30]);
	translate([-7,0,49]) rotate([0,-45,0]) translate([-15,-15,0]) cube([30,30,30]);

	rotate([0,0,90])
	{
		translate([-9.5,0,49]) rotate([0,-45,0]) translate([-15,-15,0]) cube([30,30,30]);
	}
}

module selective_infill()
{
	translate([7,2,0.8])cube([0.2,33,5]); 
	translate([-7,2,0.8])cube([0.2,33,5]);
	
	translate([ 7,16,5.8])cube([0.2,8,11]);
	translate([-7,16,5.8])cube([0.2,8,11]);
	
	translate([7,2,16.8])cube([0.2,33,2]); 
	translate([-7,2,16.8])cube([0.2,33,2]);
}
    
// Final part
module corner()
{
	// Rotate the part for better printing
	translate([0,0,11]) rotate([-90,0,0]) 
	{
		difference(){
			corner_base();
			corner_holes();
			corner_fancy();
			translate([0,11,0]) rotate([90,0,0])selective_infill();
		}
	}
}

corner();



