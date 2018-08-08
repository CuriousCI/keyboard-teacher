class Box {

  int x, y, selfWidth, selfHeight, edgeRoundness, textSize, transparency;
  String text;
  color[] selfColor = new color[3];

  Box(int X, int Y, int W, int H, String T) {
    x = X;
    y = Y;
    selfWidth = W;
    selfHeight = H;

    setColors(50, #E3E3E3, 20);

    text = T;
    if (text.length() == 0) {
      textSize = 1;
    } else {
      textSize = selfWidth / text.length();
    }
    edgeRoundness = 10;
  }

  void setColors(color stroke, color fill, color text) {
    selfColor[0] = stroke;
    selfColor[1] = fill;
    selfColor[2] = text;
  }

  void staticShow(int transparency) {
    this.transparency = transparency;
    strokeWeight(2.5);
    stroke(selfColor[0], transparency);
    fill(selfColor[1], transparency);
    rect (x, y, selfWidth, selfHeight, edgeRoundness);


    fill(selfColor[2], transparency);
    textFont (textFont);
    textSize(textSize);
    text (text, x, y);
  }
}
