public class Key extends Label {
  private Finger finger = Finger.INDEX;
  private Hand hand = Hand.RIGHT;

  public Key() {
    this("", 0, 0, 0, 0, "", "");
  }

  public Key(String text, float x, float y, float _width, float _height, String finger, String hand) {
    super(text, x, y, _width, _height);
  }

  @Override
    protected void displayBackground() {
    //super.displayObject();
    if (isPressed(this.getText().charAt(0))) {
      fill(255, 255, 00);
      rect(this.getX() - 2, this.getY() - 2, this.getWidth() + 4, this.getHeight() + 4);
    } else {
      super.displayBackground();
    }
  }
}
