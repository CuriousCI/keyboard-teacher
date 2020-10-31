import java.lang.Exception;

public class StatsPanel extends Panel {
  Label 
    writtenCharacters, 
    unwrittenCharacters, 
    beats, 
    time, 
    completionPercentage, 
    correctnessPercentage;
  int 
    beatsCounter = 0, 
    timeCounter = 0, 
    written = 0, 
    unwritten = 0, 
    completion = 0, 
    corectness = 0;

  public StatsPanel() {
    writtenCharacters = new Label().geometry(width*0.015, height*0.015, width*0.27, height*0.04); 
    unwrittenCharacters = new Label().geometry(width*0.015, height*0.065, width*0.27, height*0.04);
    beats = new Label().geometry(width*0.315, height*0.015, width*0.27, height*0.04);
    time = new Label().geometry(0.315, height*0.065, width*0.27, height*0.04);
    completionPercentage = new Label().geometry(width*0.615, height*0.015, width*0.27, height*0.04);
    correctnessPercentage = new Label().geometry(width*0.615, height*0.065, width*0.27, height*0.04);

    components.add(writtenCharacters); 
    components.add(unwrittenCharacters);
    components.add(beats);
    components.add(time);
    components.add(completionPercentage);
    components.add(correctnessPercentage);
  }

  public void resetUI() {
    beatsCounter = 0;
    timeCounter = 0;

    writtenCharacters.text = "";
    unwrittenCharacters.text = "";
    beats.text = "";
    time.text = "";
    completionPercentage.text = "";
    correctnessPercentage.text = "";
  }

  public void updateUI() {
    writtenCharacters.text = "";
    unwrittenCharacters.text = "";
    beats.text = "beats: " + this.beatsCounter/(this.timeCounter + 1) + "/s" ;
    time.text = "time: " + this.timeCounter;
    completionPercentage.text = "completion: " + this.completion + "%";
    correctnessPercentage.text = "corectness: " + this.corectness + "%";
  }

  public void setValues(String alpha, String beta) {
    if (alpha.length() > beta.length()) throw new IllegalArgumentException("");

    this.written = alpha.length();
    this.unwritten = beta.length() - this.written;
    this.completion = this.written > 0 ? this.written / (this.unwritten + this.written) * 100 : 0;

    int correctTextCount = 0;
    for (int index = 0; index < alpha.length(); index++) {
      if (alpha.charAt(index) == beta.charAt(index)) {
        correctTextCount++;
      }
    }
    this.corectness = correctTextCount > 0 ? correctTextCount / this.written *100 : 0;
  }

  public void increaseBeats() {
    this.beatsCounter++;
    this.updateUI();
  }
  
  public void increaseTime() {
    this.timeCounter++;
    this.updateUI();
  }
}
