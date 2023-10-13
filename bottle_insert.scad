// an insert for a medicine bottle to hold the collets

include <BOSL2/std.scad>
use <pin_vise_collet.scad>;

module _stop_customizer();

$fn=64;
eps = .01;

case_height = 77;
handle_height = 12;

module divider(angle=0) {
  rotate([0,0,angle]) translate([0,-1/2,0]) cube([29.1/2,1,case_height]);
}

module pocket_divider(pockets, bit_lengths, enable) {
  d = 16;

  angles=[for (i=[0:360/pockets:360]) i];

  for(i=[0:pockets-1]) {
    h = bit_lengths[i]-5;
    if( enable[i] ) {
      rotate([0,0,angles[i]])
      translate([0,0,case_height-bit_lengths[i]])
      difference() {
        linear_extrude(h) arc(n=64, d=d, angle=360/pockets, wedge=true);
        linear_extrude(h+eps) arc(n=64, d=d-1, angle=360/pockets, wedge=true);
      }
    }
  }
}

module outside() {
  difference() {
    cylinder(h=case_height, d1=29.1, d2=30.8);
    translate([0,0,1]) cylinder(h=case_height, d=28);
  }
}

module handle() {
  length = 10;
  cylinder(h=case_height+handle_height,d=5);
  translate([0,0,case_height+handle_height-length]) cylinder(h=length,d1=5,d2=10);
}

module dividers_with_pockets(pockets=6, lengths=[10,20,30,40,50,60]) {
  peek=10; // how much the drill bits will "peek out" from the pocket

  angles=[for (i=[0:360/pockets:360]) i];

  for(i=[0:pockets-1]) {
    divider(angles[i]);
    rotate([0,0,angles[i]]) linear_extrude(case_height-lengths[i]+peek) arc(n=64, d=28+0.1, angle=360/pockets, wedge=true);
  }
}

module subtractive_pockets(pockets=6, lengths=[10,20,30,40,50,60]) {
  peek=10; // how much the drill bits will "peek out" from the pocket

  angles=[for (i=[0:360/pockets:360]) i];

  for(i=[0:pockets-1]) {
    translate([0,0,case_height-lengths[i]]) rotate([0,0,angles[i]+2]) linear_extrude(lengths[i]+.1) arc(n=64, d=28+10, angle=360/pockets-2, wedge=true);
  }
}

module dividers(pockets=6) {
  peek=10; // how much the drill bits will "peek out" from the pocket

  angles=[for (i=[0:360/pockets:360]) i];

  for(i=[0:pockets-1]) {
    divider(angles[i]);
  }
}

module labels(pockets=6, pocket_labels=["1.0", "2.0", "3.0", "4.0", "5.0", "6.0"], lengths=[10,20,30,40,50,60]) {
  space = 2; // how far below the pocket the text starts
  angles=[for (i=[0:360/pockets:360]) i];

  for(i=[0:pockets-1]) {
    translate([0,0,case_height-lengths[i]-space])
    rotate([0,0,360/10/2+angles[i]])
    translate([14, -3, 0])
    rotate([90,90,90])
    linear_extrude(3, convexity=10)
    text(text=str(pocket_labels[i]), size=7, halign="left");
  }
}

module full_case() {
  union() {
    outside();
    handle();
    dividers_with_pockets(10, [60,55,47,45,40,37,33,30,25,22]);
  }
}

module no_sides_case() {
  difference() {
    union() {
      difference() {
        union() {
          cylinder(h=case_height, d1=29.1, d2=30.8);
        }
        subtractive_pockets(10, [60,55,47,45,40,37,33,30,25,22]);
        labels(10,
          ["3.0", "2.35", "2.0", "1.8", "1.5", "1.2", "1.0", "0.8", "0.6", "0.5"],
          [60,55,47,45,40,37,33,30,25,22]
        );
      }
      handle();
      dividers(10);
    }
    cylinder(h=3,d1=22,d2=10);
  }
}

// for mockup display only
module collet_and_bit(bit_length=30, bit_diameter=0.8) {
  h = case_height-bit_length; // floor of the pocket
  color("yellow") translate([0, -12, h+.1]) rotate([0,0,30]) collet(bit_diameter);
  color("green") translate([0, -12, h+11.28+.25]) cylinder(h=bit_length, d=bit_diameter);
}

module collets_and_bits(lengths, diameters) {
  n = len(lengths);
  angles=[for (i=[0:360/n:360]) i];
  for(i=[0:n-1]) {
    rotate([0,0,angles[i]+90+(360/n/2)]) collet_and_bit(lengths[i], diameters[i]);
  }
}

//full_case();
no_sides_case();

%collets_and_bits(
  [60,55,47,45,40,37,33,30,25,22],
  [3.0, 2.35, 2.0, 1.8, 1.5, 1.2, 1.0, 0.8, 0.6, 0.5]
);

pocket_divider(10,
  [60,55,47,45,40,37,33,30,25,22],
  [false, false, false, false, false, true, true, true, true, true]
);

