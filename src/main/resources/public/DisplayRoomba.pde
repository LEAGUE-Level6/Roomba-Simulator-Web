import shiffman.box2d.*;

import org.jbox2d.collision.shapes.CircleShape;
import org.jbox2d.common.Vec2;
import org.jbox2d.dynamics.Body;
import org.jbox2d.dynamics.BodyDef;
import org.jbox2d.dynamics.BodyType;
import org.jbox2d.dynamics.FixtureDef;
import org.jbox2d.dynamics.contacts.Contact;

private int tick = 0;
private int light = 50;
private int incRed = -4;
private float x = 450;
private float y = 450;
private float radius = 50;
private boolean bump;
private int GRID_SIZE = 4;
private float definition; 
private float scaleFactor;
public static Box2DProcessing WORLD;
private transient Body body;

void setup() {
  size(900, 900);

  definition = 200/radius + 1;
  radius = definition * radius;
  scaleFactor = 1/definition;

  WORLD = new Box2DProcessing(this);
  WORLD.createWorld();
  WORLD.setGravity(0, 0);
  WORLD.listenForCollisions();

  makeBody();
}

void draw() {
  background(255);
  WORLD.step();
  display();
  driveDirect(500, 400);
}

public float getRadius() {
  return radius;
}

public void driveDirect(float left, float right) {
  if (tick == 1) {
    float speed = (left + right) / ((width + height)/2 / (GRID_SIZE * 2.0f));
    float ang = (left - right) / ((width + height)/2 / (float) (GRID_SIZE));
    drive(speed, ang);
  }
}

private void drive(float speed, float angle) {
  float y = (float) (Math.cos(body.getAngle()) * speed);
  float x = (float) (Math.sin(body.getAngle()) * speed);

  body.setLinearVelocity(new Vec2(x, y));
  body.setAngularVelocity(angle);
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
    body.setLinearVelocity(new Vec2(0, 0));
    body.setAngularVelocity(0);
    tick = 0;
  }
  Vec2 pos = WORLD.getBodyPixelCoord(body);
  float a = body.getAngle();
  pushMatrix();
  scale(scaleFactor);
  translate(pos.x + (definition * width)/2 - width/2, pos.y + (definition * height)/2 - height/2);
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

public void makeBody() {
  BodyDef bd = new BodyDef();
  bd.position = WORLD.coordPixelsToWorld(x, y);
  bd.type = BodyType.DYNAMIC;
  body = WORLD.createBody(bd);

  CircleShape cs = new CircleShape();
  cs.m_radius = WORLD.scalarPixelsToWorld(radius);

  FixtureDef fd = new FixtureDef();
  fd.shape = cs;
  fd.density = 0;
  fd.friction = 0.5f;
  fd.restitution = 0.1f;

  body.createFixture(fd);
  body.setUserData(this);
  body.setAngularVelocity(17.2f);
}

public void beginContact(Contact cp) {
}

public void endContact(Contact cp) {
}
