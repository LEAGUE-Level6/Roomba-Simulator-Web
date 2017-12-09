import java.util.Stack;

public class MazeMaker {
  private Cell[][] maze;
  private Stack<Cell> uncheckedCells = new Stack<Cell>();

  void createMaze() { 
    maze = new Cell[GRID_SIZE][GRID_SIZE];
    for (int i = 0; i < GRID_SIZE; i++) {
      for (int j = 0; j < GRID_SIZE; j++) {
        maze[i][j] = new Cell(i, j);
      }
    }
    selectNextPath(maze[(int) random(GRID_SIZE)][(int) random(GRID_SIZE)]);
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

  if (col < GRID_SIZE - 1) {
    if (!(maze[row][col + 1].hasBeenVisited()))
      unvisitedCells.add(maze[row][col + 1]);
  }
  if (col > 0) {
    if (!(maze[row][col - 1].hasBeenVisited()))
      unvisitedCells.add(maze[row][col - 1]);
  }
  if (row < GRID_SIZE - 1) {
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
  if (col < GRID_SIZE - 1) {
    if (maze[row][col + 1] == b) {
      horizontalPaths.add(new Path(col + 1, row));
    }
  }
  if (col > 0) {
    if (maze[row][col - 1] == b) {
      horizontalPaths.add(new Path(col, row));
    }
  }
  if (row < GRID_SIZE - 1) {
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

}