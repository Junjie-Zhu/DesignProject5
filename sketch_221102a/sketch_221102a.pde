int num = 2;
int rc = 0;
Balls firstBall;
Balls[] newBalls;

void setup() {
    size(600, 800);

    frameRate(5);
}

Balls initiateBalls(int rc) {
    PVector p = new PVector(0, 0);
    float radius = 25.0;
    color lc;
    if (rc < 51) {
        lc = color(255, 200, 30, 255 - rc * 5);
    }
    else {
        lc = color(255, 200, 30, 0);
    }

    firstBall = new Balls(p, radius, lc);
    // firstBall.display();
    
    return firstBall;
}

Balls[] growBalls(int rc, int rc_, int n, Balls b) {
    newBalls = new Balls[n];
    PVector[] pl = new PVector[n];

    for (int i = 0; i < n; i++) {
        float tmp = map(noise(rc_ + i), 0, 1, 10, 50);
        float tmp_dir = map(noise(rc_ + i), 0, 1, PI, 2 * PI);
        color lcNew;
        pl[i] = new PVector(b.pos.x + (b.radius + tmp) * cos(tmp_dir), b.pos.y + (b.radius + tmp) * sin(tmp_dir));      
        float tmp_color_x = map(noise(pl[i].x), 0, 1, 0, 255);
        float tmp_color_y = map(noise(pl[i].y), 0, 1, 0, 255);

        if (rc < 51) {
            lcNew = color(tmp_color_x, tmp_color_y, (tmp_color_x + tmp_color_y) / 2, 255 - rc * 5);
        }
        else {
            lcNew = color(tmp_color_x, tmp_color_y, (tmp_color_x + tmp_color_y) / 2, 0);
        }  
        newBalls[i] = new Balls(pl[i], tmp, lcNew);
        float prob = random(0, 1);
        if (prob >= .9) {
            newBalls[i].display();
        }
        newBalls[i].connection(b.pos);
        if (abs(pl[i].x) > 300 || abs(pl[i].y) > 800) {
            pl[i].set((25.0 + tmp) * cos(tmp_dir), (25.0 + tmp) * sin(tmp_dir));
        }
    }

    return newBalls;
}

void draw() {
    background(0);
    translate(300, 800);

    Balls fBall = initiateBalls(rc);
    Balls[] tmp_balls = growBalls(rc, 0, num, fBall);

    int tmp_i = 0;
    while (tmp_i < rc) {
        for (int j = 0; j < num; j++) {
            tmp_balls = growBalls(rc - tmp_i, num * (tmp_i + 1), num, tmp_balls[j]);    
        }
        tmp_i += 1;
    }
    rc += 1;

    // fill(255);
    // noStroke();
    // rect(-300, -100, 600, 1000);

}
