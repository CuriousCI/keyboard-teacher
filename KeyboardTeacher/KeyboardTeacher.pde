Button start;
Button settings;
Button progress;
Button close;
Button backToMenu;

boolean menuOpened = true;
int i = 200, j = 0; 

void mainMenu() {
  start.dinamicColorChange(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF, i);
  start.show();
  startButton();

  settings.dinamicColorChange(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF, i);
  settings.show();
  settingsButton();

  progress.dinamicColorChange(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF, i);
  progress.show();
  progressButton();
}

void backMenu() {
  backToMenu.dinamicColorChange(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF, j);
  backToMenu.show();
  backToMenuButton();
}

void closeButton() {
  if (close.buttonClicked()) {
    delay(100);
    exit();
  }
}
void startButton() {
  if (start.buttonClicked()) {
    delay(100);
    menuOpened = false;
  }
}
void settingsButton() {
  if (settings.buttonClicked()) {
    delay(100);
    menuOpened = false;
  }
}
void progressButton() {
  if (progress.buttonClicked()) {
    delay(100);
    menuOpened = false;
  }
}
void backToMenuButton() {
  if (backToMenu.buttonClicked()) {
    delay(100);
    menuOpened = true;
  }
}


void setup() {
  fullScreen (); //size(displayWidth, displayHeight); frame.setLocation(0, 0);

  start = new Button(width/2, height/2-82, 250, 75, "Start"); 
  settings = new Button(width/2, height/2, 250, 75, "Settings"); 
  progress = new Button(width/2, height/2+82, 250, 75, "Progress"); 
  close = new Button(width-100, 50, 100, 50, "close"); 
  backToMenu = new Button(width-206, 50, 100, 50, "menu");
}

void draw() {
  background(#ADF6FF);

  //--CLOSE BUTTON--//
  close.dinamicColorChange(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF, 200);
  close.show();
  closeButton();
  //--CLOSE BUTTON--//

  //--MENU'S BEHAVIOR--//
  if (menuOpened && i == 200) {
    mainMenu();
  } else if (i != 0 && !menuOpened) {
    i -= 10;
    j += 10;
    mainMenu();
    backMenu();
  }

  if (j == 200 && !menuOpened) {
    backMenu();
  } else if (j != 0 && menuOpened) {
    i += 10;
    j -= 10;
    mainMenu();
    backMenu();
  }
  //--MENU'S BEHAVIOR--//
}
