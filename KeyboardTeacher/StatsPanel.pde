public class StatsPanel extends Panel {
  private Label writtenCharacters, unwrittenCharacters, beats, time, completionPercentage, correctnessPercentage;
  private int beatsCounter, timeCounter;

  public StatsPanel(float x, float y, float _width, float _height) {
    super(x, y, _width, _height);

    this.resetBeats();
    this.resetTime();

    this.writtenCharacters = new Label("", width*0.015, height*0.015, width*0.27, height*0.04); 
    this.unwrittenCharacters = new Label("", width*0.015, height*0.065, width*0.27, height*0.04);
    this.beats = new Label("", width*0.315, height*0.015, width*0.27, height*0.04);
    this.time = new Label("", width*0.315, height*0.065, width*0.27, height*0.04);
    this.completionPercentage = new Label("", width*0.615, height*0.015, width*0.27, height*0.04);
    this.correctnessPercentage = new Label("", width*0.615, height*0.065, width*0.27, height*0.04);

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
    this.beats.setText("" + this.beatsCounter);
    this.time.setText("" + this.timeCounter);
    this.completionPercentage.setText("");
    this.correctnessPercentage.setText("");
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
