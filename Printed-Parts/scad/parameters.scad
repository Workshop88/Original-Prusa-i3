// PRUSA iteration3
// Y frame corners
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
// Parameterized by D. Scott Williamson

// MASTER PARAMETERS FILE

// Default to original metric 
metric=true;

// mm in an inch (comversion rate)
inch2mm=25.4;

// Default facets for cylinders
$fn=30;

// Parameters related to printer base 
// affected parts:
//		y-corners.scad
//		y-motor.scad
// 		y-idler.scad
// 		y-distance.scad

	// horizontal rod dimensions
	horizontal_rod_radius = (metric ? 4 : ((5/16)*inch2mm/2));
	horizontal_rod_hole_radius= horizontal_rod_radius + 0.4;
	horizontal_rod_length=270;
	horizontal_rod_bridge_radius=2.6;
	horizontal_rod_washer_radius=(metric ? 10 : ((15/16)*inch2mm/2));
	horizontal_rod_lower_height=horizontal_rod_washer_radius;
	horizontal_rod_upper_height=horizontal_rod_washer_radius*3;
	
	// longitudinal rod dimensions
	longitudinal_rod_radius= (metric ? 5 : ((1/2)*inch2mm/2));
	longitudinal_rod_hole_radius= longitudinal_rod_radius + 0.4;
	longitudinal_rod_length=270;
	longitudinal_rod_height=20;
	
	longitudinal_rod_washer_radius=(metric ? 11 : ((1+3/8)*inch2mm/2));
	longitudinal_rod_washer_hole_radius=longitudinal_rod_washer_radius + 0.4;
	longitudinal_rod_washer_thickness=10;
	
	smooth_rod_radius=4.2;
	smooth_rod_length=10;
	smooth_rod_height=47;
	smooth_rod_end_thickness=2.75;
	
	corner_width=(longitudinal_rod_radius*2)+8;
	corner_height=(horizontal_rod_radius*2)+14;
	corner_depth=49;
	
	lm8uu_keepout_radius=8;
	lm8uu_keepout_length=270;
	lm8uu_keepout_height=smooth_rod_height-1;
	lm8uu_keepout_offset=12.5;
	
	ziptie_width=3.5;
	ziptie_length=30;
	ziptie_height=2;


