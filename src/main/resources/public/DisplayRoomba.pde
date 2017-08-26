float a = 0;
float x = 250;
float y = 250;
float radius = 20;
float definition; 
float scaleFactor;
void setup() {
  size(500, 500);
  definition = 200/radius + 1;
  radius = definition * radius;
  scaleFactor = 1/definition;
}
void draw() {
  background(255);  
  pushMatrix();
  scale(scaleFactor);
  translate(x + (definition * width)/2 - width/2, y + (definition * height)/2 - height/2);
  rotate(radians(a));
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
  fill(255, 0, 0);
  noStroke();
  ellipse(1, 1, 3 * radius/50, 3 * radius/50);
  
  popMatrix();
  
}

void move(float x1, float y1, float angleInDegrees) {
x = x1;
y = y1;
a = angleInDegrees;
}

float getX() {
 return x;
}

float getY() {
 return y;
}


