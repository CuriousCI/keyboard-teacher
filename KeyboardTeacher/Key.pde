class Key {
  PFont textFont;

  int x, y, keyWidth, keyHeight, textSize, transparency;
  String text;
  color strokeColor, fillColor, textColor;

  Key(int X, int Y, int W, int H, String T) {
    x = X;
    y = Y;
    keyWidth = W;
    keyHeight = H;
    text = T;
    textSize = text.length() / keyWidth;
  }

  void keyColor(color s, color f, color t) {
    strokeColor = s;
    fillColor = f;
    textColor = t;
  }

  void dinamicColorChange(color a1, color a2, color a3, color b1, color b2, color b3, color c1, color c2, color c3, int tra) {
    transparency = tra;
    if (keyPressed) {
      if (key == text.charAt(0)) {
        keyColor(a1, a2, a3);
      }
    } else {
      keyColor(c1, c2, c3);
    }
  }

  void show() {
    strokeWeight(2.5);
    stroke(strokeColor, transparency);
    fill(fillColor, transparency);
    rect (x, y, keyWidth, keyHeight, (keyWidth - keyHeight / 2) / 10);


    fill(textColor, transparency);
    textAlign(CENTER, CENTER);
    textFont = loadFont("AgencyFB-Bold-48.vlw");
    textFont (textFont);
    textSize(textSize);
    text (text, x + keyWidth / 2, y + keyHeight / 2);
  }
}
