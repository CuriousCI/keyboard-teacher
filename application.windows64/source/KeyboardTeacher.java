import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class KeyboardTeacher extends PApplet {

Box keyboard;
Box textToWrite;
Box indicators;

Button start;
Button settings;
Button progress;

Button close;
Button backToMenu;

Button easyMode;
Button normalMode;
Button hardMode;

Key[] keysOfKeyboard = new Key[117];

boolean mainMenuOpened = true, settingsMenuOpened = false, backMenuOpened = false, startMenuOpened = false;
int mainMenuVisibility = 0, backMenuVisibility = 0, settingsMenuVisibility = 0, startMenuVisibility = 0, transitionSpeed = 30; 

public void mainMenu() {
  start.show(mainMenuVisibility, start.changeDynamicColors());
  startButton();

  settings.x = width/2;
  settings.y =  height/2;
  settings.selfWidth = 250;
  settings.selfHeight = 75;
  settings.show(mainMenuVisibility, settings.changeDynamicColors());
  settingsButton();

  progress.show(mainMenuVisibility, progress.changeDynamicColors());
  progressButton();
}

public void backMenu() {
  backToMenu.show(backMenuVisibility, backToMenu.changeDynamicColors());
  backToMenuButton();
}

public void settingsMenu() {
  settings.x = width/2;
  settings.y =  height/2-200;
  settings.selfWidth = 300;
  settings.selfHeight = 90;

  settings.show(settingsMenuVisibility, /*settings.changeDynamicColors()*/ 0);
  easyMode.show(settingsMenuVisibility, easyMode.changeDynamicColors());
  normalMode.show(settingsMenuVisibility, normalMode.changeDynamicColors());
  hardMode.show(settingsMenuVisibility, hardMode.changeDynamicColors());
}

public void startMenu() {
  keyboard.show(startMenuVisibility, 1);
  textToWrite.show(startMenuVisibility, 1);
  indicators.show(startMenuVisibility, 1);

  keyboard();
}

public void keyboard() {
  if (startMenuOpened && mainMenuVisibility == 0) {
    if (keyCode == SHIFT) {
      for (int i = 0; i < 117; i++) {
        keysOfKeyboard[i].show(300, keysOfKeyboard[i].changeDynamicColors());
      }
    } else {
      for (int i = 116; i >= 0; i--) {
        keysOfKeyboard[i].show(300, keysOfKeyboard[i].changeDynamicColors());
      }
    }
  }
}

public void closeButton() {
  if (close.selfClicked(true)) {
    delay(100);
    exit();
  }
}

public void startButton() {
  if (start.selfClicked(mainMenuOpened)) {
    delay(100);
    mainMenuOpened = false;
    settingsMenuOpened = false;
    backMenuOpened = true;
    startMenuOpened = true;
  }
}

public void settingsButton() {
  if (settings.selfClicked(mainMenuOpened)) {
    delay(100);
    mainMenuOpened = false;
    settingsMenuOpened = true;
    backMenuOpened = true;
    startMenuOpened = false;
  }
}

public void progressButton() {
  if (progress.selfClicked(mainMenuOpened)) {
    delay(100);
    mainMenuOpened = false;
    settingsMenuOpened = false;
    backMenuOpened = true;
    startMenuOpened = false;
  }
}

public void backToMenuButton() {
  if (backToMenu.selfClicked(!mainMenuOpened)) {
    delay(100);
    mainMenuOpened = true;
    settingsMenuOpened = false;
    backMenuOpened = false;
    startMenuOpened = false;
  }
}

public void changeMenuVisibility() { // Function switching from a menu to another
  if (mainMenuOpened && mainMenuVisibility != 300 && backMenuVisibility == 0) {
    mainMenuVisibility += transitionSpeed;
  } else if (!mainMenuOpened && mainMenuVisibility != 0 && backMenuVisibility == 0) {
    mainMenuVisibility -= transitionSpeed;
  } else if (!mainMenuOpened && backMenuOpened && mainMenuVisibility == 0 && backMenuVisibility != 300) {
    backMenuVisibility += transitionSpeed;
    if (settingsMenuOpened && settingsMenuVisibility != 300) {
      settingsMenuVisibility += transitionSpeed;
    } else if (startMenuOpened && startMenuVisibility != 300) {
      startMenuVisibility += transitionSpeed;
    }
  } else if (mainMenuOpened && mainMenuVisibility == 0 && backMenuVisibility != 0) {
    backMenuVisibility -= transitionSpeed;
    if (!settingsMenuOpened && settingsMenuVisibility != 0) {
      settingsMenuVisibility -= transitionSpeed;
    }
    if (!startMenuOpened && startMenuVisibility != 0) {
      startMenuVisibility -= transitionSpeed;
    }
  }
}

public void setup() {
   //size(displayWidth, displayHeight); frame.setLocation(0, 0);
  rectMode(CENTER);

  keyboard = new Box(width / 2, (3 * 60 + 400), (15 * 60 + 25), (5 * 60 + 25), "");
  keyboard.edgeRoundness = 10;
  textToWrite = new Box(width / 2, (275 / 2 + 25), (15 * 60 + 25), 275, "");
  textToWrite.edgeRoundness = 10;
  indicators = new Box(width / 2, (height - (3 * 60 + 230)), (15 * 60 + 25), 100, "");
  indicators.edgeRoundness = 10;

  start = new Button(width / 2, height / 2 - 82, 250, 75, "Start"); 
  settings = new Button(width / 2, height / 2, 250, 75, "Settings"); 
  progress = new Button(width / 2, height / 2 + 82, 250, 75, "Progress"); 

  close = new Button(width - 100, 50, 100, 50, "close"); 
  backToMenu = new Button(width - 100, 110, 100, 50, "menu");

  easyMode = new Button(width / 2, height / 2 - 82, 250, 75, "EasyMode"); 
  normalMode = new Button(width / 2, height / 2, 250, 75, "NormalMode"); 
  hardMode = new Button(width / 2, height / 2 + 82, 250, 75, "HardMode"); 

  String[] keys = loadStrings("Keys.txt");

  for (int index = 0; index < 117; index++) {
    int spaceOne = keys[index].indexOf(" ");
    int spaceTwo = keys[index].indexOf(" ", spaceOne + 1);
    int keyX = PApplet.parseInt(keys[index].substring(spaceOne + 1, spaceTwo)) * 60 + (width - 60 * 16) / 2, 
      keyY = PApplet.parseInt(keys[index].substring(spaceTwo + 1, keys[index].length() - 1)) * 60 + 400;
    String keyText = keys[index].substring(0, spaceOne);

    keysOfKeyboard[index] = new Key(keyX, keyY, 50, 50, keyText);
  }
}

public void draw() {
  background(0xffADF6FF);

  close.show(300, close.changeDynamicColors());
  closeButton();

  changeMenuVisibility();

  mainMenu();
  backMenu();
  settingsMenu();
  startMenu();
}
class Box {
  PFont textFont;

  int x, y, selfWidth, selfHeight, edgeRoundness, textSize, transparency;
  String text;
  int[] strokeColor = new int[3], fillColor = new int[3], textColor = new int[3];

  Box(int X, int Y, int W, int H, String T) {
    x = X;
    y = Y;
    selfWidth = W;
    selfHeight = H;
    text = T;
    textFont = loadFont("AgencyFB-Bold-48.vlw");
    textSize = 1;
    textAlign(LEFT, UP);
    edgeRoundness = 20;
    setDynamicColors(200, 0xffE3E3E3, 50, 50, 0xffE3E3E3, 200, 0xffE3E3E3, 400, 400);
  }

  public void setDynamicColors(int stroke_1, int fill_1, int text_1, int stroke_2, int fill_2, int text_2, int stroke_3, int fill_3, int text_3) {
    // First set of colors
    strokeColor[0] = stroke_1;
    strokeColor[1] = stroke_2;
    strokeColor[2] = stroke_3;

    // Second set of Colors
    fillColor[0] = fill_1;
    fillColor[1] = fill_2;
    fillColor[2] = fill_3;

    // Third set of colors
    textColor[0] = text_1;
    textColor[1] = text_2;
    textColor[2] = text_3;
  }

  public void show(int transparency, int setOfColors) {
    this.transparency = transparency;

    strokeWeight(2.5f);
    stroke(strokeColor[setOfColors], transparency);
    fill(fillColor[setOfColors], transparency);
    rect (x, y, selfWidth, selfHeight, edgeRoundness);


    fill(textColor[setOfColors], transparency);
    textFont (textFont);
    textSize(textSize);
    text (text, x, y);
  }
}
class Button extends Box {

  Button(int X, int Y, int W, int H, String T) {
    super(X, Y, W, H, T);
    textSize = selfWidth / text.length();
    textAlign(CENTER, CENTER);
    setDynamicColors(0xff0021F0, 0xff0021F0, 0xffF021FF, 0xffFFFFFF, 0xffC8C8C8, 0xffFFFFFF, 0xffFF0000, 0xffFF6405, 0xffF0F000);
    edgeRoundness = (selfWidth - selfHeight / 2) / 10;
  }

  public int changeDynamicColors() {
    if (mouseInside()) {
      if (selfClicked(true)) {
        return 1;
      } else {
        return 2;
      }
    } else {
      return 0;
    }
  }

  public boolean mouseInside() {
    if ((mouseX < x + selfWidth / 2 && mouseX > x - selfWidth / 2) && (mouseY < y + selfHeight / 2 && mouseY > y - selfHeight / 2)) {
      return true;
    } else {
      return false;
    }
  }

  public boolean selfClicked(boolean activated) {
    if (mouseInside() && mousePressed && activated) {
      return true;
    } else {
      return false;
    }
  }
}
class Key extends Box {

  Key(int X, int Y, int W, int H, String T) {
    super(X, Y, W, H, T);
    textSize = selfWidth / text.length() / 2 + 10;
    textAlign(CENTER, CENTER);
    setDynamicColors(234324, 0xffD0D0D0, 324324, 100, 0xffD0D0D0, 90, 0, 0xffD0D0D0, 50);
    edgeRoundness = 10;
  }

  public int changeDynamicColors() {
    if (keyPressed) {
      if (text.length() == 1 && key == text.charAt(0)) {
        return 2;
      } else {
        return 1;
      }
    } else {
      return 1;
    }
  }
}
  public void settings() {  fullScreen (); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "KeyboardTeacher" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
