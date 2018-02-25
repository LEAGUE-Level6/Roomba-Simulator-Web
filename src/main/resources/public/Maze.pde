class Maze {
  private ArrayList<Path> horizontalPaths;
  private ArrayList<Path> verticalPaths;


  public Maze(ArrayList<Path> horizontalPaths, ArrayList<Path> verticalPaths) {
    this.verticalPaths = verticalPaths;
    this.horizontalPaths = horizontalPaths;
  }

  public ArrayList<Path> getHorizontalPaths() {
    return horizontalPaths;
  }

  public ArrayList<Path> getVerticalPaths() {
    return verticalPaths;
  }
}