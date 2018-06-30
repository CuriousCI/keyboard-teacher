Button start; //<>//
Button settings;
Button progress;

Button close;
Button backToMenu;

Button easyMode;
Button normalMode;
Button hardMode;

Key[] p = new Key[60];

boolean mainMenuOpened = true, settingsMenuOpened = false, backMenuOpened = false, startMenuOpened = false;
int mainMenuVisibility = 0, backMenuVisibility = 0, settingsMenuVisibility = 0, transitionSpeed = 30; 

void mainMenu() {
  start.show(mainMenuVisibility, start.changeDynamicColors());
  startButton();

  settings.y =  height/2;
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
  settings.y =  height/2-200;
  settings.show(settingsMenuVisibility, settings.changeDynamicColors());
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

void changeVisibility() {
  if (mainMenuOpened && mainMenuVisibility != 300 && backMenuVisibility == 0) {
    mainMenuVisibility += transitionSpeed;
  } else if (!mainMenuOpened && mainMenuVisibility != 0 && backMenuVisibility == 0) {
    mainMenuVisibility -= transitionSpeed;
  } else if (!mainMenuOpened && mainMenuVisibility == 0 && backMenuVisibility != 300) {
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

  int a = 60, x = 0, z = 120;
  for (int i = 0; i < 60; i++) {
    if (x < width-200) {
      x += 60;
      if (z < height-100 && x >= width-210) {
        z += 60;
      }
    } else {
      x = 50;
    }
    a++;
    p[i] = new Key(x, z, 50, 50, str(char(a)));
    p[i].setDynamicColors(200, 100, 150, 50, 150, 200, 150, 200, 50);
  }
}

void draw() {
  background(#ADF6FF);

  close.show(300, close.changeDynamicColors());
  closeButton();

  changeVisibility();

  if (startMenuOpened && mainMenuVisibility == 0) {
    for (int i = 0; i < 60; i++) {
      p[i].show(300, p[i].changeDynamicColors());
    }
  }

  mainMenu();
  backMenu();
  settingsMenu();
}
