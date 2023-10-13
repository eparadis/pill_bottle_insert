// an insert for a medicine bottle to hold the collets

include <BOSL2/std.scad>

pill_bottle_lower_ID = 29.1;
pill_bottle_upper_ID = 30.8; 
insert_height = 77;
pockets = 10;
handle_height = 12;
lengths = [60,55,47,45,40,37,33,30,25,22];
labels = ["3.0", "2.35", "2.0", "1.8", "1.5", "1.2", "1.0", "0.8", "0.6", "0.5"];
subdividers = true;

module _stop_customizer() {};

$fn=64;
eps = .01;

module divider(angle=0) {
  rotate([0,0,angle]) translate([0,-1/2,0]) cube([pill_bottle_lower_ID/2,1,insert_height]);
}

module pocket_divider(pockets, bit_lengths, enable) {
  d = 16;

  angles=[for (i=[0:360/pockets:360]) i];

  for(i=[0:pockets-1]) {
    h = bit_lengths[i]-5;
    if( enable[i] ) {
      rotate([0,0,angles[i]])
      translate([0,0,insert_height-bit_lengths[i]])
      difference() {
        linear_extrude(h) arc(n=64, d=d, angle=360/pockets, wedge=true);
        linear_extrude(h+eps) arc(n=64, d=d-1, angle=360/pockets, wedge=true);
      }
    }
  }
}

module handle() {
  length = 10;
  cylinder(h=insert_height+handle_height,d=5);
  translate([0,0,insert_height+handle_height-length]) cylinder(h=length,d1=5,d2=10);
}

module subtractive_pockets(pockets=6, lengths=[10,20,30,40,50,60]) {
  peek=10; // how much the drill bits will "peek out" from the pocket

  angles=[for (i=[0:360/pockets:360]) i];

  for(i=[0:pockets-1]) {
    translate([0,0,insert_height-lengths[i]]) rotate([0,0,angles[i]+2]) linear_extrude(lengths[i]+.1) arc(n=64, d=28+10, angle=360/pockets-2, wedge=true);
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
    translate([0,0,insert_height-lengths[i]-space])
    rotate([0,0,360/10/2+angles[i]])
    translate([14, -3, 0])
    rotate([90,90,90])
    linear_extrude(3, convexity=10)
    text(text=str(pocket_labels[i]), size=7, halign="left");
  }
}

module no_sides_case() {
  difference() {
    union() {
      difference() {
        union() {
          cylinder(h=insert_height, d1=pill_bottle_lower_ID, d2=pill_bottle_upper_ID);
        }
        subtractive_pockets(pockets, lengths);
        labels(pockets,
          labels,
          lengths
        );
      }
      handle();
      dividers(pockets);
      pocket_divider(pockets,
        lengths,
        subdividers? [ for (i = [0:pockets-1]) true ] : [ for (i = [0:pockets-1]) false ]
      );
    }
    cylinder(h=3,d1=22,d2=10);
  }
}


no_sides_case();

