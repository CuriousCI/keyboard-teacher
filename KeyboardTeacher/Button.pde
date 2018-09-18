class Button extends Box {
  Button(int x, int y, int w, int h, String text) {
    super(x, y, w, h, text);
    textAlign(CENTER, CENTER);
  }

  void show(int transparency) {
    changeDynamicColors();
    staticShow(transparency);
  }

  void changeDynamicColors() {
    if (mouseInside()) 
      if (selfClicked()) setColors(255, 255, 0);
      else setColors(20, 255, 0);
    else setColors(255, 0, 255);
  }

  boolean mouseInside() {
    if ((mouseX < x + selfWidth / 2 && mouseX > x - selfWidth / 2) && (mouseY < y + selfHeight / 2 && mouseY > y - selfHeight / 2)) return true;
    else return false;
  }

  boolean selfClicked() {
    if (mouseInside() && mousePressed) return true;
    else return false;
  }
}
