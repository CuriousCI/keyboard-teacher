class Box {
  PFont textFont;

  int x, y, selfWidth, selfHeight, textSize, transparency;
  String text;
  color[] strokeColor = new color[3], fillColor = new color[3], textColor = new color[3];

  Box(int X, int Y, int W, int H, String T) {
    x = X;
    y = Y;
    selfWidth = W;
    selfHeight = H;
    text = T;
    textFont = loadFont("AgencyFB-Bold-48.vlw");
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
    rect (x, y, selfWidth, selfHeight, (selfWidth - selfHeight / 2) / 10);


    fill(textColor[setOfColors], transparency);
    textFont (textFont);
    textSize(textSize);
    text (text, x, y);
  }
}
