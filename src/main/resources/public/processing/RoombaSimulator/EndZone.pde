class EndZone {
  private int red = 100;
  private int increment = 2;
  private int x, y, radius;
  private Entity body;

  public EndZone(int x, int y, int r) {
    this.x = x;
    this.y = y;
    this.radius = r;

    body = new Entity("endzone", ELLIPSE, x, y, radius);
  }
  
  public void display() {
    red += increment;
    fill(red, 255, red);
    noStroke();
    if (red <= 0 || red >= 255) {
      increment = -increment;
    }
    ellipse(x, y, radius * 2, radius * 2);
  }
}