PFont textFont; //<>//

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

Button start;
Button settings;
Button progress;

Button close;
Button backToMenu;
Button restartExercise; 

Button easyMode;
Button normalMode;
Button hardMode;

Button addUser;
//Button selectUser;

Button[] everySingleUser;

Key[] keysOfKeyboard/* = new Key[117]*/;

boolean mainMenuOpened = true, settingsMenuOpened = false, startMenuOpened = false, progressMenuOpened = false, backMenuOpened = false, 
  easyModeActive = false, normalModeActive = false, hardModeActive = false, exerciseActive = false, exerciseActivable = true, 
  userNameWritable = false; 
int mainMenuVisibility = 0, startMenuVisibility = 0, settingsMenuVisibility = 0, progressMenuVisibility = 0, backMenuVisibility = 0, 
  restartExerciseButtonVisibility = 0, userNameBoxVisibility = 0, transitionSpeed = 30, 
  frame = 0, second = 0, beats = 0, MAX_ROWS = 20, MAX_COLUMNS = 87;
String unwrittenText, wrongText, correctText, writtenText, userName = "";
String[] keys, sentences, users, setting;
char[][] matrix = new char[MAX_ROWS][MAX_COLUMNS];

void setup() {
  fullScreen (); //size(600, 600); //frame.setLocation(0, 0);
  background(#ADF6FF);
  rectMode(CENTER);
  textFont = loadFont("AgencyFB-Bold-48.vlw");
  textAlign(CENTER, CENTER);

  keys = loadStrings("Keys.txt");
  sentences = loadStrings("Sentences.txt");
  users = loadStrings("Users.txt");
  setting = loadStrings("Settings.txt");

  keysOfKeyboard = new Key[keys.length];
  everySingleUser = new Button[users.length];
  for (int i = 0; i < everySingleUser.length; i++) {
    everySingleUser[i] = new Button(165, 150 + i * 60, 200, 50, users[i]);
    everySingleUser[i].edgeRoundness = 7;
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
  time.textSize /= 2;
  percentageOfCompletion = new Box(width / 2 + 306, height - 433, 300, 40, "COMPLETION: ");
  percentageOfCorrectText = new Box(width / 2 + 306, height - 387, 300, 40, "CORRECT TEXT:");

  currentMode = new Box(width / 2, height / 2 + 164, 250, 50, "");
  currentUser = new Box(width / 2, height / 2 + 218, 250, 50, "current user: " + setting[1]);

  userNameBox = new Box(width / 2, height / 2, 300, 50, "");
  userNameBox.textSize = 10;

  start = new Button(width / 2, height / 2 - 82, 250, 75, "Start"); 
  settings = new Button(width / 2, height / 2, 250, 75, "Settings"); 
  progress = new Button(width / 2, height / 2 + 82, 250, 75, "Progress"); 

  close = new Button(width - 100, 50, 100, 50, "close"); 
  backToMenu = new Button(width - 100, 110, 100, 50, "menu");
  restartExercise = new Button(width - 100, 170, 100, 50, "restart");

  easyMode = new Button(width / 2, height / 2 - 82, 250, 75, "EasyMode"); 
  normalMode = new Button(width / 2, height / 2, 250, 75, "NormalMode"); 
  hardMode = new Button(width / 2, height / 2 + 82, 250, 75, "HardMode"); 

  addUser = new Button(165, 50, 220, 50, "Add User");
  addUser.edgeRoundness = 7;
  //selectUser = new Button(395, 50, 220, 50, "Select User");
  //selectUser.edgeRoundness = 7;

  for (int index = 0; index < keysOfKeyboard.length; index++) {
    String[] components = split(keys[index], " ");
    int keyX = int (components[1]) * 60 + (width - 60 * 16) / 2, 
      keyY = int (components[2]) * 60 + 400;
    String keyText = components[0]; 

    keysOfKeyboard[index] = new Key(keyX, keyY, 50, 50, keyText);
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

  if (!startMenuOpened) currentData();
  if (!mainMenuOpened) backMenu();
}
