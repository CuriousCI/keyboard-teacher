class Box {
  PFont textFont;

  int x, y, selfWidth, selfHeight, edgeRoundness, textSize, textPosition = CENTER, transparency;
  String text;
  color[] strokeColor = new color[3], fillColor = new color[3], textColor = new color[3];

  Box(int X, int Y, int W, int H, String T) {
    x = X;
    y = Y;
    selfWidth = W;
    selfHeight = H;
    text = T;
    textFont = loadFont("AgencyFB-Bold-48.vlw");
    if (text.length() == 0) {
      textSize = 1;
    } else {
      textSize = selfWidth / text.length();
    }
    textAlign(CENTER, CENTER);
    edgeRoundness = 20;
    setDynamicColors(200, #E3E3E3, 50, 50, #E3E3E3, 200, #E3E3E3, 400, 400);
  }

  void setDynamicColors(color stroke_1, color fill_1, color text_1, color stroke_2, color fill_2, color text_2, color stroke_3, color fill_3, color text_3) {
    // First set of colors
    strokeColor[0] = stroke_1;
    strokeColor[1] = stroke_2;
    strokeColor[2] = stroke_3;

    // Second set of Colors
    fillColor[0] = fill_1;
    fillColor[1] = fill_2;
    fillColor[2] = fill_3;

    // Third set of colors
    textColor[0] = text_1;
    textColor[1] = text_2;
    textColor[2] = text_3;
  }

  void show(int transparency, int setOfColors) {
    this.transparency = transparency;

    strokeWeight(2.5);
    stroke(strokeColor[setOfColors], transparency);
    fill(fillColor[setOfColors], transparency);
    rect (x, y, selfWidth, selfHeight, edgeRoundness);


    fill(textColor[setOfColors], transparency);
    textFont (textFont);
    textSize(textSize);
    if (textPosition == LEFT) {
      text (text, (x - selfWidth / 2) + 150, (y - selfHeight / 2) + 40);
    } else {
      text (text, x, y);
    }
  }
}
