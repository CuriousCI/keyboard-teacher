Button start;
Button settings;
Button progress;
Button close;


void setup() {
  fullScreen ();

  start = new Button(width/2, height/2-80, 250, 75, "Start");
  settings = new Button(width/2, height/2, 250, 75, "Settings");
  progress = new Button(width/2, height/2+80, 250, 75, "Progress");
  close = new Button(width-100, 50, 100, 50, "close");
}

void draw() {
  background(200);
  
  start.DinColor();
  start.show();
  
  settings.DinColor();
  settings.show();
  
  progress.DinColor();
  progress.show();
  
  close.DinColor();
  close.show();
  
  //ellipse(width/2, height/2, 50, 50);
}
