// PRUSA iteration3
// Y frame corners
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
// Parameterized by D. Scott Williamson

metric=true;

inch2mm=25.4;

horizontal_rod_radius = (metric ? 4 : ((5/16)*inch2mm/2));
horizontal_rod_hole_radius= horizontal_rod_radius + 0.4;
horizontal_rod_length=270;
horizontal_rod_bridge_radius=2.6;

longitudinal_rod_radius= (metric ? 5 : ((1/2)*inch2mm/2));
longitudinal_rod_hole_radius= longitudinal_rod_radius + 0.4;
longitudinal_rod_length=270;

washer_radius=(metric ? 11 : ((1+3/8)*inch2mm/2));
washer_hole_radius=washer_radius + 0.4;
washer_height=10;

smooth_rod_radius=4.2;
smooth_rod_length=10;

corner_width=(longitudinal_rod_radius*2)+8;
corner_height=(horizontal_rod_radius*2)+14;
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
	translate([-corner_width/2,-corner_height/2,0])
		cube([corner_width,corner_height,corner_depth]);
}

module corner_holes()
{
	translate([-11,-corner_height/2,0])
	{
		// Top hole for horizontal rod
		translate([0,corner_height/2,30]) 
			rotate([0,90,0]) 
				translate([0,0,-5]) 
					cylinder(h = horizontal_rod_length, r=horizontal_rod_hole_radius);
		// Top hole bridge for horizontal rod
		translate([0,8.8,30])
			rotate([0,90,0]) 
				translate([0,0,-5]) 
					cylinder(h = horizontal_rod_length, r=horizontal_rod_bridge_radius, $fn=6);

		// Bottom hole for horizontal rod
		translate([0,corner_height/2,10]) 
			rotate([0,90,0]) 
				translate([0,0,-5]) 
					cylinder(h = horizontal_rod_length, r=horizontal_rod_hole_radius);
		// Bottom hole bridge for horizontal rod
		translate([0,8.8,10]) 
			rotate([0,90,0]) 
				translate([0,0,-5]) 
					cylinder(h = horizontal_rod_length, r=horizontal_rod_bridge_radius, $fn=6);

		// Middle hole for larger longitudinal rod
		translate([11,0,20]) 
			rotate([0,0,90]) 
				rotate([0,90,0]) 
					translate([0,0,-5]) 
						cylinder(h = longitudinal_rod_length, r=longitudinal_rod_hole_radius);

		// Washer hole for larger longitudinal rod
		translate([11,-3,20]) 
			rotate([0,0,90]) 
				rotate([0,90,0]) 
					translate([0,0,-5]) 
						cylinder(h = washer_height, r=washer_hole_radius);

		// Smooth rod place
		translate([11,2.75,47]) 
			rotate([0,90,90]) 
				cylinder(h = smooth_rod_length, r=smooth_rod_radius); 
		
		// Ziptie for smooth rod
		translate([-5,6,41])  
			cube([ziptie_length,ziptie_width,ziptie_height]);

		// LM8UU keepout
		difference()
		{
			translate([11,12.5,46]) 
				rotate([0,90,90]) 
					cylinder(h = lm8uu_keepout_length, r=lm8uu_keepout_radius);
			translate([21,12.5,62]) 
				rotate([0,90,90]) cube([20,20,30]);
		} 

		// Top smooth rod clearance knockout
		translate([21,12.5,57]) 
			rotate([0,90,90]) cube([15.2,20,20]);
	}
}


module corner_fancy()
{
	// Subtractive block dimension
	block_width=30;

	// Side corner cutouts
	translate([-(corner_width/2-1),-(corner_height/2-2),0])
		rotate([0,0,-45-180])
			translate([-block_width/2,0,-1]) 
				cube([block_width,block_width,corner_depth+2]);

	translate([(corner_width/2-1),-(corner_height/2-2),0])	
		rotate([0,0,45-180]) 
			translate([-block_width/2,0,-1]) 
				cube([block_width,block_width,corner_depth+2]);

	// Top corner cutouts
	translate([(corner_width/2-2),0,corner_depth]) 
		rotate([0,45,0]) 
			translate([-block_width/2,-block_width/2,0]) 
				cube([block_width,block_width,block_width]);

	translate([-(corner_width/2-2),0,corner_depth]) 
		rotate([0,-45,0]) 
			translate([-block_width/2,-block_width/2,0]) 
				cube([block_width,block_width,block_width]);

	// Top front edge cutout
	rotate([0,0,90])
		translate([-(corner_height/2-1.5),0,corner_depth]) 	
			rotate([0,-45,0]) 
				translate([-block_width/2,-block_width/2,0]) 
					cube([block_width,block_width,block_width]);
}

module selective_infill()
{
	translate([7,2,0.8])
		cube([0.2,33,5]); 
	translate([-7,2,0.8])
		cube([0.2,33,5]);
	
	translate([ 7,16,5.8])
		cube([0.2,8,11]);
	translate([-7,16,5.8])
		cube([0.2,8,11]);
	
	translate([7,2,16.8])
		cube([0.2,33,2]); 
	translate([-7,2,16.8])
		cube([0.2,33,2]);
}
    
// Final part
module corner()
{
	// Rotate the part for better printing
	translate([0,0,corner_height/2]) rotate([-90,0,0]) 
	{
		difference()
		{
			corner_base();
			corner_holes();
			corner_fancy();
			translate([0,corner_height/2,0]) 
				rotate([90,0,0])
					selective_infill();
		}
	}
}

// Render part
corner();



