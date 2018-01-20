class Cell {
  private int row;
  private int col;
  private boolean visited;

  public Cell(int row, int col) {
    this.row = row;
    this.col = col;
    this.visited = false;
  }
  
  public int getCenterX() {
    return (PIPE_LENGTH * col) - PIPE_LENGTH/2;
  }
  
  public int getCenterY() {
    return (PIPE_LENGTH * row) - PIPE_LENGTH/2;
  }
  
  public int getRow() {
    return row;
  }

  public void setRow(int row) {
    this.row = row;
  }

  public int getColumn() {
    return col;
  }

  public void setColumn(int col) {
    this.col = col;
  }
  
  public void setBeenVisited(boolean beenVisited) {
    this.visited = beenVisited;
  }
  
  public boolean hasBeenVisited() {
    return visited;
  }
}