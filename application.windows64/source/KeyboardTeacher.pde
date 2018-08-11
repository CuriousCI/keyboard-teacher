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


void setup() {
  fullScreen (); //size(displayWidth, displayHeight); frame.setLocation(0, 0);
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
    int keyX = int ( float(keys[index].substring(spaceOne + 1, spaceTwo)) * 60 + (width - 60 * 16) / 2 ), 
      keyY = int ( float(keys[index].substring(spaceTwo + 1, keys[index].length() - 1)) * 60 + 400 );
    String keyText = keys[index].substring(0, spaceOne); 

    int keyTextASCII = 0;
    if (keyText.length() == 1) {
      keyTextASCII = int(keyText.charAt(0));
    } else {
      keyTextASCII = 0;
    }
    if (keyTextASCII >= int('0') && keyTextASCII <= int('9') || (keyTextASCII >= int('a') && keyTextASCII <= int('z')) && keyText.length() == 1) {
      keysOfKeyboard[index] = new Key(keyX, keyY, 50, 50, keyText);
    } else {
      keysOfKeyboard[index] = new Key(keyX, keyY, 50, 50, "");
    }
  }
}

void draw() {
  background(#ADF6FF);

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
