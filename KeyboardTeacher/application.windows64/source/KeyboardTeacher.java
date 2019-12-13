import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.lang.Exception; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class KeyboardTeacher extends PApplet {

HashMap<Integer, Boolean> pressedKeys;

public void keyPressed() {
  pressedKeys.put(keyCode, true);

  if (stats.isVisible()) {
    stats.increaseBeats();
  }
}

public void keyReleased() {
  pressedKeys.put(keyCode, false);
  currentText += PApplet.parseChar(keyCode);
  try {
    stats.setValues(currentText, sentence.getText());
  } 
  catch (Exception e) {
    mainMenu.setVisible(true);
    exercise.setVisible(false);
    settingsMenu.setVisible(false);
    progressMenu.setVisible(false);
  }
}

public boolean isPressed(int key) {
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

String currentText;

int frameCounter;

public void settings() {
  size(1280, 800);
  //fullScreen();
}

public void setup() {
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
  currentText = "";


  home = new Button("HOME", width*0.89f, height*0.02f, width*0.10f, height*0.05f);

  start = new Button("Start", width*0.375f, height*0.34f, width*0.25f, height*0.10f); 
  settings = new Button("Settings", width*0.375f, height*0.45f, width*0.25f, height*0.10f); 
  progress = new Button("Progress", width*0.375f, height*0.56f, width*0.25f, height*0.10f); 

  JSONObject settingsFile = loadJSONObject("data/settings.json");
  mode = new Label("mode: " + settingsFile.getString("mode"), width*0.22f, height*0.02f, width*0.20f, height*0.07f);
  user = new Label("user: " + settingsFile.getString("user"), width*0.01f, height*0.02f, width*0.20f, height*0.07f);

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

  sentence = new TextArea("Hello!", width*0.05f, height*0.11f, width*0.90f, height*0.30f);

  stats = new StatsPanel(width*0.05f, height*0.42f, width*0.90f, height*0.12f);

  keyboard = new Panel(width*0.05f, height*0.55f, width*0.90f, height*0.40f);
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

public void draw() {
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

public void execute() {
  frameCounter++;
  //stats.getValues(currentText, sentence.getText());

  if (frameCounter % (int)(frameRate) == 0) {
    frameCounter = 0;
    stats.increaseTime();
  }

  if (start.isClicked()) {
    mainMenu.setVisible(false);
    stats.resetUI();
    exercise.setVisible(true);
    currentText = "";
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
class Button extends Label {
  public Button() {
    super();
  }

  public Button(String text, float x, float y, float _width, float _height) {
    super(text, x, y, _width, _height);
  }

  public boolean hasMouseInside() {
    return
      mouseX > this.getX() &&
      mouseX < this.getX() + this.getWidth() &&
      mouseY > this.getY() && 
      mouseY < this.getY() + this.getHeight();
  }

  public boolean isClicked() {
    return this.hasMouseInside() && mousePressed && this.isVisible();
  }

  @Override
    protected void displayBackground() {
    fill(0xffFFFFFF);
    stroke(0xffAA0000);
    strokeWeight(0.5f);
    rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());
    fill(0xffAA0000);
    rect(this.getX(), this.getY() + this.getHeight() - 1, this.getWidth(), 1);
  }

  @Override
    public void displayObject() {
    super.displayObject();
    if (this.hasMouseInside()) {
      fill(0xffEEDDDD, 100);
      strokeWeight(1);
      rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());
    }
  }
}
public class Component {
  private float x, y, _width, _height;
  private boolean visible;

  public Component() {
    this(0, 0, 0, 0);
  }

  public Component(float x, float y, float _width, float _height) {
    this.setGeometry(x, y, _width, _height);
    this.visible = true;
  }

  public void setX(float x) {
    this.x = x;
  }

  public void setY(float y) {
    this.y = y;
  }

  public void setWidth(float _width) {
    this._width = _width;
  }

  public void setHeight(float _height) {
    this._height = _height;
  }

  public void setCoordinates(float x, float y) {
    this.setX(x);
    this.setY(y);
  }

  public void setDimensions(float _width, float _height) {
    this.setWidth(_width);
    this.setHeight(_height);
  }

  public void setGeometry(float x, float y, float _width, float _height) {
    this.setCoordinates(x, y);
    this.setDimensions(_width, _height);
  }

  public void setVisible(boolean visible) {
    this.visible = visible;
  }

  public float getX() {
    return this.x;
  }

  public float getY() {
    return this.y;
  }

  public float getWidth() {
    return this._width;
  }

  public float getHeight() {
    return this._height;
  }

  public boolean isVisible() {
    return this.visible;
  }

  public final void display() {
    if (this.isVisible()) {
      this.displayObject();
    }
  }

  protected void displayBackground() {
    fill(0xffFFFFFF);
    noStroke();
    rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());
  }

  protected void displayObject() {
    this.displayBackground();
  }
}
public enum Finger {
  THUMB, 
    PINKY, 
    RING, 
    MIDDLE, 
    INDEX
}

public enum Hand {
  RIGHT, 
    LEFT
}


public enum Mode {
  EASY, 
    NORMAL, 
    HARD
}
public class Key extends Label {
  private Finger finger = Finger.INDEX;
  private Hand hand = Hand.RIGHT;

  public Key() {
    this("", 0, 0, 0, 0, "", "");
  }

  public Key(String text, float x, float y, float _width, float _height, String finger, String hand) {
    super(text, x, y, _width, _height);
  }

  @Override
    protected void displayBackground() {
    //super.displayObject();
    if (isPressed(this.getText().charAt(0))) {
      fill(255, 255, 00);
      rect(this.getX() - 2, this.getY() - 2, this.getWidth() + 4, this.getHeight() + 4);
    } else {
      super.displayBackground();
    }
  }
}
public class Label extends Component {
  private float x, y, _width, _height;
  private String text;
  private int textSize;

  public Label() {
    this("", 0, 0, 0, 0);
  }

  public Label(String text, float x, float y, float _width, float _height) {
    super(x, y, _width, _height);
    this.setText(text);
    this.autoFill();
  }

  public void setText(String text) {
    this.text = text;
  }

  public void setTextSize(int textSize) {
    this.textSize = textSize;
  }

  public String getText() {
    return this.text;
  }

  public int getTextSize() {
    return this.textSize;
  }

  public void autoFill() {
    this.setTextSize(1);
    textSize(1);
    while (textWidth(this.text) < this.getWidth()*0.8f && this.textSize < this.getHeight()*0.8f) {
      textSize(this.textSize);
      this.textSize++;
    }
  }

  @Override
    protected void displayBackground() {
    fill(0xffFFFFFF);
    stroke(0xffAA0000);
    strokeWeight(0.5f);
    rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());
  }

  protected void displayText() {
    fill(0xffAA0000);
    stroke(0xffAA0000);
    strokeWeight(2);
    textSize(this.textSize);
    text(this.getText(), this.getX()+(this.getWidth()*0.5f-textWidth(this.getText())*0.5f), this.getY()+this.getHeight()*0.5f);
  }

  @Override
    protected void displayObject() {
    super.displayObject();
    this.displayText();
  }
}
class Panel extends Component {
  private ArrayList<Component> components;

  public Panel() {
    this(0, 0, 0, 0);
  }

  public Panel(float x, float y, float _width, float _height) {
    super(x, y, _width, _height);
    components = new ArrayList<Component>();
  }

  @Override
    public void setVisible(boolean visible) {
    super.setVisible(visible);
    for (Component element : components) {
      element.setVisible(visible);
    }
  }

  public void add(Component component) {
    component.setCoordinates(
      this.getX() + component.getX(), 
      this.getY() + component.getY());
    components.add(component);
  }

  @Override
    protected void displayBackground() {
    fill(0xffFFFFFF);
    stroke(0xffAA0000);
    strokeWeight(0.1f);
    rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());
  }

  @Override
    protected void displayObject() {
    super.displayObject();
    for (Component element : components) {
      element.display();
    }
  }
}


public class StatsPanel extends Panel {
  private Label writtenCharacters, unwrittenCharacters, beats, time, completionPercentage, correctnessPercentage;
  private int beatsCounter, timeCounter, written, unwritten, completion, corectness;

  public StatsPanel(float x, float y, float _width, float _height) {
    super(x, y, _width, _height);

    this.resetBeats();
    this.resetTime();
    this.written = 0;
    this.unwritten = 0;
    this.completion = 0;
    this.corectness = 0;

    this.writtenCharacters = new Label("", width*0.015f, height*0.015f, width*0.27f, height*0.04f); 
    this.unwrittenCharacters = new Label("", width*0.015f, height*0.065f, width*0.27f, height*0.04f);
    this.beats = new Label("", width*0.315f, height*0.015f, width*0.27f, height*0.04f);
    this.time = new Label("", width*0.315f, height*0.065f, width*0.27f, height*0.04f);
    this.completionPercentage = new Label("", width*0.615f, height*0.015f, width*0.27f, height*0.04f);
    this.correctnessPercentage = new Label("", width*0.615f, height*0.065f, width*0.27f, height*0.04f);

    this.add(writtenCharacters); 
    this.add(unwrittenCharacters);
    this.add(beats);
    this.add(time);
    this.add(completionPercentage);
    this.add(correctnessPercentage);
  }

  public void resetUI() {
    this.resetBeats();
    this.resetTime();

    this.writtenCharacters.setText("");
    this.unwrittenCharacters.setText("");
    this.beats.setText("");
    this.time.setText("");
    this.completionPercentage.setText("");
    this.correctnessPercentage.setText("");
  }

  public void updateUI() {
    this.writtenCharacters.setText("");
    this.unwrittenCharacters.setText("");
    this.beats.setText("beats: " + this.beatsCounter/this.timeCounter + "/s" );
    this.time.setText("time: " + this.timeCounter);
    this.completionPercentage.setText("completion: " + this.completion + "%");
    this.correctnessPercentage.setText("corectness: " + this.corectness + "%");
  }

  public void setValues(String alpha, String beta) {
    if (alpha.length() > beta.length()) {
      throw new NullPointerException("");
    }

    this.written = alpha.length();
    this.unwritten = beta.length() - this.written;
    this.completion = this.written > 0 ? this.unwritten/this.written*100 : 0;

    int correctTextCount = 0;
    for (int index = 0; index < alpha.length(); index++) {
      if (alpha.charAt(index) == beta.charAt(index)) {
        correctTextCount++;
      }
    }
    this.corectness = correctTextCount > 0 ? this.written/correctTextCount*100 : 0;
  }

  public void resetBeats() {
    this.beatsCounter = 0;
  }

  public void increaseBeats() {
    this.beatsCounter++;
    this.updateUI();
  }

  public void resetTime() {
    this.timeCounter = 0;
  }

  public void increaseTime() {
    this.timeCounter++;
    this.updateUI();
  }
}
public class TextArea extends Label {
  private int rows, columns;
  private int cellWidth, cellHeight;

  public TextArea() {
    this("", 0, 0, 0, 0);
  }

  public TextArea(String text, float x, float y, float _width, float _height) {
    super(text, x, y, _width, _height);
    this.setRows(10);
    this.setColumns(60);

    this.cellWidth = (int)(this.getWidth() / this.columns);
    this.cellHeight = (int)(this.getHeight() / this.rows);
    this.setTextSize(this.cellHeight);
  }

  public void setRows(int rows) {
    this.rows = rows;
  }

  public void setColumns(int columns) {
    this.columns = columns;
  }

  @Override 
    protected void displayText() {
    fill(0xffAA0000);
    stroke(0xffAA0000);
    strokeWeight(2);
    textSize(this.getTextSize());
    for (int x = 0; x < this.columns - 1; x++) {
      for (int y = 0; y < this.rows; y++) {
        int index = x + y * this.columns;
        if (index >= this.getText().length()) {
          break;
        }
        text(this.getText().charAt(index), this.getX()+x*this.cellWidth+this.cellWidth, this.getTextSize()+this.getY()+y*this.cellHeight);
      }
    }
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "KeyboardTeacher" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
