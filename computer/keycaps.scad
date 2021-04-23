// most of the work was done by rsheldiii i love them: https://www.thingiverse.com/thing:468651
// CC BY-SA 3.0, because we have to

// keytop thickness, the top surface of the key
keytop_thickness = 5;

// wall thickness, the sides of the keycap. note this is the total thickness, aka 3 = 1.5mm walls
wall_thickness = 3;

//change to round things better
$fn = 32;

module roundedRect(size, r) {
	x = size[0];
	y = size[1];
	z = size[2];

	translate([-x/2,-y/2,0])
		linear_extrude(z)
		hull() {
		translate([r, r, 0])
			circle(r);

		translate([x - r, r, 0])
			circle(r);

		translate([x - r, y - r, 0])
			circle(r);

		translate([r, y - r, 0])
			circle(r);
	}
}

module connector(width, height, wid_diff, hei_diff, depth, tilt, skew){
	difference() {
		translate([-3.25, -2.7, 0])
			cube([6.5, 5.4, 5]);
		translate([0,0,2]) {
			cube([1.3, 5.5, 4], center=true);
			cube([4.4, 1.4, 4], center=true);
		}
		difference() {
			translate([0, 0, 50])
				cube([100000, 100000, 100000], center=true);
			shape(width, height, wid_diff, hei_diff, depth, tilt, skew, 0, 0);
		}
	}
}

module shape(width, height, wid_diff, hei_diff, depth, tilt, skew, thick_diff, depth_diff) {
	difference() {
		hull() {
			roundedRect([width - thick_diff, height - thick_diff, .001],1.5);

			translate([0,skew,depth - depth_diff])
				rotate([-tilt,0,0])
				roundedRect([width - thick_diff - wid_diff, height - thick_diff - hei_diff, .001],1.5);
		}
		dish(width, height, wid_diff, hei_diff, depth, tilt, skew, depth_diff);
	}
}

module dish(width, height, wid_diff, hei_diff, depth, tilt, skew, depth_diff) {
	top_width = width - wid_diff;
	top_height = height - hei_diff;

	x = top_width*top_width / 8;

	translate([0, skew + 0, depth - depth_diff])
		rotate([90-tilt,0,0])
		translate([0,x-0.5,0])
		cylinder(h=100,r=x+0.5, $fn=1024, center=true);
}

module key(bottom_width=18.16, bottom_height=18.16, top_width_diff=6,
		   top_height_diff=4, depth=11.5, tilt=-6, skew=1.75) {
	union() {
		difference() {
			shape(bottom_width, bottom_height, top_width_diff, top_height_diff, depth, tilt, skew, 0, 0);
			shape(bottom_width, bottom_height, top_width_diff, top_height_diff, depth, tilt, skew, wall_thickness, keytop_thickness);
		}
	}

	connector(bottom_width, bottom_height, top_width_diff, top_height_diff, depth, tilt, skew);
}

union() {
	difference() {
		key();
		translate([-7, -2, 10])
			linear_extrude(5)
			text("▲");
	}
	translate([30, 0, 0])
		key(bottom_height=36.32);
	translate([0, 30, 0]) {
		difference() {
			key();
			translate([-7, -3, 10])
				linear_extrude(5)
				text("▼");
		}
	}
}
