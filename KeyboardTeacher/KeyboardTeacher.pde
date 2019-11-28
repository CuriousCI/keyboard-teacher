HashMap<Integer, Boolean> pressedKeys; //<>//

void keyPressed() {
  pressedKeys.put(keyCode, true);

  if (stats.isVisible()) {
    stats.increaseBeats();
  }
}

void keyReleased() {
  pressedKeys.put(keyCode, false);
}

boolean isPressed(int key) {
  if (pressedKeys.containsKey(key)) {
    return pressedKeys.get(key);
  }
  return false;
}

Panel mainMenu, settingsMenu, progressMenu, exercise, keyboard/*, stats*/;
StatsPanel stats;
Label mode, user;
TextArea sentence;
Button start, settings, progress;
Button home;

int frameCounter;

void settings() {
  size(1280, 800);
  //fullScreen();
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
    JSONObject _key = keysFile.getJSONObject(index); 
    keys.add(new Key(_key.getString("value"), _key.getFloat("x"), _key.getFloat("y"), _key.getFloat("width"), _key.getFloat("height"), _key.getString("finger"), _key.getString("finger")));
  }

  pressedKeys = new HashMap<Integer, Boolean>();


  home = new Button("HOME", width*0.89, height*0.02, width*0.10, height*0.05);

  start = new Button("Start", width*0.375, height*0.34, width*0.25, height*0.10); 
  settings = new Button("Settings", width*0.375, height*0.45, width*0.25, height*0.10); 
  progress = new Button("Progress", width*0.375, height*0.56, width*0.25, height*0.10); 

  JSONObject settingsFile = loadJSONObject("data/settings.json");
  mode = new Label("mode: " + settingsFile.getString("mode"), width*0.22, height*0.02, width*0.20, height*0.07);
  user = new Label("user: " + settingsFile.getString("user"), width*0.01, height*0.02, width*0.20, height*0.07);

  mainMenu = new Panel(0, 0, width, height);
  mainMenu.add(start);
  mainMenu.add(settings);
  mainMenu.add(progress);
  mainMenu.add(mode);
  mainMenu.add(user);

  settingsMenu = new Panel(0, 0, width, height);
  settingsMenu.setVisible(false);
  settingsMenu.add(home);
  settingsMenu.add(mode);
  settingsMenu.add(user);

  progressMenu = new Panel(0, 0, width, height);
  progressMenu.setVisible(false);
  progressMenu.add(home);
  progressMenu.add(user);

  sentence = new TextArea("Hello!", width*0.05, height*0.11, width*0.90, height*0.30);

  stats = new StatsPanel(width*0.05, height*0.42, width*0.90, height*0.12);

  keyboard = new Panel(width*0.05, height*0.55, width*0.90, height*0.40);
  for (Key _key : keys) {
    _key.setX(_key.getX() * 60);
    _key.setY(_key.getY() * 60);
    _key.setWidth(_key.getWidth() * 25);
    _key.setHeight(_key.getHeight() * 25);
    _key.autoFill();
    keyboard.add(_key);
  }

  exercise = new Panel(0, 0, width, height);
  exercise.setVisible(false);
  exercise.add(home);
  exercise.add(stats);
  exercise.add(sentence);
  exercise.add(keyboard);
}

void draw() {
  background(200);
  noStroke();

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
  
  if (frameCounter % (int)(frameRate) == 0) {
    frameCounter = 0;
    stats.increaseTime();
  }
  
  if (start.isClicked()) {
    mainMenu.setVisible(false);
    stats.resetUI();
    exercise.setVisible(true);
  } 

  if (settings.isClicked()) {
    mainMenu.setVisible(false);
    settingsMenu.setVisible(true);
  }

  if (progress.isClicked()) {
    mainMenu.setVisible(false);
    progressMenu.setVisible(true);
  }

  if (home.isClicked()) {
    mainMenu.setVisible(true);
    exercise.setVisible(false);
    settingsMenu.setVisible(false);
    progressMenu.setVisible(false);
  }
}
