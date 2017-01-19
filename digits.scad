module plate(width=48,height=58,left=false) {
    difference() {
        union() {
            hull()
            {
                // place 4 circles in the corners, with the given radius 1.5mm
                translate([(-width/2)+(1.5), (-height/2)+(1.5), 0])
                circle(r=1.5, $fn=50);

                translate([(width/2)-(1.5), (-height/2)+(1.5), 0])
                circle(r=1.5, $fn=50);

                translate([(-width/2)+(1.5), (height/2)-(1.5), 0])
                circle(r=1.5, $fn=50);

                translate([(width/2)-(1.5), (height/2)-(1.5), 0])
                circle(r=1.5, $fn=50);
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

module dots(width=48,height=58,holeSpacing=3,holeRadius=0.5) {
    union() {
        for(x=[-width/2:holeSpacing:width/2]) {
            for(y=[-height/2:holeSpacing:height/2]) {
                translate([x,y]) circle(holeRadius, $fn=10); 
            }
        } 
    }
}

width = 48;
height = 58;
holeSpacing = 0.6;
holeRadius = 0.05;

for(digit=[0:1:9]) {
    translate([digit*50, 0]) {
        difference() {
            plate(width, height, (digit % 2) == 0);
            intersection() {
                scale(4.4) translate([-3.5,-4.5]) text(str(digit), font="Arial");
                translate(
                digit == 0 ? [holeSpacing * 0.5 / 3, holeSpacing * 0.5 / 3] : [holeSpacing * (digit % 3) / 3, holeSpacing * floor(digit/3) / 3]) dots(width,height,holeSpacing,holeRadius);
            }
        }
    }
}
