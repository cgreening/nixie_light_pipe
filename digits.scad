module plate(width=48,height=58,radius=3,left=false) {
    difference() {
        union() {
            hull()
            {
                // place 4 circles in the corners, with the given radius
                translate([(-width/2)+(radius), (-height/2)+(radius), 0])
                circle(r=radius, $fn=50);

                translate([(width/2)-(radius), (-height/2)+(radius), 0])
                circle(r=radius, $fn=50);

                translate([(-width/2)+(radius), (height/2)-(radius), 0])
                circle(r=radius, $fn=50);

                translate([(width/2)-(radius), (height/2)-(radius), 0])
                circle(r=radius, $fn=50);
            };
            translate([left ? -9 : 0, -height/2+1])
            polygon([[0,0],[9,0],[7,-4],[2,-4]]);
        };
        translate([-width/2 + 3, -height/2 + 3]) circle(1.5, $fn=50);
        translate([-width/2 + 3, height/2 - 3]) circle(1.5, $fn=50);
        translate([width/2 - 3, -height/2 + 3]) circle(1.5, $fn=50);
        translate([width/2 - 3, height/2 - 3]) circle(1.5, $fn=50);
    };
};

module dots(width=48,height=58) {
    union() {
        for(x=[-width/2:1:width/2]) {
            for(y=[-height/2:1:height/2]) {
                translate([x,y]) circle(0.1, $fn=50); 
            }
        } 
    }
}

width = 48;
height = 58;

for(digit=[0:1:9]) {
    translate([digit*50, 0]) {
        difference() {
            plate(width, height, 3, (digit % 2) == 0);
            intersection() {
                scale(4.7) translate([-4.5,-4]) text(str(digit), font="Courier:style=Bold");
                translate([(digit % 3),floor(digit/3)]) dots(width,height);
            }
        }
    }
}