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

void mainMenu() {
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

void backMenu() {
  backToMenu.show(backMenuVisibility, backToMenu.changeDynamicColors());
  backToMenuButton();
}

void settingsMenu() {
  settings.x = width/2;
  settings.y =  height/2-200;
  settings.selfWidth = 300;
  settings.selfHeight = 90;

  settings.show(settingsMenuVisibility, /*settings.changeDynamicColors()*/ 0);
  easyMode.show(settingsMenuVisibility, easyMode.changeDynamicColors());
  normalMode.show(settingsMenuVisibility, normalMode.changeDynamicColors());
  hardMode.show(settingsMenuVisibility, hardMode.changeDynamicColors());
}

void startMenu() {
  keyboard.show(startMenuVisibility, 1);
  textToWrite.show(startMenuVisibility, 1);
  indicators.show(startMenuVisibility, 1);

  keyboard();
}

void keyboard() {
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

void closeButton() {
  if (close.selfClicked(true)) {
    delay(100);
    exit();
  }
}

void startButton() {
  if (start.selfClicked(mainMenuOpened)) {
    delay(100);
    mainMenuOpened = false;
    settingsMenuOpened = false;
    backMenuOpened = true;
    startMenuOpened = true;
  }
}

void settingsButton() {
  if (settings.selfClicked(mainMenuOpened)) {
    delay(100);
    mainMenuOpened = false;
    settingsMenuOpened = true;
    backMenuOpened = true;
    startMenuOpened = false;
  }
}

void progressButton() {
  if (progress.selfClicked(mainMenuOpened)) {
    delay(100);
    mainMenuOpened = false;
    settingsMenuOpened = false;
    backMenuOpened = true;
    startMenuOpened = false;
  }
}

void backToMenuButton() {
  if (backToMenu.selfClicked(!mainMenuOpened)) {
    delay(100);
    mainMenuOpened = true;
    settingsMenuOpened = false;
    backMenuOpened = false;
    startMenuOpened = false;
  }
}

void changeMenuVisibility() { // Function switching from a menu to another
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

void setup() {
  fullScreen (); //size(displayWidth, displayHeight); frame.setLocation(0, 0);
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
    int keyX = int(keys[index].substring(spaceOne + 1, spaceTwo)) * 60 + (width - 60 * 16) / 2, 
      keyY = int(keys[index].substring(spaceTwo + 1, keys[index].length() - 1)) * 60 + 400;
    String keyText = keys[index].substring(0, spaceOne);

    keysOfKeyboard[index] = new Key(keyX, keyY, 50, 50, keyText);
  }
}

void draw() {
  background(#ADF6FF);

  close.show(300, close.changeDynamicColors());
  closeButton();

  changeMenuVisibility();

  mainMenu();
  backMenu();
  settingsMenu();
  startMenu();
}
