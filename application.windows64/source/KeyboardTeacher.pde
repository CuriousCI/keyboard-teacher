Button start;
Button settings;
Button progress;

Button close;
Button backToMenu;

Button easyMode;
Button normalMode;
Button hardMode;

Key[] keysOfKeyboard = new Key[116];

boolean mainMenuOpened = true, settingsMenuOpened = false, backMenuOpened = false, startMenuOpened = false;
int mainMenuVisibility = 0, backMenuVisibility = 0, settingsMenuVisibility = 0, transitionSpeed = 30; 

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

  settings.show(settingsMenuVisibility, /*settings.changeDynamicColors()*/ 2);
  easyMode.show(settingsMenuVisibility, easyMode.changeDynamicColors());
  normalMode.show(settingsMenuVisibility, normalMode.changeDynamicColors());
  hardMode.show(settingsMenuVisibility, hardMode.changeDynamicColors());
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
    }
  } else if (mainMenuOpened && mainMenuVisibility == 0 && backMenuVisibility != 0) {
    backMenuVisibility -= transitionSpeed;
    if (!settingsMenuOpened && settingsMenuVisibility != 0) {
      settingsMenuVisibility -= transitionSpeed;
    }
  }
}

void setup() {
  fullScreen (); //size(displayWidth, displayHeight); frame.setLocation(0, 0);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);

  start = new Button(width/2, height/2-82, 250, 75, "Start"); 
  start.setDynamicColors(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF);
  settings = new Button(width/2, height/2, 250, 75, "Settings"); 
  settings.setDynamicColors(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF);
  progress = new Button(width/2, height/2+82, 250, 75, "Progress"); 
  progress.setDynamicColors(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF);

  close = new Button(width-100, 50, 100, 50, "close"); 
  close.setDynamicColors(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF);
  backToMenu = new Button(width-206, 50, 100, 50, "menu");
  backToMenu.setDynamicColors(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF);

  easyMode = new Button(width/2, height/2-82, 250, 75, "EasyMode"); 
  easyMode.setDynamicColors(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF);
  normalMode = new Button(width/2, height/2, 250, 75, "NormalMode"); 
  normalMode.setDynamicColors(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF);
  hardMode = new Button(width/2, height/2+82, 250, 75, "HardMode"); 
  hardMode.setDynamicColors(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF);

  String[] keys = loadStrings("Keys.txt");

  for (int i = 0; i < 116; i++) {
    int spaceOne = keys[i].indexOf(" ");
    int spaceTwo = keys[i].indexOf(" ", spaceOne + 1);
    int keyX = int(keys[i].substring(spaceOne + 1, spaceTwo)) * 70 + (width - 70 * 16) / 2, 
      keyY = int(keys[i].substring(spaceTwo + 1, keys[i].length() - 1)) * 50 + 450;
    String keyText = keys[i].substring(0, spaceOne);

    keysOfKeyboard[i] = new Key(keyX, keyY, 60, 40, keyText);
    keysOfKeyboard[i].setDynamicColors(255, 200, 230, 100, 150, 90, 0, 20, 50);
  }
}

void draw() {
  background(#ADF6FF);

  close.show(300, close.changeDynamicColors());
  closeButton();

  changeMenuVisibility();
  
  if (startMenuOpened && mainMenuVisibility == 0) {
    if (false) {
      for (int i = 0; i < 116; i++) {
        keysOfKeyboard[i].show(300, keysOfKeyboard[i].changeDynamicColors());
      }
    } else {
      for (int i = 115; i >= 0; i--) {
        keysOfKeyboard[i].show(300, keysOfKeyboard[i].changeDynamicColors());
      }
    }
  }

  mainMenu();
  backMenu();
  settingsMenu();
}
