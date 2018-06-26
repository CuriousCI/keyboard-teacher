class Box {
  PFont textFont;

  int x, y, boxWidth, boxHeight, textSize, transparency;
  String text;
  color strokeColor, fillColor, textColor; 

  Box(int X, int Y, int W, int H, String T) {
    x = X - W / 2;
    y = Y - H / 2;
    boxWidth = W;
    boxHeight = H;
    text = T;
    textSize = boxWidth / text.length();
  }

  void boxColor(color s, color f, color t) {
    strokeColor = s;
    fillColor = f;
    textColor = t;
  }

  void show() {
    strokeWeight(2.5);
    stroke(strokeColor, transparency);
    fill(fillColor, transparency);
    rect (x, y, boxWidth, boxHeight, (boxWidth - boxHeight / 2) / 10);


    fill(textColor, transparency);
    textAlign(CENTER, CENTER);
    textFont = loadFont("AgencyFB-Bold-48.vlw");
    textFont (textFont);
    textSize(textSize);
    text (text, x + boxWidth / 2, y + boxHeight / 2);
  }
}
