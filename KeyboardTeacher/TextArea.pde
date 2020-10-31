public class TextArea extends Label {
  public int rows, columns;
  public final int cellWidth, cellHeight;
  public String inputText;

  public TextArea() {
    this("");
  }

  public TextArea(String text) {
    super(text);
    rows = 10;
    columns = 60;

    cellWidth = (int)(_width / columns);
    cellHeight = (int)(_height / rows);
    textSize = cellHeight;

    inputText = "";
  }
  
  @Override 
  protected void paint() {
    rect(x, y, _width, _height);
    
    displayText();
  }

  @Override 
    protected void displayText() {
    fill(#AA0000);
    stroke(#AA0000);
    strokeWeight(2);
    for (int x = 0; x < this.columns - 1; x++) {
      for (int y = 0; y < this.rows; y++) {
        int index = x + y * this.columns;
        if (index >= text.length()) break;
        if (index < inputText.length()) {
          if (inputText.charAt(index) == text.charAt(index)) fill(#00FF00);
          else fill(#FF0000);
        } else fill(#0000FF);
        
        text(
          text.charAt(index), 
          this.x + x * cellWidth + cellWidth, 
          textSize + this.y + y * cellHeight
          );
      }
    }
  }
}
