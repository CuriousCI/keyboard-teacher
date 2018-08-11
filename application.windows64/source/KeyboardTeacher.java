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
  frame = 0, second = 0, beats = 0, MAX_ROWS = 20, MAX_COLUMNS = 87;
String unwrittenText = "ciao questo e un testo a caso provalo", wrongText = "", correctText = "", writtenText = "";
char[][] matrix = new char[MAX_ROWS][MAX_COLUMNS];


public void setup() {
   //size(displayWidth, displayHeight); frame.setLocation(0, 0);
  rectMode(CENTER);
  textFont = loadFont("AgencyFB-Bold-48.vlw");
  textAlign(CENTER, CENTER);

  String[] keys = loadStrings("Keys.txt");

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
  currentUser.text = "current user: standard";

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

  if (mainMenuOpened) mainMenu();
  if (startMenuOpened) startMenu();
  if (settingsMenuOpened) settingsMenu();
  if (progressMenuOpened) progressMenu();
  currentData();
  backMenu();

  fill(0);
  text(mouseX, mouseX + 100, mouseY + 150);
  text(mouseY, mouseX + 100, mouseY + 100);
}
public void mainMenu() {
  start.show(mainMenuVisibility);
  startButtonClicked();

  settings.setData(width/2, height/2, 250, 75);
  settings.show(mainMenuVisibility);
  settingsButtonClicked();

  progress.show(mainMenuVisibility);
  progressButtonClicked();
}

public void startMenu() {
  if (easyModeActive) {
    keyboard.staticShow(startMenuVisibility);
    textToWrite.selfHeight = 275;
    textToWrite.y = 275 / 2 + 25;
    indicatorsBar.y = height - (3 * 60 + 230);
    keyboard();
  } else if (normalModeActive) {
    keyboard.staticShow(startMenuVisibility);
    textToWrite.selfHeight = 275;
    textToWrite.y = 275 / 2 + 25;
    indicatorsBar.y = height - (3 * 60 + 230);
    keyboard();
  } else if (hardModeActive) {
    textToWrite.selfHeight = 580;
    textToWrite.y = 320;
    indicatorsBar.y = height - 100;
  }  
  textToWrite.staticShow(startMenuVisibility);
  indicatorsBar.staticShow(startMenuVisibility);

  exercise();
}

public void settingsMenu() {
  settings.setData(width/2, height/2-200, 300, 90);
  settings.setColors(0xff0021F0, 0xff0021F0, 0xffF021FF);

  settings.staticShow(settingsMenuVisibility);
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
    currentMode.setCoordinates(640, 50);
    currentUser.setCoordinates(900, 50);
  } else if (mainMenuOpened && progressMenuVisibility == 0) {  
    currentMode.setCoordinates(width / 2, height / 2 + 164);
    currentUser.setCoordinates(width / 2, height / 2 + 218);
  }

  if (((!mainMenuOpened && settingsMenuOpened) || (mainMenuOpened && !settingsMenuOpened)) && (startMenuVisibility == 0 && progressMenuVisibility == 0)) {
    currentMode.staticShow(300);
    currentUser.staticShow(300);
  } else if (progressMenuOpened) {
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
    keyPressed = false;
    delay(100);
  }
  if (exerciseActive) {
    textAlign(LEFT, CENTER);
    textSize(25);

    if (keyPressed) {
      writtenText += key;
      if (key == unwrittenText.charAt(writtenText.length() - 1)) {
        correctText += key;
        wrongText += '░';
      } else {
        correctText += '░';
        wrongText += key;
      }

      String test = unwrittenText;
      unwrittenText = " ";
      for (int i = 1; i < writtenText.length(); i++) unwrittenText += ' ';          
      if (writtenText.length() < test.length()) unwrittenText += test.substring(writtenText.length());

      beats++;
      keyPressed = false;
      delay(100);
    }

    fill(200, 200, 200, startMenuVisibility);
    matrix = assignText(unwrittenText);
    display();
    if (easyModeActive) {
      fill(0, 255, 0, startMenuVisibility);
      matrix = assignText(correctText);
      display();
      fill(255, 0, 0, startMenuVisibility);
      matrix = assignText(wrongText);
      display();
    } else {
      fill(0, 0, 0, startMenuVisibility);
      matrix = assignText(writtenText);
      display();
    }
    textAlign(CENTER, CENTER);

    indicators();

    if (writtenText.length() > unwrittenText.length() - 1 && exerciseActive) {
      exerciseActive = false;
      textToWrite.text = "[Exercise is over! Good job!]";
      textToWrite.staticShow(300);
      writtenText = " ";
      correctText = " ";
      wrongText = " ";
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
    beatsPerMinute.setCoordinates(width / 2 - 306, height - 433);
    charactersToWriteBox.setCoordinates(width / 2 - 306, height - 387);
    writtenCharactersBox.setCoordinates(width / 2, height - 387);
    time.setCoordinates(width / 2, height - 433);
    percentageOfCompletion.setCoordinates(width / 2 + 306, height - 433);
    percentageOfCorrectText.setCoordinates(width / 2 + 306, height - 387);
  } else if (hardModeActive) {
    beatsPerMinute.setCoordinates(width / 2 - 306, height - 123);
    charactersToWriteBox.setCoordinates(width / 2 - 306, height - 77);
    writtenCharactersBox.setCoordinates(width / 2, height - 77);
    time.setCoordinates(width / 2, height - 123);
    percentageOfCompletion.setCoordinates(width / 2 + 306, height - 123);
    percentageOfCorrectText.setCoordinates(width / 2 + 306, height - 77);
  }

  int charactersToWrite = unwrittenText.length(), writtenCharacters = writtenText.length(), correctCharacters = 0, wrongCharacters = 0;
  for (int i = 0; i < writtenText.length(); i++) {
    if (correctText.charAt(i) != '░') {
      correctCharacters++;
    } else if (wrongText.charAt(i) != '░') {
      wrongCharacters++;
    }
  }

  if (beats != 0 && second != 0 && charactersToWrite != 0 && writtenCharacters != 0 /*&& correctCharacters != 0 && wrongCharacters != 0*/) {
    beatsPerMinute.text = "BEATS/MINUTE: " + PApplet.parseInt(beats * 60 / second);
    charactersToWriteBox.text = "CHARACTERS TO WRITE: " + charactersToWrite;
    writtenCharactersBox.text = "WRITTEN CHARACTERS: " + writtenCharacters;
    time.text = "TIME: " + second; 
    percentageOfCompletion.text = "COMPLETION: " + PApplet.parseInt((writtenCharacters * 100) / charactersToWrite) + "%";
    percentageOfCorrectText.text = "CORRECT TEXT:" + PApplet.parseInt((correctCharacters * 100) / writtenCharacters) + "%";
  }

  beatsPerMinute.staticShow(startMenuVisibility);
  charactersToWriteBox.staticShow(startMenuVisibility);
  writtenCharactersBox.staticShow(startMenuVisibility);
  time.staticShow(startMenuVisibility);
  percentageOfCompletion.staticShow(startMenuVisibility);
  percentageOfCorrectText.staticShow(startMenuVisibility);
}

public char[][] assignText(String text) {
  char[][] array = new char[MAX_ROWS][MAX_COLUMNS];
  int row = 0, index = 0;
  for (int column = 0; column < MAX_COLUMNS && row < MAX_ROWS; column++) {
    if (index < text.length()) {
      array[row][column] = text.charAt(index);
    } else {
      array[row][column] = '░';
    }
    if (column == MAX_COLUMNS - 1 && row < MAX_ROWS - 1) {
      row++;
      column = -1;
    }
    index++;
  }
  return array;
}

public void display() {
  textAlign(CENTER, CENTER);
  for (int i = 0; i < MAX_ROWS; i++) {
    for (int j = 0; j < MAX_COLUMNS; j++) {
      if (matrix[i][j] != '░') {
        text(matrix[i][j], 249 + j * 10, 65 + i * 27);
      }
    }
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

  Box(int x, int y, int w, int h, String text) {
    this.x = x;
    this.y = y;
    selfWidth = w;
    selfHeight = h;

    setColors(50, 0xffE3E3E3, 20);

    this.text = text;
    if (text.length() == 0) {
      textSize = 1;
    } else {
      textSize = selfWidth / text.length();
    }
    edgeRoundness = 10;
  }

  public void setCoordinates(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public void setDimensions(int w, int h) {
    selfWidth = w;
    selfHeight = h;
  }

  public void setData(int x, int y, int w, int h) {
    setCoordinates(x, y);
    setDimensions(w, h);
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

  Button(int x, int y, int w, int h, String text) {
    super(x, y, w, h, text);
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
    unwrittenText = "ciao questo e un testo a caso provalo";
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
    exerciseActive = false;
    writtenText = " ";
    correctText = " ";
    wrongText = " ";
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

  Key(int x, int y, int w, int h, String text) {
    super(x, y, w, h, text);
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
    String[] appletArgs = new String[] { "KeyboardTeacher" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
