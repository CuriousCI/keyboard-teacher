Button start;
Button settings;
Button progress;
Button close;
Button backToMenu;

boolean menuOpen = true;
int i = 200, j = 0;

void menu() {
  start.DinColor(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF, i);
  start.show();
  Start();

  settings.DinColor(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF, i);
  settings.show();
  Settings();

  progress.DinColor(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF, i);
  progress.show();
  Progress();
}

void bMenu() {
  backToMenu.DinColor(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF, j);
  backToMenu.show();
  BackToMenu();
}

void Close() {
  if (close.Clicked()) {
    delay(100);
    exit();
  }
}

void Start() {
  if (start.Clicked()) {
    delay(100);
    menuOpen = false;
  }
}

void Settings() {
  if (settings.Clicked()) {
    delay(100);
    menuOpen = false;
  }
}

void Progress() {
  if (progress.Clicked()) {
    delay(100);
    menuOpen = false;
  }
}

void BackToMenu() {
  if (backToMenu.Clicked()) {
    delay(100);
    menuOpen = true;
  }
}

void setup() {
  fullScreen ();
  //size(displayWidth, displayHeight);
  //frame.setLocation(0, 0);

  start = new Button(width/2, height/2-82, 250, 75, "Start");
  settings = new Button(width/2, height/2, 250, 75, "Settings");
  progress = new Button(width/2, height/2+82, 250, 75, "Progress");
  close = new Button(width-100, 50, 100, 50, "close");
  backToMenu = new Button(width-206, 50, 100, 50, "menu");
}

void draw() {
  background(#ADF6FF);

  close.DinColor(color(255, 255, 255), #C8C8C8, #FFFFFF, #FF0000, #FF6405, #F0F000, #0021F0, #0021F0, #F021FF, 200);
  close.show();
  Close();

  if (menuOpen && i == 200) {
    menu();
  } else if (i != 0 && !menuOpen) {
    i -= 10;
    j += 10;
    menu();
    bMenu();
  }

  if (j == 200 && !menuOpen) {
    bMenu();
  } else if (j != 0 && menuOpen) {
    i += 10;
    j -= 10;
    menu();
    bMenu();
  }

  //ellipse(width/2, height/2, 50, 50);
}
