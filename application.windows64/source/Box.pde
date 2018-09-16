class Box {
  int x, y, selfWidth, selfHeight, edgeRoundness, textSize, transparency;
  String text;
  color[] selfColor = new color[3];

  Box(int x, int y, int w, int h, String text) {
    this.x = x;
    this.y = y;
    selfWidth = w;
    selfHeight = h;
    setColors(/*50, #E3E3E3, 20*/255, 0, 255);
    this.text = text;
    edgeRoundness = 5;
    textSize = 30;
  }

  void setCoordinates(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void setDimensions(int w, int h) {
    selfWidth = w;
    selfHeight = h;
  }

  void setData(int x, int y, int w, int h) {
    setCoordinates(x, y);
    setDimensions(w, h);
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
