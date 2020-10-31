public class Label extends Component {
  public String text;
  public float textSize;

  public Label() {
    this("");
  }

  public Label(String text) {
    this.text = text;
    resizeText();
  }

  public void resizeText() {
    textSize = _height * 0.5;
    if (textSize <= 0) textSize = 30;
    //for (
    //  textSize = _height * 0.8; 
    //  textWidth(text) > _width * 0.8; 
    //  textSize--
    //  ) textSize(textSize);
  }

  @Override 
    protected void paint() {
    super.paint();
    displayText();
  }

  protected void displayText() {
    textSize(textSize);
    text(
      text, 
      x + (_width * 0.5 - textWidth(text) * 0.5), 
      y + _height * 0.5
      );
  }
}
