import java.util.ArrayList;
public ArrayList<Entity> entities = new ArrayList<Entity>();
public Entity collidedWith;

class Entity {
  private String id;
  private int shape;
  private float x;
  private float y;
  private float w;
  private float h;
  private float r;
  private boolean isHorizontal;
  


  public Entity checkCollision(float x, float y) {
    for (Entity i : entities) {
      if (i.getShape() == RECT) {
        if (x >= i.getX() - i.getWidth()/2 && x <= i.getX() + i.getWidth()/2 && y >= i.getY() - i.getHeight()/2 && y <= i.getY() + i.getHeight()/2) {
          collidedWith = i;
          return i;
        }
      } else if (i.getShape() == ELLIPSE) {
        if (sqrt(sq(i.getX() - x) + sq(i.getY() - y)) < i.getRadius()) {
          collidedWith = i;
          return i;
        }
      }
    }
    return null;
  }

  public Entity(String id, int shape, float x, float y, float w, float h) {
    this.id = id;
    this.shape = shape;
    this.x = x;
    this.y = y; 
    this.w = w;
    this.h = h;
    setWallPos();

    entities.add(this);
  }
  public Entity(String id, int shape, float x, float y, float r) {
    this.id = id;
    this.shape = shape;
    this.x = x;
    this.y = y; 
    this.r = r;
    entities.add(this);
  }
  public Entity() {
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public int getShape() {
    return shape;
  }

  public float getX() {
    return x;
  }

  public void setX(float x) {
    this.x = x;
  }

  public float getY() {
    return y;
  }

  public void setY(float y) {
    this.y = y;
  }

  public float getWidth() {
    return w;
  }

  public void setWidth(float w) {
    this.w = w;
  }

  public float getHeight() {
    return h;
  }

  public void setHeight(float h) {
    this.h = h;
  }
  public float getRadius() {
    return r;
  }

  public void setRadius(float r) {
    this.r = r;
  }
  public Entity getCollided() {
    return collidedWith;
  }
  
  public void deleteBody() {
    entities.remove(this);
  }
    public void setWallPos()
  {
    isHorizontal=(getWidth()>getHeight());
    
  }
  public ArrayList<Entity> getNearbyEntities()
 {
   // seperate walls by inter sections 
   // put the center of the roomba to the nearest intersection point
   //add those walls to the nearby walls/entities
   // 4 walls added
   
 }
public boolean isHor()
{
  return isHorizontal;
}
  
}