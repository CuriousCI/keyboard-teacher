class Button {
  PFont TxtFont;

  int x, y, Wid, Hei, TxtSize;
  String Text;
  color Str, Fill, Txt;

  Button(int X, int Y, int W, int H, String T) {
    x = X-W/2;
    y = Y-H/2;
    Wid = W;
    Hei = H;
    Text = T;
    TxtSize = Wid/Text.length();
  }

  void Color(color s, color f, color t) {
    Str = s;
    Fill = f;
    Txt = t;
  }

  void DinColor() {
    if (MouseInside()) {
      if (Clicked()) {
        Color(#672313, #908756, #671200);
      } else {
        Color(#000000, #AABBCC, #505050);
      }
    } else {
      Color(#000000, #FFFFFF, #505050);
    }
  }

  void show() {
    stroke(Str);
    fill(Fill);
    rect (x, y, Wid, Hei, (Wid-Hei/2)/10);


    fill(Txt);
    textAlign(CENTER, CENTER);
    TxtFont = loadFont("AgencyFB-Bold-48.vlw");
    textFont (TxtFont);
    textSize(TxtSize);
    text (Text, x+Wid/2, y+Hei/2);
  }

  boolean MouseInside() {
    if ((mouseX < x+Wid && mouseX > x) && (mouseY < y+Hei && mouseY > y)) {
      return true;
    } else {
      return false;
    }
  }

  boolean Clicked() {
    if (MouseInside() && mousePressed) {
      return true;
    } else {
      return false;
    }
  }
}
