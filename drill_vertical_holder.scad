use </Users/thekostya/dev/3Dprinter/OpenSCADlibs/lib/ring.scad>;
use </Users/thekostya/dev/3Dprinter/OpenSCADlibs/lib/3DObjects.scad>;
use </Users/thekostya/dev/3Dprinter/OpenSCADlibs/lib/utils.scad>;
$fn=50;

module leg(legH,rt) {
    difference() {
        cylinder(r=rt,h=legH);
    }
    translate([rt*0.9,rt*0.25,0])
            rotate([90,0,0])
            linear_extrude(height=rt*0.5)
                polygon(
                    points=[
                        [0,0],
                        [0,rt],
                        [rt*8,0]
                    ]
                );
    rotate([0,0,90])
        translate([rt*0.9,rt*0.25,0])
            rotate([90,0,0])
            linear_extrude(height=rt*0.5)
                polygon(
                    points=[
                        [0,0],
                        [0,rt],
                        [rt*8,0]
                    ]
                );
}

module table(lt,wt,ht,legH, rt) {
    difference() {
        union() {
            difference() {
                rounded_bar(lt,wt,ht,rt);
                translate([rt*1.5,rt*1.5,-1]) rounded_bar(lt-3*rt,wt-3*rt,ht+2,rt);
            }
            translate([lt/2,wt/2,0]) cylinder(r=20,h=ht);
            translate([rt,rt,ht]) leg(legH,rt);
            translate([lt-rt,rt,ht]) rotate([0,0,90]) leg(legH,rt);
            translate([lt-rt,wt-rt,ht]) rotate([0,0,180]) leg(legH,rt);
            translate([rt,wt-rt,ht]) rotate([0,0,270]) leg(legH,rt);
            translate([rt,rt,0]) rotate([0,0,asin((wt-2*rt)/(lt-rt*0.5))])
                rotate([90,0,0])
                linear_extrude(height=rt*0.5)
                    polygon(
                        points=[
                            [0,0],
                            [0,rt*3],
                            [sqrt(pow(lt-2*rt,2) + pow(wt-2*rt,2))/2-18,5],
                            [sqrt(pow(lt-2*rt,2) + pow(wt-2*rt,2))/2-15,0]
                        ]
                    );
            translate([lt-rt,rt,0]) rotate([0,0,acos((wt-2*rt)/(lt-rt*0.5))+90])
                rotate([90,0,0])
                linear_extrude(height=rt*0.5)
                    polygon(
                        points=[
                            [0,0],
                            [0,rt*3],
                            [sqrt(pow(lt-2*rt,2) + pow(wt-2*rt,2))/2-18,5],
                            [sqrt(pow(lt-2*rt,2) + pow(wt-2*rt,2))/2-15,0]
                        ]
                    );
            translate([rt,wt-rt,0]) rotate([0,0,acos((wt-2*rt)/(lt-rt*0.5))-90])
                rotate([90,0,0])
                linear_extrude(height=rt*0.5)
                    polygon(
                        points=[
                            [0,0],
                            [0,rt*3],
                            [sqrt(pow(lt-2*rt,2) + pow(wt-2*rt,2))/2-18,5],
                            [sqrt(pow(lt-2*rt,2) + pow(wt-2*rt,2))/2-15,0]
                        ]
                    );
            translate([lt-rt,wt-rt,0]) rotate([0,0,asin((wt-2*rt)/(lt-rt*0.5))+180])
                rotate([90,0,0])
                linear_extrude(height=rt*0.5)
                    polygon(
                        points=[
                            [0,0],
                            [0,rt*3],
                            [sqrt(pow(lt-2*rt,2) + pow(wt-2*rt,2))/2-18,5],
                            [sqrt(pow(lt-2*rt,2) + pow(wt-2*rt,2))/2-15,0]
                        ]
                    );
        }
        translate([lt/2,wt/2,-1]) cylinder(r=15,h=ht+2);
    }
}

module support1(lt,wt,rt) {
    translate([rt*1.1,rt*0.25,0])
            rotate([90,0,0])
            linear_extrude(height=rt*0.5)
                polygon(
                    points=[
                        [0,0],
                        [0,rt*4],
                        [sqrt(pow(lt-2*rt,2) + pow(wt-2*rt,2))/2-31,10],
                        [sqrt(pow(lt-2*rt,2) + pow(wt-2*rt,2))/2-31,0]
                    ]
                );
}

module karetka_ring(lt,wt,rt) {
    union() {
        ring(rt*1.5,rt*1.02,rt*4,rt*0.05);
        translate([rt*1.1,rt*0.25,0])
            rotate([90,0,0])
            linear_extrude(height=rt*0.5)
                polygon(
                    points=[
                        [0,0],
                        [0,rt],
                        [rt*5,rt],
                        [rt*5,0]
                    ]
                );
        rotate([0,0,90])
            translate([rt*1.1,rt*0.25,0])
                rotate([90,0,0])
                linear_extrude(height=rt*0.5)
                    polygon(
                        points=[
                            [0,0],
                            [0,rt],
                            [rt*5,rt],
                            [rt*5,0]
                        ]
                    );
    }
}

module drill_ring() {
    difference() {
        ring(30,25,10,1);
        translate([-5,-30,-1]) linear_extrude(height=12) square(10,10);
    }
    difference() {
        union() {
            translate([5,-45,0]) cube([5,20,10]);
            translate([-10,-45,0]) cube([5,20,10]);
        }
        translate([-15,-35,5]) rotate([0,90,0]) cylinder(r=3,h=30);
    }
    
}

module karetka(lt,wt,ht,legH,rt) {
    union() {
        translate([rt,rt,0]) rotate([0,0,0]) karetka_ring(lt,wt,rt);
        translate([lt-rt,rt,0]) rotate([0,0,90]) karetka_ring(lt,wt,rt);
        translate([rt,wt-rt,0]) rotate([0,0,-90]) karetka_ring(lt,wt,rt);
        translate([lt-rt,wt-rt,0]) rotate([0,0,180]) karetka_ring(lt,wt,rt);
        translate([rt,rt,0]) rotate([0,0,asin((wt-2*rt)/(lt-rt*0.5))]) support1(lt,wt,rt);
        translate([lt-rt,rt,0]) rotate([0,0,acos((wt-2*rt)/(lt-rt*0.5))+90]) support1(lt,wt,rt);
        translate([rt,wt-rt,0]) rotate([0,0,acos((wt-2*rt)/(lt-rt*0.5))-90]) support1(lt,wt,rt);
        translate([lt-rt,wt-rt,0]) rotate([0,0,asin((wt-2*rt)/(lt-rt*0.5))+180]) support1(lt,wt,rt);
        translate([lt/2,wt/2,0]) drill_ring();
    }
}

module drill_head(lt,wt,ht,legH,rt) {
    table(lt,wt,ht,legH,rt);
    //translate([0,0,legH/2]) karetka(lt,wt,ht,legH,rt);
    translate([0,75,0]) karetka(lt,wt,ht,legH,rt);
}

drill_head(100,50,4,150,5);
