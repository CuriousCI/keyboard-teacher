class Key extends Box {

  Key(int x, int y, int w, int h, String text) {
    super(x, y, w, h, text);
    if (textSize != 1) {
      textSize = selfWidth / text.length() / 2 + 10;
    }
    textAlign(CENTER, CENTER);
  }

  void show(int transparency) {
    changeDynamicColors();
    staticShow(transparency);
  }

  void changeDynamicColors() {
    if (keyPressed) {
      if (normalModeActive) {
        if (text.length() == 1 && key == text.charAt(0)) {
          setColors(255, 255, 255);
        }
      } else if (easyModeActive) {
        int sos = writtenText.length();
        //if (sos == 0) sos = 1;
        sos++;
        if (text.length() == 1 && key == text.charAt(0) && key == unwrittenText.charAt(sos - 1)) {
          setColors(color(0, 255, 0), color(0, 255, 0), color(0, 255, 0));
        } else if (text.length() == 1 && key == text.charAt(0)) {
          setColors(color(255, 0, 0), color(255, 0, 0), color(255, 0, 0));
        } else {
          setColors(100, #D0D0D0, 90);
        }
      }
    } else {
      setColors(100, #D0D0D0, 90);
    }
  }
}
