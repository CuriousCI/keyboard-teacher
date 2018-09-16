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

void setup() {
  fullScreen (); //size(1000, 700); //frame.setLocation(0, 0);
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
    keysOfKeyboard[index] = new Key(int(components[1]) + 260, int(components[2]) + 460, int(components[3]), int(components[4]), components[0], components[5], int(components[6]));
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

void draw() {
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
