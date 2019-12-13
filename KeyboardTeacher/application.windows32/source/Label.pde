public class Label extends Component {
  private float x, y, _width, _height;
  private String text;
  private int textSize;

  public Label() {
    this("", 0, 0, 0, 0);
  }

  public Label(String text, float x, float y, float _width, float _height) {
    super(x, y, _width, _height);
    this.setText(text);
    this.autoFill();
  }

  public void setText(String text) {
    this.text = text;
  }

  public void setTextSize(int textSize) {
    this.textSize = textSize;
  }

  public String getText() {
    return this.text;
  }

  public int getTextSize() {
    return this.textSize;
  }

  public void autoFill() {
    this.setTextSize(1);
    textSize(1);
    while (textWidth(this.text) < this.getWidth()*0.8 && this.textSize < this.getHeight()*0.8) {
      textSize(this.textSize);
      this.textSize++;
    }
  }

  @Override
    protected void displayBackground() {
    fill(#FFFFFF);
    stroke(#AA0000);
    strokeWeight(0.5);
    rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());
  }

  protected void displayText() {
    fill(#AA0000);
    stroke(#AA0000);
    strokeWeight(2);
    textSize(this.textSize);
    text(this.getText(), this.getX()+(this.getWidth()*0.5-textWidth(this.getText())*0.5), this.getY()+this.getHeight()*0.5);
  }

  @Override
    protected void displayObject() {
    super.displayObject();
    this.displayText();
  }
}
