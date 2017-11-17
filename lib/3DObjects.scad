use <utils.scad>;

module rounded_bar(lt,wt,ht,rt) {
    linear_extrude(height=ht) round_corners(rt) square([lt,wt]);
}

