public static int GRID_SIZE = 8;
public static final int SCREEN_SIZE = 900;
public static int PIPE_LENGTH = SCREEN_SIZE / GRID_SIZE;
public static int PIPE_WIDTH = 4;
private ArrayList<Path> verticalPaths = new ArrayList<Path>();
private ArrayList<Path> horizontalPaths = new ArrayList<Path>();
private ArrayList<Wall> walls = new ArrayList<Wall>();
public Roomba roomba;
public EndZone endZone;


void setup() {
  size(900, 900);
  roomba = new Roomba("r1", 507, 800, PIPE_LENGTH/4);
  endZone = new EndZone(507, 100, 20);

  verticalPaths.add(new Path(4, 0));
  verticalPaths.add(new Path(4, 1));
  verticalPaths.add(new Path(4, 2));
  verticalPaths.add(new Path(4, 3));
  verticalPaths.add(new Path(4, 4));
  verticalPaths.add(new Path(4, 5));
  verticalPaths.add(new Path(4, 6));
  verticalPaths.add(new Path(4, 7));
  verticalPaths.add(new Path(4, 8));
  
  
  setMaze();
  roomba.driveDirect(500, 500);
}

void draw() {
  background(255);
  drawMaze();
  roomba.display();
  endZone.display();
  roomba.update();
  stroke(0);
  strokeWeight(1.5);
  fill(255);
  rectMode(CORNER);
  rect(15, 5, 370, 20);
  fill(255, 0, 0);
  text("Left Sensor: " + (int) roomba.getUltrasonicDistance(LEFT), 20, 20);
  text("Center Sensor: " + (int) roomba.getUltrasonicDistance(CENTER), 145, 20);
  text("Right Sensor: " + (int) roomba.getUltrasonicDistance(RIGHT), 275, 20);
  
}

void setMaze() {
  int offset = PIPE_LENGTH / 2;
  for (int i = 0; i < GRID_SIZE + 1; i++) {
    for (int j = 0; j < GRID_SIZE + 1; j++) {
      boolean setVert = true;
      boolean setHorz = true;
      for (Path p : verticalPaths) {
        if (p.getRow() == i && p.getColumn() == j) {
          setVert = false;
        }
      }
      if (setVert) {
        walls.add(new Wall(PIPE_LENGTH * i + offset, PIPE_LENGTH * j, PIPE_LENGTH, PIPE_WIDTH));
      }

      for (Path p : horizontalPaths) {
        if (p.getRow() == i && p.getColumn() == j) {
          setHorz = false;
        }
      }
      if (setHorz) {
        walls.add(new Wall(PIPE_LENGTH * i, PIPE_LENGTH * j + offset, PIPE_WIDTH, PIPE_LENGTH));
      }
    }
  }
}

void drawMaze() {
  for (int i = walls.size() - 1; i >= 0; i--) {
    walls.get(i).display();
  }
}
