HashMap<Integer, Boolean> pressedKeys;

public enum Mode {
  EASY, 
    NORMAL, 
    HARD,
}

void keyPressed() {
  pressedKeys.put(keyCode, true);

  if (stats.isVisible) stats.increaseBeats();
}

void keyReleased() {
  pressedKeys.put(keyCode, false);
  if (keyCode > 32) sentence.inputText += char(key);
  try {
    stats.setValues(sentence.inputText, sentence.text);
  } 
  catch (Exception e) {
    mainMenu.isVisible = true;
    exercise.isVisible = false;
    settingsMenu.isVisible = false;
    progressMenu.isVisible = false;
  }
}

boolean isPressed(int key) {
  if (pressedKeys.containsKey(key)) return pressedKeys.get(key);
  return false;
}

Mode mode;

Panel 
  mainMenu, 
  settingsMenu, 
  progressMenu, 
  exercise, 
  keyboard;

StatsPanel stats;
Label selectedMode, selectedUser;
TextArea sentence;
Button start, settings, progress;
Button home;
ScrollMenu modeSelector;

int frameCounter;

void settings() {
  size(1280, 800);
}

void setup() {
  frameRate(60);
  frameCounter = 0;
  PFont font = loadFont("Monospaced.plain-48.vlw");
  textFont(font);
  textAlign(LEFT, CENTER);

  JSONArray keysFile = loadJSONArray("data/keys.json");
  ArrayList<Key> keys = new ArrayList<Key>();

  for (int index = 0; index < keysFile.size(); index++) {
    JSONObject _key = keysFile.getJSONObject(index); //<>//
    
    //Hand.valueOf(_key.getString("hand")
    keys.add(
      (Key)
      new Key(
      _key.getString("value"), 
      Hand.RIGHT, 
      Finger.valueOf(_key.getString("finger").toUpperCase())
      )
      .geometry(
      _key.getFloat("x"), 
      _key.getFloat("y"), 
      _key.getFloat("width"), 
      _key.getFloat("height")
      )
      );
  }

  pressedKeys = new HashMap<Integer, Boolean>();


  home = new Button("HOME").geometry(width*0.89, height*0.02, width*0.10, height*0.05);

  start = new Button("Start")
    .geometry(width*0.375, height*0.34, width*0.25, height*0.10); 
  settings = new Button("Settings")
    .geometry(width*0.375, height*0.45, width*0.25, height*0.10); 
  progress = new Button("Progress")
    .geometry(width*0.375, height*0.56, width*0.25, height*0.10); 

  JSONObject settingsFile = loadJSONObject("data/settings.json");
  selectedMode = new Label("mode: " + settingsFile.getString("mode"))
    .geometry(width*0.22, height*0.02, width*0.20, height*0.07);
  selectedUser = new Label("user: " + settingsFile.getString("user"))
    .geometry(width*0.01, height*0.02, width*0.20, height*0.07);

  modeSelector = new ScrollMenu("easy", "normal", "hard")
    .geometry(width*0.375, height*0.45, width*0.25, height*0.10);

  mainMenu = new Panel(start, settings, progress, selectedMode, selectedUser)
    .geometry(0, 0, width, height);

  settingsMenu = new Panel(home, selectedMode, selectedUser, modeSelector)
    .geometry(0, 0, width, height);
  settingsMenu.isVisible = false;

  progressMenu = new Panel(home, selectedUser).geometry(0, 0, width, height);
  progressMenu.isVisible = false;

  sentence = new TextArea("Hello! how are you doing foo bar this is a test to see how the textarea handles a really long sentence")
    .geometry(width*0.05, height*0.11, width*0.90, height*0.30);

  stats = new StatsPanel().geometry(width*0.05, height*0.42, width*0.90, height*0.12);

  keyboard = new Panel().geometry(width*0.05, height*0.55, width*0.90, height*0.40);
  for (Key _key : keys) {
    _key.x *= 60;
    _key.y *= 60;
    _key._width *= 25;
    _key._height *= 25;
    _key.resizeText();
    keyboard.components.add(_key);
  }

  exercise = new Panel(home, stats, sentence, keyboard)
    .geometry(0, 0, width, height);
  exercise.isVisible = false;
}

void draw() {
  background(200);

  execute();
  mainMenu.display();
  exercise.display();
  settingsMenu.display();
  progressMenu.display();

  //  fill(255, 0, 0);
  //  text(frameRate, mouseX, mouseY);
}

void execute() {
  frameCounter++;
  //stats.getValues(currentText, sentence.getText());

  if (frameCounter % (int)(frameRate) == 0) {
    frameCounter = 0;
    stats.increaseTime();
  }

  if (start.isClicked()) {
    mainMenu.isVisible = false;
    stats.resetUI();
    exercise.isVisible = true;
    sentence.inputText = "";
  } 

  if (settings.isClicked()) {
    mainMenu.isVisible = false;
    settingsMenu.isVisible = true;
  }

  if (progress.isClicked()) {
    mainMenu.isVisible =false;
    progressMenu.isVisible = true;
  }

  if (home.isClicked()) {
    mainMenu.isVisible = true;
    exercise.isVisible = false;
    settingsMenu.isVisible = false;
    progressMenu.isVisible = false;
  }

  // I know it would be bette to handle an event in this case
  // But is too much truble for me :), I'll add it later, it could 
  // make esier to change the files later
  //mode = Mode.valueOf(modeSelector.option().toUpperCase() || Mode.NORMAL); //<>//
  mode = Mode.NORMAL;
  selectedMode.text = modeSelector.option();

  //if (modeSelector.getOption() != settingsFile.getString("mode")) {} //TODO: update json file
}
