private int tick = 0;
private int light = 50;
private int incRed = -4;
private float x = 450;
private float y = 450;
private float radius = 25;
private boolean bump;
private int GRID_SIZE = 4;
private float definition; 
private float scaleFactor;
private float angularVelocity;
private PVector linearVelocity;
float a;

void setup() {
  size(900, 900);

  definition = 200/radius + 1;
  radius = definition * radius;
  scaleFactor = 1/definition;
}

void draw() {
  background(255);
  display();
  update();
  driveDirect(500, 400);
}

public void update() {
  a += angularVelocity;
  x += linearVelocity.x;
  y += linearVelocity.y;
}

public float getRadius() {
  return radius;
}

public void driveDirect(float left, float right) {
  if (tick == 1) {
    float speed = (left + right) / ((width + height)/2 / (GRID_SIZE * 2.0f));
    float ang = (left - right) / ((width + height)/2 / (float) (GRID_SIZE));
    drive(speed/4, ang/4);
  }
}

private void drive(float speed, float angle) {
  float y1 = (float) (Math.cos(a) * speed);
  float x1 = (float) (Math.sin(a) * speed);

  setLinearVelocity(new PVector(x1, y1));
  setAngularVelocity(angle);
}

private int drawRedDot() {
  light += incRed;
  if (light <= 0 || light >= 255)
    incRed = -incRed;
  return light;
}


public void display() {
  tick++;
  if (tick > 10) {
    setLinearVelocity(new PVector(0, 0));
    setAngularVelocity(0);
    tick = 0;
  }
  pushMatrix();
  scale(scaleFactor);
  translate(x + (definition * width)/2 - width/2, y + (definition * height)/2 - height/2);
  rotate(a);
  fill(0);
  stroke(0);
  strokeWeight(2);
  ellipse(0, 0, radius * 2, radius * 2);
  fill(100);
  arc(0, 0, radius * 2, radius * 2, 0, 2 * PI);
  fill(0);
  arc(0f, 0f, radius * 2.15f, radius * 2.15f, PI * 1.0f, 2.0f * PI);
  fill(169, 217, 109);
  arc(0f, 0f, radius * 1.75f, radius * 1.75f, 0f, 2f * PI);
  fill(255, 255, 184);
  arc(0, 0, radius, radius, 0, 2 * PI);
  fill(20);
  arc(0, 0, radius * .74f, radius * .75f, 0, 2 * PI);
  fill(230, 242, 244);
  arc(0, 0, radius / 2, radius / 2, 0, 2 * PI);
  fill(100);
  arc(0, 0 + radius * .875f, radius / 3, radius / 3, 0, 2 * PI);
  fill(100);
  arc(0, 0 + radius * .875f, radius / 4, radius / 4, 0, 2 * PI);
  fill(100);
  arc(0, 0 - radius, radius / 4f, radius / 4, 0, 2 * PI);
  fill(255, drawRedDot(), light);
  noStroke();
  ellipse(1, 1, 3 * radius/50, 3 * radius/50);
  popMatrix();
}

public boolean isBump() {
  return bump;
}

public void setBump(boolean bump) {
  this.bump = bump;
}

public void setAngularVelocity(float newVelocity) {
  angularVelocity = newVelocity/6.0;
}

public void setLinearVelocity(PVector newVelocity) {
  linearVelocity = new PVector(newVelocity.x * 1.6, newVelocity.y * -1.6);
}
