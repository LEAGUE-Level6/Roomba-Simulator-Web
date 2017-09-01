private float definition; 
private float scaleFactor;
private int light = 50;
private int incRed = -4;

private float x = 450;
private float y = 450;
private float radius = 40;
private float drawingRadius;
private boolean bump;
private int GRID_SIZE = 4;
private float angularVelocity;
private PVector linearVelocity = new PVector(0, 0);
private float preSpeed;
private float preAngle;
private float angle = 0;

void setup() {
  size(900, 900);

  definition = 200/radius + 1;
  drawingRadius = definition * radius;
  scaleFactor = 1/definition;
  driveDirect(500, 100);
}

void draw() {
  background(255);
  display();
  update();
  fill(255, 0,0);
  text("Left Sensor: " + (int) ultrasonicDistance(LEFT), 20, 20);
  text("Center Sensor: " + (int) ultrasonicDistance(CENTER), 145, 20);
  text("Right Sensor: " + (int) ultrasonicDistance(RIGHT), 275, 20);
}

public void update() {
  drive(preSpeed/20, preAngle/20);
  if(angle >= 2*PI)
    angle = 0;
}

public float getRadius() {
  return radius;
}

public void driveDirect(float left, float right) {
  preSpeed = (left + right) / ((width + height)/2 / (GRID_SIZE * 2.0f));
  preAngle = (left - right) / ((width + height)/2 / (float) (GRID_SIZE));
}

private void drive(float speed, float a) {
  float y1 = (float) (Math.cos(angle) * speed);
  float x1 = (float) (Math.sin(angle) * speed);

  setLinearVelocity(new PVector(x1, y1));
  setAngularVelocity(a);

  angle += angularVelocity;
  x += linearVelocity.x;
  y += linearVelocity.y;
}

private int drawRedDot() {
  light += incRed;
  if (light <= 0 || light >= 255)
    incRed = -incRed;
  return light;
}


public void display() {
  pushMatrix();
  translate(x, y);
  scale(scaleFactor);
  rotate(angle);
  fill(0);
  stroke(0);
  strokeWeight(2);
  ellipse(0, 0, drawingRadius * 2, drawingRadius * 2);
  fill(100);
  arc(0, 0, drawingRadius * 2, drawingRadius * 2, 0, 2 * PI);
  fill(0);
  arc(0f, 0f, drawingRadius * 2.15f, drawingRadius * 2.15f, PI * 1.0f, 2.0f * PI);
  fill(169, 217, 109);
  arc(0f, 0f, drawingRadius * 1.75f, drawingRadius * 1.75f, 0f, 2f * PI);
  fill(255, 255, 184);
  arc(0, 0, drawingRadius, drawingRadius, 0, 2 * PI);
  fill(20);
  arc(0, 0, drawingRadius * .74f, drawingRadius * .75f, 0, 2 * PI);
  fill(230, 242, 244);
  arc(0, 0, drawingRadius / 2, drawingRadius / 2, 0, 2 * PI);
  fill(100);
  arc(0, 0 + drawingRadius * .875f, drawingRadius / 3, drawingRadius / 3, 0, 2 * PI);
  fill(100);
  arc(0, 0 + drawingRadius * .875f, drawingRadius / 4, drawingRadius / 4, 0, 2 * PI);
  fill(100);
  arc(0, 0 - drawingRadius, drawingRadius / 4f, drawingRadius / 4, 0, 2 * PI);
  fill(255, drawRedDot(), light);
  noStroke();
  ellipse(1, 1, 3 * drawingRadius/50, 3 * drawingRadius/50);
  
  float uWidth = 0.3 * drawingRadius;
  
  translate(uWidth/2, -1.06 * drawingRadius);
  rotate(PI);
  drawUltrasonic(uWidth);

  translate(uWidth/2, -1.06 * drawingRadius - uWidth/2);
  translate(-0.95 * drawingRadius, 0);
  rotate(PI/2);
  drawUltrasonic(uWidth);

  translate(uWidth, -1.9 * drawingRadius);
  rotate(PI);
  drawUltrasonic(uWidth);

  popMatrix();
}

public float ultrasonicDistance(int sensorPosition) {
  float ySpeed = 1;
  float xSpeed = 1;
  float beamX = x;
  float beamY = y;

  if (sensorPosition == CENTER) {
    ySpeed = tan(angle - PI/2);

    if (angle > PI) {
      ySpeed = -ySpeed;
      xSpeed = -xSpeed;
    }
    if (angle == 0) {
      ySpeed = -1;
      xSpeed = 0;
    }
  }

  if (sensorPosition == RIGHT) {
    ySpeed = tan(angle);

    if (angle > PI/2 ) {
      ySpeed = -ySpeed;
      xSpeed = -xSpeed;
    }
    if (angle > 1.5 * PI) {
      ySpeed = -ySpeed;
      xSpeed = -xSpeed;
    }
  }
  
  if (sensorPosition == LEFT) {
    ySpeed = tan(angle - PI);
    if (angle == 0) {
      ySpeed = 0;
      xSpeed = -1;
    }
    if (angle > 0) {
      ySpeed = -ySpeed;
      xSpeed = -xSpeed;
    }
    if (angle > PI/2) {
      ySpeed = -ySpeed;
      xSpeed = -xSpeed;
    }


    if (angle > 1.5 * PI) {
      ySpeed = -ySpeed;
      xSpeed = -xSpeed;
    }
  }

  while (abs(ySpeed) > 1) {
    ySpeed *= 0.5;
    xSpeed *= 0.5;
  }

  for (int i = 0; i < width + height; i++) {
    if (/*Entity.checkCollision(x, y) || */ beamX >= width || beamX <= 0 || beamY <= 0 || beamY >= height) {
      return i * sqrt(sq(xSpeed) + sq(ySpeed)) - radius;
    }
    beamX += xSpeed;
    beamY += ySpeed;
    //ellipse(beamX, beamY, 5, 5);
  }
  return -1;
}

private void drawUltrasonic(float uWidth) {
  fill(#348DC2);
  rect(0, 0, uWidth, 0.044 * uWidth);
  fill(#D7DED9);
  rect(0.133 * uWidth, 0.044 * uWidth, 0.222 * uWidth, 0.222 * uWidth);
  rect(0.644 * uWidth, 0.044 * uWidth, 0.222 * uWidth, 0.222 * uWidth);
  fill(#000000);
  rect(0.111 * uWidth, -0.011 * uWidth, 0.088 * uWidth, 0.011 * uWidth);
  rect(0.416 * uWidth, -0.011 * uWidth, 0.066 * uWidth, 0.011 * uWidth);
  rect(0.744 * uWidth, -0.011 * uWidth, 0.2 * uWidth, 0.011 * uWidth); 
  fill(#ACB19A);
  rect(0.433 * uWidth, 0.044 * uWidth, 0.133 * uWidth, 0.022 * uWidth);
  rect(0.244 * uWidth, -0.011 * uWidth, 0.022 * uWidth, 0.011 * uWidth);
  rect(0.316 * uWidth, -0.011 * uWidth, 0.066 * uWidth, 0.011 * uWidth);
  rect(0.616 * uWidth, -0.011 * uWidth, 0.066 * uWidth, 0.011 * uWidth);
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