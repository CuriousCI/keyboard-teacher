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
      if (text.length() == 1 && key == text.charAt(0)) {
        setColors(0, #D0D0D0, 50);
      } else {
        //if (easyModeActive){
        //  if (unwrittenText[line].charAt(writtenText[line].length()) == key){
        //    setColors(color(0, 255, 0), color(0, 255, 0), color(0, 255, 0));
        //  } else {
        //    setColors(color(255, 0, 0), color(255, 0, 0), color(255, 0, 0));
        //  }
        //} else {
        setColors(100, #D0D0D0, 90);
        //}
      }
    } else {
      setColors(100, #D0D0D0, 90);
    }
  }
}
