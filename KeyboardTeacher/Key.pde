class Key extends Box {

  Key(int X, int Y, int W, int H, String T) {
    super(X, Y, W, H, T);
  }

  int changeDynamicColors() {
    if (keyPressed) {
      if (key == text.charAt(0)) {
        return 0;
      } else {
        return 1;
      }
    } else {
      return 1;
    }
  }

  void show(int transparency) {
    this.transparency = transparency;
    int keyColors = changeDynamicColors();

    strokeWeight(2.5);
    stroke(strokeColor[keyColors], transparency);
    fill(fillColor[keyColors], transparency);
    rect (x, y, selfWidth, selfHeight, (selfWidth - selfHeight / 2) / 10);


    fill(textColor[keyColors], transparency);
    textAlign(CENTER, CENTER);
    textFont = loadFont("AgencyFB-Bold-48.vlw");
    textFont (textFont);
    textSize(textSize);
    text (text, x, y);
  }
}
