class Button extends Box {

  Button(int X, int Y, int W, int H, String T) {
    super(X, Y, W, H, T);
  }

  int changeDynamicColors() {
    if (mouseInside()) {
      if (selfClicked()) {
        return 0;
      } else {
        return 1;
      }
    } else {
      return 2;
    }
  }

  void show(int transparency) {
    this.transparency = transparency;
    int buttonColors = changeDynamicColors();

    strokeWeight(2.5);
    stroke(strokeColor[buttonColors], transparency);
    fill(fillColor[buttonColors], transparency);
    rect (x, y, selfWidth, selfHeight, (selfWidth - selfHeight / 2) / 10);


    fill(textColor[buttonColors], transparency);
    textAlign(CENTER, CENTER);
    textFont = loadFont("AgencyFB-Bold-48.vlw");
    textFont (textFont);
    textSize(textSize);
    text (text, x, y);
  }

  boolean mouseInside() {
    if ((mouseX < x + selfWidth / 2 && mouseX > x - selfWidth / 2) && (mouseY < y + selfHeight / 2 && mouseY > y - selfHeight / 2)) {
      return true;
    } else {
      return false;
    }
  }

  boolean selfClicked() {
    if (mouseInside() && mousePressed) {
      return true;
    } else {
      return false;
    }
  }
}
