linear_extrude(5)
difference() {
    square(43);
    translate([14.5, 24])
    square(14);
    translate([5, 5])
    square(14);
    translate([24, 5])
    square(14);
}
