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
    textSize = selfWidth / text.length();
  }

  void setDynamicColors(color stroke_1, color fill_1, color text_1, color stroke_2, color fill_2, color text_2, color stroke_3, color fill_3, color text_3) {
    strokeColor[0] = stroke_1;
    strokeColor[1] = stroke_2;
    strokeColor[2] = stroke_3;

    fillColor[0] = fill_1;
    fillColor[1] = fill_2;
    fillColor[2] = fill_3;

    textColor[0] = text_1;
    textColor[1] = text_2;
    textColor[2] = text_3;
  }
}
