class Key extends Box {
  String finger;
  int layer;

  Key(int x, int y, int w, int h, String text, String finger, int layer) {
    super(x, y, w, h, text);
    if (textSize != 1) {
      textSize = selfWidth / text.length() / 2 + 10;
    }
    this.finger = finger;
    this.layer = layer;
    textAlign(CENTER, CENTER);
  }

  void show(int transparency) {
    changeDynamicColors();
    staticShow(transparency);
  }

  void changeDynamicColors() {
    if (keyPressed) {
      if (normalModeActive) {
        if (text.length() == 1 && key == text.charAt(0) && key == unwrittenText.charAt(writtenText.length())) {
          setColors(255, 255, 255);
        }
      } else if (easyModeActive) {
        if (text.length() == 1 && key == text.charAt(0) && key == unwrittenText.charAt(writtenText.length())) {
          setColors(color(0, 255, 0), color(0, 255, 0), color(0, 255, 0));
        } else if (text.length() == 1 && key == text.charAt(0)) {
          setColors(color(255, 0, 0), color(255, 0, 0), color(255, 0, 0));
        } else {
          switch (finger) {
          case "thumb": 
            setColors(100, #D0D0D0, 90);
          case "pinky": 
            setColors(color(255, 0, 255), color(255, 0, 255, 100), color(255, 255, 255)); 
            break;
          case "ring": 
            setColors(color(0, 0, 255), color(0, 0, 255, 100), color(255, 255, 255)); 
            break;
          case "middle": 
            setColors(color(200, 200, 255), color(200, 200, 255, 100), color(255, 255, 255)); 
            break;
          case "index": 
            setColors(color(200, 200, 50), color(200, 200, 50, 100), color(255, 255, 255)); 
            break;
          }
        }
      }
    } else {
      if (easyModeActive) {
        switch (finger) {
        case "thumb": 
          setColors(100, #D0D0D0, 90);
        case "pinky": 
          setColors(color(255, 0, 255), color(255, 0, 255, 100), color(255, 255, 255)); 
          break;
        case "ring": 
          setColors(color(0, 0, 255), color(0, 0, 255, 100), color(255, 255, 255)); 
          break;
        case "middle": 
          setColors(color(200, 200, 255), color(200, 200, 255, 100), color(255, 255, 255)); 
          break;
        case "index": 
          setColors(color(200, 200, 50), color(200, 200, 50, 100), color(255, 255, 255)); 
          break;
        }
      } else {
        setColors(100, #D0D0D0, 90);
      }
    }
  }
}
