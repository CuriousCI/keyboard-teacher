Button start; //<>//
Button settings;
Button progress;

Button close;
Button backToMenu;

Button easyMode;
Button normalMode;
Button hardMode;

boolean mainMenuOpened = true, settingsMenuOpened = false, backMenuOpened = false;
int mainMenuVisibility = 0, backMenuVisibility = 0, settingsMenuVisibility = 0, transitionSpeed = 30; 

void mainMenu() {
  start.show(mainMenuVisibility);
  startButton();

  settings.y =  height/2;
  settings.show(mainMenuVisibility);
  settingsButton();

  progress.show(mainMenuVisibility);
  progressButton();
}

void backMenu() {
  backToMenu.show(backMenuVisibility);
  backToMenuButton();
}

void settingsMenu() {
  settings.y =  height/2-200;
  settings.show(settingsMenuVisibility);
  easyMode.show(settingsMenuVisibility);
  normalMode.show(settingsMenuVisibility);
  hardMode.show(settingsMenuVisibility);
}

void closeButton() {
  if (close.selfClicked()) {
    delay(100);
    exit();
  }
}
void startButton() {
  if (start.selfClicked()) {
    delay(100);
    mainMenuOpened = false;
    settingsMenuOpened = false;
    backMenuOpened = true;
  }
}
void settingsButton() {
  if (settings.selfClicked()) {
    delay(100);
    mainMenuOpened = false;
    settingsMenuOpened = true;
    backMenuOpened = true;
  }
}
void progressButton() {
  if (progress.selfClicked()) {
    delay(100);
    mainMenuOpened = false;
    settingsMenuOpened = false;
    backMenuOpened = true;
  }
}
void backToMenuButton() {
  if (backToMenu.selfClicked()) {
    delay(100);
    mainMenuOpened = true;
    settingsMenuOpened = false;
    backMenuOpened = false;
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
}

void draw() {
  background(#ADF6FF);

  close.show(300);
  closeButton();

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

  mainMenu();
  backMenu();
  settingsMenu();
}
