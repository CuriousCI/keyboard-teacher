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

PFont textFont;

Box keyboard;
Box textToWrite;
Box indicatorsBar;

Box beatsPerMinute;
Box charactersToWriteBox;
Box writtenCharactersBox;
Box time;
Box percentageOfCompletion;
Box percentageOfCorrectText;

Box currentMode;
Box currentUser;

Button start;
Button settings;
Button progress;

Button close;
Button backToMenu;

Button easyMode;
Button normalMode;
Button hardMode;

Button addUser;
Button selectUser;

Key[] keysOfKeyboard = new Key[117];

boolean mainMenuOpened = true, settingsMenuOpened = false, startMenuOpened = false, progressMenuOpened = false, backMenuOpened = false, 
  easyModeActive = false, normalModeActive = false, hardModeActive = true, exerciseActive = false, exerciseActivable = true; 
int mainMenuVisibility = 0, startMenuVisibility = 0, settingsMenuVisibility = 0, progressMenuVisibility = 0, backMenuVisibility = 0, transitionSpeed = 30, 
  frame = 0, second = 0, charactersToWrite = 0, writtenCharacters = 0, correctCharacters = 0, wrongCharacters = 0, beats = 0, 
  textX, textY = 50, MAX_LINES = 50, line = 0;
String[] unwrittenText = new String[MAX_LINES], wrongText = new String[MAX_LINES], correctText = new String[MAX_LINES], writtenText = new String[MAX_LINES];

public void setup() {
   //size(displayWidth, displayHeight); frame.setLocation(0, 0);
  rectMode(CENTER);
  textFont = loadFont("AgencyFB-Bold-48.vlw");
  textAlign(CENTER, CENTER);

  String[] keys = loadStrings("Keys.txt");
  String[] Settings = loadStrings("Settings.txt");

  for (int i = 0; i < MAX_LINES; i++) {
    unwrittenText[i] = " ";
    writtenText[i] = " ";
    wrongText[i] = " ";
    correctText[i] = " ";
  }

  keyboard = new Box(width / 2, (3 * 60 + 400), 925, (5 * 60 + 25), "");
  textToWrite = new Box(width / 2, (275 / 2 + 25), 925, 275, "[press a key to start]");
  indicatorsBar = new Box(width / 2, (height - (3 * 60 + 230)), 925, 100, "");

  beatsPerMinute = new Box(width / 2 - 306, height - 433, 298, 40, "BEATS/MINUTE: ");
  charactersToWriteBox = new Box(width / 2 - 306, height - 387, 300, 40, "CHARACTERS TO WRITE: ");
  writtenCharactersBox = new Box(width / 2, height - 387, 300, 40, "WRITTEN CHARACTERS: ");
  time = new Box(width / 2, height - 433, 300, 40, "TIME: "); 
  time.textSize /= 2;
  percentageOfCompletion = new Box(width / 2 + 306, height - 433, 300, 40, "COMPLETION: ");
  percentageOfCorrectText = new Box(width / 2 + 306, height - 387, 300, 40, "CORRECT TEXT:");

  currentMode = new Box(width / 2, height / 2 + 164, 250, 50, "");
  currentUser = new Box(width / 2, height / 2 + 218, 250, 50, "");
  currentUser.text = Settings[0].substring(0, Settings[0].length());

  start = new Button(width / 2, height / 2 - 82, 250, 75, "Start"); 
  settings = new Button(width / 2, height / 2, 250, 75, "Settings"); 
  progress = new Button(width / 2, height / 2 + 82, 250, 75, "Progress"); 

  close = new Button(width - 100, 50, 100, 50, "close"); 
  backToMenu = new Button(width - 100, 110, 100, 50, "menu");

  easyMode = new Button(width / 2, height / 2 - 82, 250, 75, "EasyMode"); 
  normalMode = new Button(width / 2, height / 2, 250, 75, "NormalMode"); 
  hardMode = new Button(width / 2, height / 2 + 82, 250, 75, "HardMode"); 

  addUser = new Button(165, 50, 220, 50, "Add User");
  addUser.edgeRoundness = 7;
  selectUser = new Button(395, 50, 220, 50, "Select User");
  selectUser.edgeRoundness = 7;

  for (int index = 0; index < 117; index++) {
    int spaceOne = keys[index].indexOf(" ");
    int spaceTwo = keys[index].indexOf(" ", spaceOne + 1);
    int keyX = PApplet.parseInt ( PApplet.parseFloat(keys[index].substring(spaceOne + 1, spaceTwo)) * 60 + (width - 60 * 16) / 2 ), 
      keyY = PApplet.parseInt ( PApplet.parseFloat(keys[index].substring(spaceTwo + 1, keys[index].length() - 1)) * 60 + 400 );
    String keyText = keys[index].substring(0, spaceOne); 

    int keyTextASCII = 0;
    if (keyText.length() == 1) {
      keyTextASCII = PApplet.parseInt(keyText.charAt(0));
    } else {
      keyTextASCII = 0;
    }
    if (keyTextASCII >= PApplet.parseInt('0') && keyTextASCII <= PApplet.parseInt('9') || (keyTextASCII >= PApplet.parseInt('a') && keyTextASCII <= PApplet.parseInt('z')) && keyText.length() == 1) {
      keysOfKeyboard[index] = new Key(keyX, keyY, 50, 50, keyText);
    } else {
      keysOfKeyboard[index] = new Key(keyX, keyY, 50, 50, "");
    }
  }
}

public void draw() {
  background(0xffADF6FF);

  close.show(300);
  closeButtonClicked();

  changeMenuVisibility();

  mainMenu();
  backMenu();
  settingsMenu();
  startMenu();
  progressMenu();
}
public void mainMenu() {
  start.show(mainMenuVisibility);
  startButtonClicked();

  settings.x = width/2;
  settings.y =  height/2;
  settings.selfWidth = 250;
  settings.selfHeight = 75;
  settings.show(mainMenuVisibility);
  settingsButtonClicked();

  progress.show(mainMenuVisibility);
  progressButtonClicked();

  currentData();
}

public void startMenu() {
  if (easyModeActive) {
    keyboard.staticShow(startMenuVisibility);
    textToWrite.selfHeight = 275;
    textToWrite.y = 275 / 2 + 25;
    textToWrite.staticShow(startMenuVisibility);
    indicatorsBar.y = height - (3 * 60 + 230);
    indicatorsBar.staticShow(startMenuVisibility);
    keyboard();
  } else if (normalModeActive) {
    keyboard.staticShow(startMenuVisibility);
    textToWrite.selfHeight = 275;
    textToWrite.y = 275 / 2 + 25;
    textToWrite.staticShow(startMenuVisibility);
    indicatorsBar.y = height - (3 * 60 + 230);
    indicatorsBar.staticShow(startMenuVisibility);
    keyboard();
  } else if (hardModeActive) {
    textToWrite.selfHeight = 580;
    textToWrite.y = 320;
    textToWrite.staticShow(startMenuVisibility);
    indicatorsBar.y = height - 100;
    indicatorsBar.staticShow(startMenuVisibility);
  }
  exercise();
}

public void settingsMenu() {
  settings.x = width/2;
  settings.y =  height/2-200;
  settings.selfWidth = 300;
  settings.selfHeight = 90;

  settings.show(settingsMenuVisibility);
  easyMode.show(settingsMenuVisibility);
  easyModeButtonClicked();
  normalMode.show(settingsMenuVisibility);
  normalModeButtonClicked();
  hardMode.show(settingsMenuVisibility);
  hardModeButtonClicked();
}

public void progressMenu() {
  addUser.show(progressMenuVisibility);
  selectUser.show(progressMenuVisibility);
}

public void currentData() {
  if (easyModeActive) {
    currentMode.text = "current mode: [EASY]";
  } else if (normalModeActive) {
    currentMode.text = "current mode: [NORMAL]";
  } else if (hardModeActive) {
    currentMode.text = "current mode: [HARD]";
  }

  currentMode.setColors(0xff0021F0, 0xff0021F0, 0xffF021FF);
  currentMode.textSize = currentMode.selfWidth / currentMode.text.length() * 2; 
  currentUser.setColors(0xff0021F0, 0xff0021F0, 0xffF021FF);
  currentUser.textSize = currentUser.selfWidth / currentUser.text.length() * 2; 

  if (progressMenuOpened && mainMenuVisibility == 0) {
    currentMode.x = 640; 
    currentMode.y = 50; 
    currentUser.x = 900; 
    currentUser.y = 50;
  } else if (mainMenuOpened && progressMenuVisibility == 0) {
    currentMode.x = width / 2; 
    currentMode.y = height / 2 + 164; 
    currentUser.x = width / 2; 
    currentUser.y = height / 2 + 218;
  }

  if (((!mainMenuOpened && settingsMenuOpened) || (mainMenuOpened && !settingsMenuOpened)) && (startMenuVisibility == 0 && progressMenuVisibility == 0)) {
    currentMode.staticShow(300);
    currentUser.staticShow(300);
  } else {
    currentMode.staticShow(mainMenuVisibility + settingsMenuVisibility + progressMenuVisibility);
    currentUser.staticShow(mainMenuVisibility + settingsMenuVisibility + progressMenuVisibility);
  }
}

public void backMenu() {
  backToMenu.show(backMenuVisibility);
  backToMenuButtonClicked();
}

public void keyboard() {
  if (startMenuOpened && startMenuVisibility >= 150) {
    for (int i = 116; i >= 0; i--) {
      keysOfKeyboard[i].show(300);
    }
  }
}

public void exercise() {
  if (keyPressed && !exerciseActive && exerciseActivable) {
    exerciseActive = true;
    exerciseActivable = false;
    textToWrite.text = "";
    frame = 0;
  }
  if (exerciseActive) {
    textAlign(LEFT, CENTER);
    textSize(25);
    textX = width / 2 - 925 / 2 + 14; 
    unwrittenText[line] = "Ciao questo e un testo casuale per testare la funzionalita del programma";
    textSize(22);
    if (keyPressed) {
      writtenText[line] += key;
      correctText[line] += key;
      wrongText[line] += key;
      String strangeText = unwrittenText[line];
      unwrittenText[line] = " ";
      for (int i = 0; i < writtenText[line].length(); i++) {
        unwrittenText[line] += " ";
      }
      if (writtenText[line].length() < strangeText.length()) {
        unwrittenText[line] += strangeText.substring(writtenText[line].length());
      }
      if (textWidth(writtenText[line]) > 890) line++;
      beats++;
      keyPressed = false;
      delay(100);
    }
    for (int i = 0; i <= line; i++) {
      fill(200, 200, 200, startMenuVisibility);
      text(unwrittenText[i], textX, textY  + i * 28);
      if (easyModeActive) {
        fill(0, 255, 0, startMenuVisibility);
        text(correctText[i], textX - 5, textY  + i * 28);
        fill(255, 0, 0, startMenuVisibility);
        text(wrongText[i], textX - 5, textY  + i * 28);
      } else {
        fill(0, 0, 0, startMenuVisibility);
        text(writtenText[i], textX - 5, textY + i * 28);
      }
    }
    textAlign(CENTER, CENTER);

    indicators();
    if (writtenText[line].length() > unwrittenText[line].length() + 1 && exerciseActive) {
      exerciseActive = false;
      textToWrite.text = "[Exercise is over! Good job!]";
      for (int i = 0; i <= line; i++) {
        writtenText[i] = " ";
      }
      line = 0;
      textToWrite.staticShow(300);
    }
  }
}

public void indicators() {
  frame++;
  if (frame >= PApplet.parseInt(frameRate)) {
    second++;
    frame = 0;
  }
  if (easyModeActive || normalModeActive) {
    beatsPerMinute.x = width / 2 - 306; 
    beatsPerMinute.y = height - 433; 
    charactersToWriteBox.x = width / 2 - 306; 
    charactersToWriteBox.y = height - 387; 
    writtenCharactersBox.x = width / 2; 
    writtenCharactersBox.y = height - 387; 
    time.x = width / 2; 
    time.y = height - 433; 
    percentageOfCompletion.x = width / 2 + 306; 
    percentageOfCompletion.y = height - 433; 
    percentageOfCorrectText.x =width / 2 + 306; 
    percentageOfCorrectText.y = height - 387;
  } else if (hardModeActive) {
    beatsPerMinute.x = width / 2 - 306; 
    beatsPerMinute.y = height - 123; 
    charactersToWriteBox.x = width / 2 - 306; 
    charactersToWriteBox.y = height - 77; 
    writtenCharactersBox.x = width / 2; 
    writtenCharactersBox.y = height - 77; 
    time.x = width / 2; 
    time.y = height - 123; 
    percentageOfCompletion.x = width / 2 + 306; 
    percentageOfCompletion.y = height - 123; 
    percentageOfCorrectText.x =width / 2 + 306; 
    percentageOfCorrectText.y = height - 77;
  }

  charactersToWrite = 0;
  writtenCharacters = 0;
  correctCharacters = 0;
  wrongCharacters = 0;
  for (int i = 0; i < MAX_LINES; i++) {
    charactersToWrite += unwrittenText[i].length() - writtenText[i].length();
    writtenCharacters += writtenText[i].length();
    correctCharacters += correctText[i].length();
    wrongCharacters += wrongText[i].length();
  }

  if (beats != 0 && second != 0 && charactersToWrite != 0 && writtenCharacters != 0 && correctCharacters != 0 && wrongCharacters != 0) {
    beatsPerMinute.text = "BEATS/MINUTE: " + PApplet.parseInt(beats * 60 / second);
    charactersToWriteBox.text = "CHARACTERS TO WRITE: " + charactersToWrite;
    writtenCharactersBox.text = "WRITTEN CHARACTERS: " + writtenCharacters;
    time.text = "TIME: " + second; 
    percentageOfCompletion.text = "COMPLETION: " + PApplet.parseInt(writtenCharacters * 100 / charactersToWrite) + "%";
    percentageOfCorrectText.text = "CORRECT TEXT:" + PApplet.parseInt(correctCharacters * 100 / writtenCharacters) + "%";
  }

  beatsPerMinute.staticShow(startMenuVisibility);
  charactersToWriteBox.staticShow(startMenuVisibility);
  writtenCharactersBox.staticShow(startMenuVisibility);
  time.staticShow(startMenuVisibility);
  percentageOfCompletion.staticShow(startMenuVisibility);
  percentageOfCorrectText.staticShow(startMenuVisibility);
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
    } else if (progressMenuOpened && progressMenuVisibility != 300) {
      progressMenuVisibility += transitionSpeed;
    }
  } else if (mainMenuOpened && mainMenuVisibility == 0 && backMenuVisibility != 0) {
    backMenuVisibility -= transitionSpeed;
    if (!settingsMenuOpened && settingsMenuVisibility != 0) {
      settingsMenuVisibility -= transitionSpeed;
    }
    if (!startMenuOpened && startMenuVisibility != 0) {
      startMenuVisibility -= transitionSpeed;
    }
    if (!progressMenuOpened && progressMenuVisibility != 0) {
      progressMenuVisibility -= transitionSpeed;
    }
  }
}
class Box {

  int x, y, selfWidth, selfHeight, edgeRoundness, textSize, transparency;
  String text;
  int[] selfColor = new int[3];

  Box(int X, int Y, int W, int H, String T) {
    x = X;
    y = Y;
    selfWidth = W;
    selfHeight = H;

    setColors(50, 0xffE3E3E3, 20);

    text = T;
    if (text.length() == 0) {
      textSize = 1;
    } else {
      textSize = selfWidth / text.length();
    }
    edgeRoundness = 10;
  }

  public void setColors(int stroke, int fill, int text) {
    selfColor[0] = stroke;
    selfColor[1] = fill;
    selfColor[2] = text;
  }

  public void staticShow(int transparency) {
    this.transparency = transparency;
    strokeWeight(2.5f);
    stroke(selfColor[0], transparency);
    fill(selfColor[1], transparency);
    rect (x, y, selfWidth, selfHeight, edgeRoundness);


    fill(selfColor[2], transparency);
    textFont (textFont);
    textSize(textSize);
    text (text, x, y);
  }
}
class Button extends Box {

  Button(int X, int Y, int W, int H, String T) {
    super(X, Y, W, H, T);
    textAlign(CENTER, CENTER);
    edgeRoundness = (selfWidth - selfHeight / 2) / 10;
  }

  public void show(int transparency) {
    changeDynamicColors();
    staticShow(transparency);
  }

  public void changeDynamicColors() {
    if (mouseInside()) {
      if (selfClicked(true)) {
        setColors(0xffFFFFFF, 0xffC8C8C8, 0xffFFFFFF);
      } else {
        setColors(0xffFF0000, 0xffFF6405, 0xffF0F000);
      }
    } else {
      setColors(0xff0021F0, 0xff0021F0, 0xffF021FF);
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
public void closeButtonClicked() {
  if (close.selfClicked(true)) {
    delay(100);
    exit();
  }
}

public void startButtonClicked() {
  if (start.selfClicked(mainMenuOpened)) {
    delay(100);
    mainMenuOpened = false;
    settingsMenuOpened = false;
    backMenuOpened = true;
    startMenuOpened = true;
    progressMenuOpened = false;
    textToWrite.text = "[press a key to start]";
  }
}

public void settingsButtonClicked() {
  if (settings.selfClicked(mainMenuOpened)) {
    delay(100);
    mainMenuOpened = false;
    settingsMenuOpened = true;
    backMenuOpened = true;
    startMenuOpened = false;
    progressMenuOpened = false;
  }
}

public void progressButtonClicked() {
  if (progress.selfClicked(mainMenuOpened)) {
    delay(100);
    mainMenuOpened = false;
    settingsMenuOpened = false;
    backMenuOpened = true;
    startMenuOpened = false;
    progressMenuOpened = true;
  }
}

public void backToMenuButtonClicked() {
  if (backToMenu.selfClicked(!mainMenuOpened)) {
    delay(100);
    mainMenuOpened = true;
    settingsMenuOpened = false;
    backMenuOpened = false;
    startMenuOpened = false;
    progressMenuOpened = false;
    exerciseActivable = true;
  }
}

public void easyModeButtonClicked() {
  if (easyMode.selfClicked(settingsMenuOpened && settingsMenuVisibility == 300)) {
    delay(100);
    easyModeActive = true;
    normalModeActive = false;
    hardModeActive = false;
  }
}

public void normalModeButtonClicked() {
  if (normalMode.selfClicked(settingsMenuOpened && settingsMenuVisibility == 300)) {
    delay(100);
    easyModeActive = false;
    normalModeActive = true;
    hardModeActive = false;
  }
}

public void hardModeButtonClicked() {
  if (hardMode.selfClicked(settingsMenuOpened && settingsMenuVisibility == 300)) {
    delay(100);
    easyModeActive = false;
    normalModeActive = false;
    hardModeActive = true;
  }
}
class Key extends Box {

  Key(int X, int Y, int W, int H, String T) {
    super(X, Y, W, H, T);
    if (textSize != 1) {
      textSize = selfWidth / text.length() / 2 + 10;
    }
    textAlign(CENTER, CENTER);
  }

  public void show(int transparency) {
    changeDynamicColors();
    staticShow(transparency);
  }

  public void changeDynamicColors() {
    if (keyPressed) {
      if (text.length() == 1 && key == text.charAt(0)) {
        setColors(0, 0xffD0D0D0, 50);
      } else {
        //if (easyModeActive){
        //  if (unwrittenText[line].charAt(writtenText[line].length()) == key){
        //    setColors(color(0, 255, 0), color(0, 255, 0), color(0, 255, 0));
        //  } else {
        //    setColors(color(255, 0, 0), color(255, 0, 0), color(255, 0, 0));
        //  }
        //} else {
        setColors(100, 0xffD0D0D0, 90);
        //}
      }
    } else {
      setColors(100, 0xffD0D0D0, 90);
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
