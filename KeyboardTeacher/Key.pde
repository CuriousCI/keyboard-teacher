public enum Finger {
  THUMB, 
    PINKY, 
    RING, 
    MIDDLE, 
    INDEX,
}

public enum Hand {
  RIGHT, 
    LEFT,
}

public class Key extends Label {
  public final Finger finger;
  public final Hand hand;

  public Key(String text, Hand hand, Finger finger) {
    super(text);
    this.hand = hand;
    this.finger = finger;
  }

  @Override 
    protected void paint() {
    if (isPressed(text.charAt(0)) || (isPressed(' ') && text == "space")) {
      fill(255, 255, 00);
      rect(x - 2, y - 2, _width + 4, _height + 4);
    } else super.paint();
  }
}
