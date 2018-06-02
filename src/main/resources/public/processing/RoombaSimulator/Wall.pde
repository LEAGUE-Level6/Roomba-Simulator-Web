class Wall {
  private float x, y, width, height;
  private boolean wallPos;
  private Entity body;

  public Wall (float x_, float y_, float w_, float h_) {
    this.x = x_;
    this.y = y_;
    this.width = w_;
    this.height = h_;
    this.body = new Entity("wall", RECT, x_, y_, w_, h_);
  }

  public void display() {
    fill(255);
    stroke(0);
    rectMode(CENTER);
    rect(x, y, width, height);
  }
  public Entity getBody() {
    return body;
  }

}