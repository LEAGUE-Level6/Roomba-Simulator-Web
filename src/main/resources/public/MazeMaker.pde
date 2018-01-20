public class MazeMaker {
  private Cell[][] maze;
  private Stack<Cell> uncheckedCells = new Stack<Cell>();

  void createMaze() { 
    maze = new Cell[GRID_HEIGHT][GRID_WIDTH];
    for (int i = 0; i < GRID_HEIGHT; i++) {
      for (int j = 0; j < GRID_WIDTH; j++) {
        maze[i][j] = new Cell(i, j);
      }
    }
    selectNextPath(maze[(int) random(GRID_HEIGHT)][(int) random(GRID_WIDTH)]);
  }



private void selectNextPath(Cell currentCell) {
  //print(currentCell.getColumn() + " " + currentCell.getRow() + "   ");
  currentCell.setBeenVisited(true);
  Cell selected = null;
  ArrayList<Cell> unvisitedCells = getUnvisitedNeighbors(currentCell);
  //for(Cell i : unvisitedCells)
  //  print("(" + i.getColumn() + ", " + i.getRow() + ")");
  //println();
    
  if (!unvisitedCells.isEmpty()) {
    selected = unvisitedCells.get((int) random(unvisitedCells.size()));
    uncheckedCells.push(selected);
    removeWalls(selected, currentCell);
    selected.setBeenVisited(true);
  } else {
    if (!uncheckedCells.isEmpty()) {
      //println("selectedfromstack");
      selected = uncheckedCells.pop();
    }
  }
  if (selected != null)
    selectNextPath(selected);
}
private ArrayList<Cell> getUnvisitedNeighbors(Cell c) {
  ArrayList<Cell> unvisitedCells = new ArrayList<Cell>();

  int col = c.getColumn();
  int row = c.getRow();

  if (col < GRID_WIDTH - 1) {
    if (!(maze[row][col + 1].hasBeenVisited()))
      unvisitedCells.add(maze[row][col + 1]);
  }
  if (col > 0) {
    if (!(maze[row][col - 1].hasBeenVisited()))
      unvisitedCells.add(maze[row][col - 1]);
  }
  if (row < GRID_HEIGHT - 1) {
    if (!(maze[row + 1][col].hasBeenVisited()))
      unvisitedCells.add(maze[row + 1][col]);
  }
  if (row > 0) {
    if (!(maze[row - 1][col].hasBeenVisited()))
      unvisitedCells.add(maze[row - 1][col]);
  }

  return unvisitedCells;
}
private void removeWalls(Cell a, Cell b) {
  int row = a.getRow();
  int col = a.getColumn();
  if (col < GRID_WIDTH - 1) {
    if (maze[row][col + 1] == b) {
      horizontalPaths.add(new Path(col + 1, row));
    }
  }
  if (col > 0) {
    if (maze[row][col - 1] == b) {
      horizontalPaths.add(new Path(col, row));
    }
  }
  if (row < GRID_HEIGHT- 1) {
    if (maze[row + 1][col] == b) {
      verticalPaths.add(new Path(col, row + 1));
    }
  }
  if (row > 0) {
    if (maze[row - 1][col] == b) {
      verticalPaths.add(new Path(col, row));
    }
  }
}
public ArrayList<Cell> getCellArrayList(){
   ArrayList<Cell> cells = new ArrayList<Cell>();
   for(Cell[] row: maze) {
     for(Cell i: row)
       cells.add(i);
   }
   return cells;
}

}