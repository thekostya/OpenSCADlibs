module ring(extD=2, intD=1, Height=1, rounded=0.3) {
    rotate_extrude(convexity=10)
        translate([intD,0])
            offset(r=rounded) offset(delta=-rounded)
                square([extD-intD,Height]);
}

module test_ring() {
    ring();
}
