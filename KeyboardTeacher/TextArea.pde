public class TextArea extends Label {
  private int rows, columns;
  private int cellWidth, cellHeight;

  public TextArea() {
    this("", 0, 0, 0, 0);
  }

  public TextArea(String text, float x, float y, float _width, float _height) {
    super(text, x, y, _width, _height);
    this.setRows(10);
    this.setColumns(60);

    this.cellWidth = (int)(this.getWidth() / this.columns);
    this.cellHeight = (int)(this.getHeight() / this.rows);
    this.setTextSize(this.cellHeight);
  }

  public void setRows(int rows) {
    this.rows = rows;
  }

  public void setColumns(int columns) {
    this.columns = columns;
  }

  @Override 
    protected void displayText() {
    fill(#AA0000);
    stroke(#AA0000);
    strokeWeight(2);
    textSize(this.getTextSize());
    for (int x = 0; x < this.columns - 1; x++) {
      for (int y = 0; y < this.rows; y++) {
        int index = x + y * this.columns;
        if (index >= this.getText().length()) {
          break;
        }
        text(this.getText().charAt(index), this.getX()+x*this.cellWidth+this.cellWidth, this.getTextSize()+this.getY()+y*this.cellHeight);
      }
    }
  }
}
