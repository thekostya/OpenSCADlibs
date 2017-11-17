use <utils.scad>;

module ring(extD=2, intD=1, Height=1, rounded=0.3) {
    rotate_extrude(convexity=10)
        translate([intD,0])
            round_corners(rounded)
                square([extD-intD,Height]);
}

module test_ring() {
    ring();
}
