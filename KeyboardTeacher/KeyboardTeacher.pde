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
  userNameWritable = false; 
int mainMenuVisibility = 0, startMenuVisibility = 0, settingsMenuVisibility = 0, progressMenuVisibility = 0, backMenuVisibility = 0, 
  restartExerciseButtonVisibility = 0, userNameBoxVisibility = 0, transitionSpeed = 30, 
  frame = 0, second = 0, minute = 0, beats = 0, MAX_ROWS = 20, MAX_COLUMNS = 87;
String unwrittenText, wrongText, correctText, writtenText, userName = "";
String[] keys, sentences, users, setting;
char[][] matrix = new char[MAX_ROWS][MAX_COLUMNS];

void setup() {
  fullScreen (); //size(1000, 700); //frame.setLocation(0, 0);
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
    everySingleUser[i] = new Button(165, 150 + i * 60, 250, 50, users[i]);
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
  currentMode.setColors(#0021F0, #0021F0, #F021FF);
  currentUser = new Box(width / 2, height / 2 + 218, 250, 50, "user: " + setting[1]);
  currentUser.setColors(#0021F0, #0021F0, #F021FF);

  userNameBox = new Box(width / 2, height / 2, 400, 80, "");
  userNameBox.textSize = 30;
  userNameBox.setColors(#0021F0, #0021F0, #F021FF);
  userData = new Box(165 + 250, 150 + 250, 500, 500, "");

  start = new Button(width / 2, height / 2 - 82, 250, 75, "Start"); 
  settings = new Button(width / 2, height / 2, 250, 75, "Settings"); 
  progress = new Button(width / 2, height / 2 + 82, 250, 75, "Progress"); 

  close = new Button(width - 100, 75, 100, 50, "close"); 
  backToMenu = new Button(width - 100, 50 + close.selfHeight + 10 + 25, 100, 50, "menu");
  restartExercise = new Button(width - 100, 50 + close.selfHeight + 10 + backToMenu.selfHeight + 10 + 25, 100, 50, "restart");

  easyMode = new Button(width / 2, height / 2 - 82, 250, 75, "Easy Mode"); 
  normalMode = new Button(width / 2, height / 2, 250, 75, "Normal Mode"); 
  hardMode = new Button(width / 2, height / 2 + 82, 250, 75, "Hard Mode"); 
  selectText = new Button(width / 2, height / 2 + 82 + 82, 250, 75, "Select Text");

  addUser = new Button(165, 75, 250, 50, "Add User");
  addUser.edgeRoundness = 7;
  removeUser = new Button(165 + addUser.selfWidth / 2 + 10 + 125, 75, 250, 50, "Remove User");
  removeUser.edgeRoundness = 7;

  for (int index = 0; index < keysOfKeyboard.length; index++) {
    String[] components = split(keys[index], " ");
    float keyX = float (components[1]), 
      keyY = float (components[2]), 
      keyWidth = float (components[3]), 
      keyHeight = float (components[4]), 
      keyLayer = float (components[6]);
    String keyText = components[0], keyFinger = components[5]; 
    keysOfKeyboard[index] = new Key(int(keyX * 2 * 30 + 200), int(keyY * (keyHeight + 10) + 400), int(keyWidth), int(keyHeight), keyText, keyFinger, int(keyLayer));
  }
}

void draw() {
  background(#ADF6FF);

  close.show(300);
  closeButtonClicked();

  changeMenuVisibility();

  if (mainMenuOpened && backMenuVisibility == 0) mainMenu();
  if (startMenuOpened && mainMenuVisibility == 0) startMenu();
  if (settingsMenuOpened && mainMenuVisibility == 0) settingsMenu();
  if (progressMenuOpened && mainMenuVisibility == 0) progressMenu();

  if (!startMenuOpened) currentData();
  if (!mainMenuOpened) backMenu();
}
