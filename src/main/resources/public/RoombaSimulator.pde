public static int GRID_SIZE_VERTICAL = 12;
public static int GRID_SIZE_HORIZONTAL = 6;
public static final int SCREEN_SIZE = 823;
public static int PIPE_LENGTH = SCREEN_SIZE / GRID_SIZE_VERTICAL;
public static int PIPE_WIDTH = 4;
private ArrayList<Path> verticalPaths = new ArrayList<Path>();
private ArrayList<Path> horizontalPaths = new ArrayList<Path>();
private ArrayList<Wall> walls = new ArrayList<Wall>();
public Roomba roomba;
public EndZone endZone;
public float inc;
private double start = 0;
private double end = 0;

void setup() {
  size(412, 823);
  processingLoaded();
  //driveDirect(.1,.1);
 // roomba = new Roomba("r1", 510, 420, PIPE_LENGTH * 0.2407);
  //endZone = new EndZone(510, 100, 10);
}

void resetTimer(){
	start = millis();
}


void draw() {
  background(255);
  drawMaze();
  roomba.display();
  endZone.display();
  //drawCircle(100,100,frameCount);
  roomba.update();
  if (!roomba.bump) {
    end = millis();
  }
  
  if (start != 0){
  	text("Time: " + (int)((end - start)/60000) + ":" + nf(((end - start)/1000.0)%60, 2, 2), 400, 20);
  }else{
  	text("Time: 0:00.00", 400, 20);
  }
}

void generateRandomMaze() {
	MazeMaker maker = new MazeMaker();
  	maker.createMaze();
  	p.setMaze();
}	

void addVerticalPath(int x, int y)
{
	verticalPaths.add(new Path(x, y));
}

void addHorizontalPath(int x, int y)
{
	horizontalPaths.add(new Path(x, y));
}

void startingPointLocations(int x, int y, float angle)
{
	roomba = new Roomba("r1", x, y, PIPE_LENGTH * 0.2407, angle);
}

void finishingPointLocation(int x, int y)
{
	endZone = new EndZone(x, y, 10);
}

Roomba getRoomba()
{
	return roomba;
}
void driveDirect(float left, float right)
{
println("hi");
getRoomba().driveDirect(left, right);
}
void setMaze() {
  int offset = PIPE_LENGTH / 2;
  for (int i = 0; i < GRID_SIZE_HORIZONTAL+1 ; i++) {
    for (int j = 0; j < GRID_SIZE_VERTICAL+1 ; j++) {


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

void drawCircle(float x, float y, float r) {
  noFill();
  stroke(255, 0, 0);
  ellipse(x+r, y, r*2, r*2);
  //println(r);
}