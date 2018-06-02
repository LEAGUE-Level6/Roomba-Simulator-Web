public static int GRID_HEIGHT = 12;
public static int GRID_WIDTH = 6;
public static final int SCREEN_HEIGHT = 823;
public static final int SCREEN_WIDTH = 412;
public static int PIPE_LENGTH = max(SCREEN_HEIGHT, SCREEN_WIDTH) / max(GRID_HEIGHT, GRID_WIDTH);
public static int PIPE_WIDTH = 4;
private ArrayList<Path> verticalPaths = new ArrayList<Path>();
private ArrayList<Path> horizontalPaths = new ArrayList<Path>();
private ArrayList<Wall> walls = new ArrayList<Wall>();
public Roomba roomba;
public EndZone endZone;
public MazeMaker maker;
public float inc;
private double start = 0;
private double end = 0;

void processingLoaded(){
  // do nothing
}

void setup() {
  size(412, 823);
  processingLoaded();
  setupRandomLevel();
}

void resetTimer() {
  start = millis();
}


void draw() {
  background(255);

  
  drawMaze();
  roomba.display();
  endZone.display();
  roomba.update();
  //if (!roomba.bump) {
    end = millis();
 // }

  
  if (start != 0) {
  	text("Time: " + (int)((end - start)/60000) + ":" + nf(((float)(end - start)/1000.0)%60, 2, 2), 20, 40);
  } else {
  	text("Time: 0:00.00", 20, 40);
  }
}

void generateRandomMaze() {
  maker = new MazeMaker();
  maker.createMaze();
}

void setupRandomLevel(){
  generateRandomMaze();
  Cell roombaCell = maker.getCellArrayList().get((int) random(maker.getCellArrayList().size()));
  Cell endCell = maker.getCellArrayList().get((int) random(maker.getCellArrayList().size()));
  while(sqrt(sq(roombaCell.getCenterX() - endCell.getCenterX()) + sq(roombaCell.getCenterY() - endCell.getCenterY())) < 200) 
   endCell = maker.getCellArrayList().get((int) random(maker.getCellArrayList().size() - 2) + 1);
  
  roomba = new Roomba("r1", roombaCell.getCenterX(), roombaCell.getCenterY(), PIPE_LENGTH * 0.2407, int(random(4)) * (PI/2));
  endZone = new EndZone(endCell.getCenterX(), endCell.getCenterY(), 10);
}

void addVerticalPath(int x, int y) {
  verticalPaths.add(new Path(x, y)); 
}

void addHorizontalPath(int x, int y) {
  horizontalPaths.add(new Path(x, y));
}

void startingPointLocations(int x, int y, float angle) {
  roomba = new Roomba("r1", x, y, PIPE_LENGTH * 0.2407, angle);
}

void finishingPointLocation(int x, int y) {
  endZone = new EndZone(x, y, 10);
}

Roomba getRoomba() {
  return roomba;
}

void driveDirect(int left, int right) {
  getRoomba().driveDirect(left, right);
}

void drive(float speed, float r) {
  getRoomba().drive(speed, r);
}

void getUltrasonicDistance(int sensorPosition) {
  getRoomba().getUltrasonicDistance(sensorPosition);
}

void setMaze() {
  int offset = PIPE_LENGTH / 2;
  for (int i = 0; i < GRID_WIDTH+1; i++) {
    for (int j = 0; j < GRID_HEIGHT+1; j++) {



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

void clearWalls() {
  for (int i = walls.size() - 1; i >= 0; i--) {
    walls.get(i).getBody().deleteBody();
  }
  walls.clear();
}

void drawMaze() {
  if (maker != null) {
      int index = (int) min(millis()/50, maker.getMazeSteps().size() - 1);
      horizontalPaths = maker.getMazeSteps().get(index).getHorizontalPaths();
      verticalPaths = maker.getMazeSteps().get(index).getVerticalPaths();
      clearWalls();
      setMaze();
  }

  for (int i = walls.size() - 1; i >= 0; i--) {
    walls.get(i).display();
  }
}

void drawCircle(float x, float y, float r) {
  noFill();
  stroke(255, 0, 0);
  ellipse(x+r, y, r*2, r*2);
  //println(r);
}