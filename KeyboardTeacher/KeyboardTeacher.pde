Box keyboard; //<>//
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

Button addUser;
Button selectUser;

Key[] keysOfKeyboard = new Key[117];

boolean mainMenuOpened = true, settingsMenuOpened = false, startMenuOpened = false, progressMenuOpened = false, backMenuOpened = false, 
  easyModeActive = false, normalModeActive = false, hardModeActive = true; 
int mainMenuVisibility = 0, startMenuVisibility = 0, settingsMenuVisibility = 0, progressMenuVisibility = 0, backMenuVisibility = 0, transitionSpeed = 30; 

void setup() {
  fullScreen (); //size(displayWidth, displayHeight); frame.setLocation(0, 0);
  rectMode(CENTER);

  keyboard = new Box(width / 2, (3 * 60 + 400), (15 * 60 + 25), (5 * 60 + 25), "");
  keyboard.edgeRoundness = 10;
  textToWrite = new Box(width / 2, (275 / 2 + 25), (15 * 60 + 25), 275, "Hi this is a test!!!");
  textToWrite.edgeRoundness = 10;
  textToWrite.textPosition = LEFT;
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

  addUser = new Button(width - 215, 50, 110, 50, "Add User");
  selectUser = new Button(width- 215, 110, 110, 50, "Select User");

  String[] keys = loadStrings("Keys.txt");

  for (int index = 0; index < 117; index++) {

    int spaceOne = keys[index].indexOf(" ");
    int spaceTwo = keys[index].indexOf(" ", spaceOne + 1);
    int keyX = int ( float(keys[index].substring(spaceOne + 1, spaceTwo)) * 60 + (width - 60 * 16) / 2 ), 
      keyY = int ( float(keys[index].substring(spaceTwo + 1, keys[index].length() - 1)) * 60 + 400 );
    String keyText = keys[index].substring(0, spaceOne); 

    boolean alphanumeric = true; 
    int keyTextASCII = 0;
    if (keyText.length() == 1) {
      keyTextASCII = int(keyText.charAt(0));
    } else {
      keyTextASCII = 0;
    }
    if (keyTextASCII >= int('0') && keyTextASCII <= int('9') || (keyTextASCII >= int('a') && keyTextASCII <= int('z'))) {
      alphanumeric = true;
    } else {
      alphanumeric = false;
    }
    if (alphanumeric && keyText.length() == 1) {
      keysOfKeyboard[index] = new Key(keyX, keyY, 50, 50, keyText);
    } else {
      keysOfKeyboard[index] = new Key(0, 0, 0, 0, " ");
    }
  }
}

void draw() {
  background(#ADF6FF);

  close.show(300, close.changeDynamicColors());
  closeButtonClicked();

  changeMenuVisibility();

  mainMenu();
  backMenu();
  settingsMenu();
  startMenu();
  progressMenu();
}
