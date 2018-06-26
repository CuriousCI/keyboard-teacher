class Button {
  PFont textFont;

  int x, y, buttonWidth, buttonHeight, textSize, transparency;
  String text;
  color strokeColor, fillColor, textColor; 

  Button(int X, int Y, int W, int H, String T) {
    x = X - W / 2;
    y = Y - H / 2;
    buttonWidth = W;
    buttonHeight = H;
    text = T;
    textSize = buttonWidth / text.length();
  }

  void buttonColor(color s, color f, color t) {
    strokeColor = s;
    fillColor = f;
    textColor = t;
  }

  void dinamicColorChange(color a1, color a2, color a3, color b1, color b2, color b3, color c1, color c2, color c3, int tra) {
    transparency = tra;
    if (mouseInside()) {
      if (buttonClicked()) {
        buttonColor(a1, a2, a3);
        if (tra == 200) {
          transparency = 100;
        }
      } else {
        buttonColor(b1, b2, b3);
      }
    } else {
      buttonColor(c1, c2, c3);
    }
  }

  void show() {
    strokeWeight(2.5);
    stroke(strokeColor, transparency);
    fill(fillColor, transparency);
    rect (x, y, buttonWidth, buttonHeight, (buttonWidth - buttonHeight / 2) / 10);


    fill(textColor, transparency);
    textAlign(CENTER, CENTER);
    textFont = loadFont("AgencyFB-Bold-48.vlw");
    textFont (textFont);
    textSize(textSize);
    text (text, x + buttonWidth / 2, y + buttonHeight / 2);
  }

  boolean mouseInside() {
    if ((mouseX < x + buttonWidth && mouseX > x) && (mouseY < y + buttonHeight && mouseY > y)) {
      return true;
    } else {
      return false;
    }
  }

  boolean buttonClicked() {
    if (mouseInside() && mousePressed) {
      return true;
    } else {
      return false;
    }
  }
}
