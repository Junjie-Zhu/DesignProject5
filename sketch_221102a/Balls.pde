class Balls {
    PVector pos;
    float radius;
    color fc;

    Balls(PVector p, float r, color c) {
        pos = p;
        radius = r;
        fc = c;
    }

    void display() {
        noFill();
        stroke(fc);
        strokeWeight(radius % 4 + 2);
        ellipseMode(RADIUS);
        ellipse(pos.x, pos.y, radius, radius);
    }

    void connection(PVector pi) {
        stroke(fc);
        strokeWeight(radius % 4 + 2);
        line(pos.x, pos.y, pi.x, pi.y);
    }
}