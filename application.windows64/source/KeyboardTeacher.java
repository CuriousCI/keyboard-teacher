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

Box userNameBox;
Box userData;

Button start;
Button settings;
Button progress;

Button close;
Button backToMenu;
Button restartExercise; 

Button easyMode;
Button normalMode;
Button hardMode;
Button selectText;

Button addUser;
Button removeUser;

Button[] everySingleUser;

Key[] keysOfKeyboard;

boolean mainMenuOpened = true, settingsMenuOpened = false, startMenuOpened = false, progressMenuOpened = false, backMenuOpened = false, 
  easyModeActive = false, normalModeActive = false, hardModeActive = false, exerciseActive = false, exerciseActivable = true, 
  userNameWritable = false, writable = true; 
int mainMenuVisibility = 0, startMenuVisibility = 0, settingsMenuVisibility = 0, progressMenuVisibility = 0, backMenuVisibility = 0, 
  restartExerciseButtonVisibility = 0, userNameBoxVisibility = 0, transitionSpeed = 30, 
  frame = 0, second = 0, minute = 0, beats = 0, MAX_ROWS = 20, MAX_COLUMNS = 87;
String unwrittenText, wrongText, correctText, writtenText, userName = "";
String[] keys, sentences, users, setting, currentUserData;
char[][] matrix = new char[MAX_ROWS][MAX_COLUMNS];
char lastKey = ' ';

public void setup() {
   //size(1000, 700); //frame.setLocation(0, 0);
  background(20);
  rectMode(CENTER);
  textFont = loadFont("AgencyFB-Bold-48.vlw");

  keys = loadStrings("Keys.txt");
  sentences = loadStrings("Sentences.txt");
  users = loadStrings("Users.txt");
  setting = loadStrings("Settings.txt");
  currentUserData = loadStrings(setting[1] + ".txt");
  everySingleUser = new Button[users.length];
  for (int i = 0; i < everySingleUser.length; i++) everySingleUser[i] = new Button(175, 135 + i * 60, 250, 50, users[i]);
  keysOfKeyboard = new Key[keys.length];
  for (int index = 0; index < keysOfKeyboard.length; index++) {
    String[] components = split(keys[index], " ");
    keysOfKeyboard[index] = new Key(PApplet.parseInt(components[1]) + 260, PApplet.parseInt(components[2]) + 460, PApplet.parseInt(components[3]), PApplet.parseInt(components[4]), components[0], components[5], PApplet.parseInt(components[6]));
  }

  switch(setting[0]) {
    case ("easy"): 
    easyModeActive = true; 
    break;
    case ("normal"): 
    normalModeActive = true; 
    break;
    case ("hard"): 
    hardModeActive = true; 
    break;
  }

  keyboard = new Box(width / 2, (3 * 60 + 400), 925, (5 * 60 + 25), "");
  textToWrite = new Box(width / 2, (275 / 2 + 25), 925, 275, "[press a key to start]");
  indicatorsBar = new Box(width / 2, (height - (3 * 60 + 230)), 925, 100, "");

  beatsPerMinute = new Box(width / 2 - 306, height - 433, 298, 40, "BEATS/MINUTE: ");
  charactersToWriteBox = new Box(width / 2 - 306, height - 387, 300, 40, "CHARACTERS TO WRITE: ");
  writtenCharactersBox = new Box(width / 2, height - 387, 300, 40, "WRITTEN CHARACTERS: ");
  time = new Box(width / 2, height - 433, 300, 40, "TIME: "); 
  percentageOfCompletion = new Box(width / 2 + 306, height - 433, 300, 40, "COMPLETION: ");
  percentageOfCorrectText = new Box(width / 2 + 306, height - 387, 300, 40, "CORRECT TEXT:");

  currentMode = new Box(width - 285, 75, 250, 50, "mode: " + setting[0]);
  currentUser = new Box(width - 545, 75, 250, 50, "user: " + setting[1]);

  userNameBox = new Box(width - 160 - (width - 470) / 2, 110 + (height - 160) / 2, 400, 80, "");
  userData = new Box(width - 160 - (width - 470) / 2, 110 + (height - 160) / 2, width - 470, height - 160, currentUserData[0]);

  start = new Button(width / 2, height / 2 - 82, 250, 75, "Start"); 
  settings = new Button(width / 2, height / 2, 250, 75, "Settings"); 
  progress = new Button(width / 2, height / 2 + 82, 250, 75, "Progress"); 

  close = new Button(width - 100, 75, 100, 50, "close"); 
  backToMenu = new Button(width - 100, 135, 100, 50, "menu");
  restartExercise = new Button(width - 100, 195, 100, 50, "restart");

  easyMode = new Button(width / 2, height / 2 - 82, 250, 75, "Easy Mode"); 
  normalMode = new Button(width / 2, height / 2, 250, 75, "Normal Mode"); 
  hardMode = new Button(width / 2, height / 2 + 82, 250, 75, "Hard Mode"); 
  selectText = new Button(width / 2, height / 2 + 164, 250, 75, "Select Text");

  addUser = new Button(175, 50 + 25, 250, 50, "Add User");
  removeUser = new Button(175 + addUser.selfWidth / 2 + 10 + 125, 50 + 25, 250, 50, "Remove User");
}

public void draw() {
  background(20);
  close.show(300);
  closeButtonClicked();
  changeMenuVisibility();
  if (mainMenuOpened && backMenuVisibility == 0) mainMenu();
  if (startMenuOpened && mainMenuVisibility == 0) startMenu();
  if (settingsMenuOpened && mainMenuVisibility == 0) settingsMenu();
  if (progressMenuOpened && mainMenuVisibility == 0) progressMenu();
  if (!mainMenuOpened) {
    backToMenu.show(backMenuVisibility);
    backToMenuButtonClicked();
  }
}
public void mainMenu() { //<>//
  start.show(mainMenuVisibility);
  startButtonClicked();
  settings.show(mainMenuVisibility);
  settingsButtonClicked();
  progress.show(mainMenuVisibility);
  progressButtonClicked();
}

public void startMenu() {
  if (hardModeActive) {
    textToWrite.selfHeight = 580;
    textToWrite.y = 320;
    indicatorsBar.y = height - 100;
  } else {
    keyboard.staticShow(startMenuVisibility);
    textToWrite.selfHeight = 275;
    textToWrite.y = 275 / 2 + 25;
    indicatorsBar.y = height - (3 * 60 + 230);
    keyboard();
  }
  if (exerciseActive) textToWrite.text = "";
  textToWrite.staticShow(startMenuVisibility);
  indicatorsBar.staticShow(startMenuVisibility);
  restartExercise.show(restartExerciseButtonVisibility);
  restartExerciseButtonClicked();
  exercise();
}

public void settingsMenu() {
  easyMode.show(settingsMenuVisibility);
  easyModeButtonClicked();
  normalMode.show(settingsMenuVisibility);
  normalModeButtonClicked();
  hardMode.show(settingsMenuVisibility);
  hardModeButtonClicked();
  selectText.show(settingsMenuVisibility);
}

public void progressMenu() {
  addUser.show(progressMenuVisibility);
  addUserButtonClicked();
  removeUser.show(progressMenuVisibility);
  if (userNameBoxVisibility != 0) userNameBox.staticShow(userNameBoxVisibility); 
  else userData.staticShow(progressMenuVisibility);
  for (int i = 0; i < everySingleUser.length; i++) everySingleUser[i].show(progressMenuVisibility);

  if (userNameWritable) {
    textSize(userNameBox.textSize);
    if (keyPressed && writable) {
      if (key == ENTER) {
        String[] TEST = new String[1];
        TEST[0] = "CREATION Date " + day() + "/" + month() + "/" + year() + "  Hour " + hour() + ":" + minute() + ":" + second();
        saveStrings((userName + ".txt"), TEST);
        users = append(users, userName);
        saveStrings("Users.txt", users);
        everySingleUser = new Button[users.length];
        for (int i = 0; i < everySingleUser.length; i++) everySingleUser[i] = new Button(50 + (250 / 2), 50 + 50 + 10 + 25 + i * 60, 250, 50, users[i]);
        userNameWritable = false;
        userName = "";
        addUser.text = "Add User";
      }
      if (key == BACKSPACE && userName.length() > 0) userName = userName.substring(0, userName.length() - 1);
      else if (key != CODED && key != '.' && key != '?' && textWidth(userNameBox.text) < userNameBox.selfWidth - 60) userName += key; 
      lastKey = key;
      writable = false;
      userNameBox.text = userName;
    }
    if (!writable && ((key != lastKey) || (!keyPressed && key == lastKey))) writable = true;
  } else if (!writable || lastKey != ' ') {
    writable = true;
    lastKey = ' ';
  }

  for (int i = 0; i < everySingleUser.length; i++) {
    if (everySingleUser[i].selfClicked() && progressMenuOpened) {
      currentUser.text = "user: " + everySingleUser[i].text;
      setting[1] = everySingleUser[i].text;
      saveStrings("Settings.txt", setting);
      //currentUserData = loadStrings(everySingleUser[i].text + ".txt");
      //userData.text = currentUserData[0];
    }
  }
}

public void keyboard() { // CHECK LATER boolean function!
  if (startMenuOpened && startMenuVisibility >= 150) {
    for (int i = 0; i < keysOfKeyboard.length; i++) {
      if (keysOfKeyboard[i].text.charAt(0) == unwrittenText.charAt(writtenText.length()) && keysOfKeyboard[i].text.length() == 1 && (keyPressed == false || key == CODED) && exerciseActive) {
        keysOfKeyboard[i].setColors(0, 255, 0);
        keysOfKeyboard[i].staticShow(startMenuVisibility);
      } else {
        int currentLayer = 0;
        if (keysOfKeyboard[i].layer == currentLayer) keysOfKeyboard[i].show(startMenuVisibility);
        if (key != CODED) currentLayer = 1; 
        else if (keyCode == SHIFT && keyPressed) currentLayer = 2; 
        else currentLayer = 1;
        if (keysOfKeyboard[i].layer == currentLayer) keysOfKeyboard[i].show(startMenuVisibility);
        if (keysOfKeyboard[i].layer == currentLayer) keysOfKeyboard[i].show(startMenuVisibility);
      }
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
  }

  if (exerciseActive) {
    textAlign(LEFT, CENTER);
    textSize(25);
    if (keyPressed && key != '\t' && key != CODED && writable) {
      writtenText += key;
      if (key == unwrittenText.charAt(writtenText.length() - 1)) {
        correctText += key;
        wrongText += '░';
      } else {
        correctText += '░';
        wrongText += key;
      }
      lastKey = key;
      writable = false;
      String substitute = unwrittenText;
      unwrittenText = " ";
      for (int i = 1; i < writtenText.length(); i++) unwrittenText += ' ';          
      if (writtenText.length() < substitute.length()) unwrittenText += substitute.substring(writtenText.length());
      beats++;
    }
    if (!writable && ((key != lastKey) || (!keyPressed && key == lastKey))) writable = true;

    matrix = assignText(unwrittenText);
    display(color(/*200, 200, 200,*/100, 100, 100, startMenuVisibility), matrix, MAX_ROWS, MAX_COLUMNS, 249, 65);
    if (easyModeActive) {     
      matrix = assignText(correctText);
      display(color(0, 255, 0, startMenuVisibility), matrix, MAX_ROWS, MAX_COLUMNS, 249, 65);
      matrix = assignText(wrongText);
      display(color(255, 0, 0, startMenuVisibility), matrix, MAX_ROWS, MAX_COLUMNS, 249, 65);
    } else {
      matrix = assignText(writtenText);
      display(color(/*0, 0, 0,*/255, 255, 255, startMenuVisibility), matrix, MAX_ROWS, MAX_COLUMNS, 249, 65);
    }
    textAlign(CENTER, CENTER);

    indicators();

    if (writtenText.length() >= unwrittenText.length() && exerciseActive) {
      exerciseActive = false;
      exerciseActivable = false;

      String[] ses = loadStrings(currentUser.text.substring(6) + ".txt");
      ses = append(ses, "Date " + day() + "/" + month() + "/" + year() + "  Hour " + hour() + ":" + minute() + ":" + second() + " " + textToWrite.text);
      saveStrings(currentUser.text.substring(6) + ".txt", ses);
      textToWrite.text += " \n[EXERCISE IS OVER, GOOD JOB!]";
      textToWrite.staticShow(300);
      unwrittenText = sentences[PApplet.parseInt(random(0, sentences.length - 1))];
      writtenText = "";
      correctText = "";
      wrongText = "";
    }
  }
}

public void indicators() {  
  frame++;
  if (frame >= PApplet.parseInt(frameRate) || second == 0) {
    second++;
    frame = 0;
  }

  if (hardModeActive) {
    beatsPerMinute.setCoordinates(width / 2 - 306, height - 123);
    charactersToWriteBox.setCoordinates(width / 2 - 306, height - 77);
    writtenCharactersBox.setCoordinates(width / 2, height - 77);
    time.setCoordinates(width / 2, height - 123);
    percentageOfCompletion.setCoordinates(width / 2 + 306, height - 123);
    percentageOfCorrectText.setCoordinates(width / 2 + 306, height - 77);
  } else {
    beatsPerMinute.setCoordinates(width / 2 - 306, height - 433);
    charactersToWriteBox.setCoordinates(width / 2 - 306, height - 387);
    writtenCharactersBox.setCoordinates(width / 2, height - 387);
    time.setCoordinates(width / 2, height - 433);
    percentageOfCompletion.setCoordinates(width / 2 + 306, height - 433);
    percentageOfCorrectText.setCoordinates(width / 2 + 306, height - 387);
  }

  int charactersToWrite = unwrittenText.length(), writtenCharacters = writtenText.length(), correctCharacters = 0;
  for (int i = 0; i < writtenText.length(); i++) if (correctText.charAt(i) != '░') correctCharacters++;

  if (writtenCharacters == 0) writtenCharacters = 1;
  beatsPerMinute.text = "BEATS/MINUTE: " + PApplet.parseInt(beats * 60 / second);
  percentageOfCompletion.text = "COMPLETION: " + PApplet.parseInt((writtenCharacters * 100) / charactersToWrite) + "%";
  percentageOfCorrectText.text = "CORRECT TEXT: " + PApplet.parseInt((correctCharacters * 100) / writtenCharacters) + "%";
  writtenCharactersBox.text = "WRITTEN CHARACTERS: " + writtenCharacters;
  charactersToWriteBox.text = "CHARACTERS TO WRITE: " + charactersToWrite;
  time.text = "TIME: " + second; 

  textToWrite.text = beatsPerMinute.text + " \n" + writtenCharactersBox.text + " \n" + time.text + " \n" + percentageOfCorrectText.text;

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
    if (index < text.length()) array[row][column] = text.charAt(index);
    else array[row][column] = '░';
    if (column == MAX_COLUMNS - 1 && row < MAX_ROWS - 1) {
      row++;
      column = -1;
    }
    index++;
  }
  return array;
}

public void display(int textFill, char text[][], int rows, int columns, int x, int y) {
  fill(textFill);
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      if (text[i][j] != '░') {
        text(matrix[i][j], x + j * 10, y + i * 27);
      }
    }
  }
}

public void resetText() {
  textToWrite.text = "[press a key to start]";
  unwrittenText = sentences[PApplet.parseInt(random(0, sentences.length - 1))];
  writtenText = "";
  correctText = "";
  wrongText = "";
  beats = 0;
}

public void changeMenuVisibility() { // Function switching from a menu to another
  if (mainMenuOpened && mainMenuVisibility != 300 && backMenuVisibility == 0) {
    mainMenuVisibility += transitionSpeed;
  } else if (!mainMenuOpened && mainMenuVisibility != 0 && backMenuVisibility == 0) {
    mainMenuVisibility -= transitionSpeed;
  } else if (!mainMenuOpened && backMenuOpened && mainMenuVisibility == 0 && backMenuVisibility != 300) {
    backMenuVisibility += transitionSpeed;
    if (settingsMenuOpened && settingsMenuVisibility != 300) settingsMenuVisibility += transitionSpeed;
    else if (startMenuOpened && startMenuVisibility != 300) startMenuVisibility += transitionSpeed;
    else if (progressMenuOpened && progressMenuVisibility != 300) progressMenuVisibility += transitionSpeed;
    else if (exerciseActive && restartExerciseButtonVisibility != 300) restartExerciseButtonVisibility += transitionSpeed;
  } else if (mainMenuOpened && mainMenuVisibility == 0 && backMenuVisibility != 0) {
    backMenuVisibility -= transitionSpeed;
    if (!settingsMenuOpened && settingsMenuVisibility != 0) settingsMenuVisibility -= transitionSpeed;    
    if (!startMenuOpened && startMenuVisibility != 0) startMenuVisibility -= transitionSpeed;
    if (!progressMenuOpened && progressMenuVisibility != 0) progressMenuVisibility -= transitionSpeed;
    if (!exerciseActive && restartExerciseButtonVisibility != 0) restartExerciseButtonVisibility -= transitionSpeed;
  }
  if (userNameWritable && userNameBoxVisibility != 300) userNameBoxVisibility += transitionSpeed;
  else if (!userNameWritable && userNameBoxVisibility != 0) userNameBoxVisibility -= transitionSpeed;
  if ((exerciseActive || (!exerciseActive && !exerciseActivable)) && restartExerciseButtonVisibility != 300) restartExerciseButtonVisibility += transitionSpeed;
  else if (!exerciseActive && restartExerciseButtonVisibility != 0) restartExerciseButtonVisibility -= transitionSpeed;
  if (((!mainMenuOpened && settingsMenuOpened || progressMenuOpened) || (mainMenuOpened && !settingsMenuOpened && !progressMenuOpened)) && startMenuVisibility == 0) {
    currentMode.staticShow(300);
    currentUser.staticShow(300);
  } else {
    currentMode.staticShow(mainMenuVisibility + settingsMenuVisibility + progressMenuVisibility);
    currentUser.staticShow(mainMenuVisibility + settingsMenuVisibility + progressMenuVisibility);
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
    setColors(/*50, #E3E3E3, 20*/255, 0, 255);
    this.text = text;
    edgeRoundness = 5;
    textSize = 30;
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
  }

  public void show(int transparency) {
    changeDynamicColors();
    staticShow(transparency);
  }

  public void changeDynamicColors() {
    if (mouseInside()) 
      if (selfClicked()) setColors(255, 255, 0);
      else setColors(0, 255, 0);
    else setColors(255, 0, 255);
  }

  public boolean mouseInside() {
    if ((mouseX < x + selfWidth / 2 && mouseX > x - selfWidth / 2) && (mouseY < y + selfHeight / 2 && mouseY > y - selfHeight / 2)) return true;
    else return false;
  }

  public boolean selfClicked() {
    if (mouseInside() && mousePressed) return true;
    else return false;
  }
}
public void closeButtonClicked() {
  if (close.selfClicked()) exit();
}

public void startButtonClicked() {
  if (start.selfClicked() && mainMenuOpened) {
    mainMenuOpened = false;
    settingsMenuOpened = false;
    backMenuOpened = true;
    startMenuOpened = true;
    progressMenuOpened = false;
    resetText();
    exerciseActivable = true;
    exerciseActive = false;
  }
}

public void settingsButtonClicked() {
  if (settings.selfClicked() && mainMenuOpened) {
    mainMenuOpened = false;
    settingsMenuOpened = true;
    backMenuOpened = true;
    startMenuOpened = false;
    progressMenuOpened = false;
  }
}

public void progressButtonClicked() {
  if (progress.selfClicked() && mainMenuOpened) {
    mainMenuOpened = false;
    settingsMenuOpened = false;
    backMenuOpened = true;
    startMenuOpened = false;
    progressMenuOpened = true;
  }
}

public void backToMenuButtonClicked() {
  if (backToMenu.selfClicked() && !mainMenuOpened) {
    mainMenuOpened = true;
    settingsMenuOpened = false;
    backMenuOpened = false;
    startMenuOpened = false;
    progressMenuOpened = false;
    userNameWritable = false;
  }
}

public void addUserButtonClicked() {
  if (addUser.selfClicked() && progressMenuOpened && everySingleUser.length < 11) {
    if (!userNameWritable) { 
      userNameWritable = true;
      addUser.text = "close";
    } else if (userNameWritable) { 
      userNameWritable = false;
      addUser.text = "Add User";
    }
    userName = "";
    userNameBox.text = userName;
    delay(100);
  }
}

public void restartExerciseButtonClicked() {
  if (restartExercise.selfClicked() && (exerciseActive || (!exerciseActive && !exerciseActivable))) {
    exerciseActivable = true;
    exerciseActive = false;
    frame = 0;
    second = 0;
    resetText();
  }
}

public void easyModeButtonClicked() {
  if (easyMode.selfClicked() && settingsMenuVisibility == 300) {
    easyModeActive = true;
    normalModeActive = false;
    hardModeActive = false;
    setting[0] = "easy";
    currentMode.text = "mode: " + setting[0];
    saveStrings("Settings.txt", setting);
  }
}

public void normalModeButtonClicked() {
  if (normalMode.selfClicked() && settingsMenuVisibility == 300) {
    easyModeActive = false;
    normalModeActive = true;
    hardModeActive = false;
    setting[0] = "normal";
    currentMode.text = "mode: " + setting[0];
    saveStrings("Settings.txt", setting);
  }
}

public void hardModeButtonClicked() {
  if (hardMode.selfClicked() && settingsMenuVisibility == 300) {
    easyModeActive = false;
    normalModeActive = false;
    hardModeActive = true;
    setting[0] = "hard";
    currentMode.text = "mode: " + setting[0];
    saveStrings("Settings.txt", setting);
  }
}
class Key extends Box {
  String finger;
  int layer;

  Key(int x, int y, int w, int h, String text, String finger, int layer) {
    super(x, y, w, h, text);
    if (textSize != 1) textSize = selfWidth / text.length() / 2 + 10;
    this.finger = finger;
    this.layer = layer;
  }

  public void show(int transparency) {
    changeDynamicColors();
    staticShow(transparency);
  }

  public void changeDynamicColors() { // CHECK LATER
    if (easyModeActive) {
      switch (finger) {
      case "thumb": 
        setColors(100, 0xffD0D0D0, 90);
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
      setColors(255, 0, 255);
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
