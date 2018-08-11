class Button extends Box {

  Button(int x, int y, int w, int h, String text) {
    super(x, y, w, h, text);
    textAlign(CENTER, CENTER);
    edgeRoundness = (selfWidth - selfHeight / 2) / 10;
  }

  void show(int transparency) {
    changeDynamicColors();
    staticShow(transparency);
  }

  void changeDynamicColors() {
    if (mouseInside()) {
      if (selfClicked(true)) {
        setColors(#FFFFFF, #C8C8C8, #FFFFFF);
      } else {
        setColors(#FF0000, #FF6405, #F0F000);
      }
    } else {
      setColors(#0021F0, #0021F0, #F021FF);
    }
  }

  boolean mouseInside() {
    if ((mouseX < x + selfWidth / 2 && mouseX > x - selfWidth / 2) && (mouseY < y + selfHeight / 2 && mouseY > y - selfHeight / 2)) {
      return true;
    } else {
      return false;
    }
  }

  boolean selfClicked(boolean activated) {
    if (mouseInside() && mousePressed && activated) {
      return true;
    } else {
      return false;
    }
  }
}
