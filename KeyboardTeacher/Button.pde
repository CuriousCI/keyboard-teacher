class Button {
  PFont TxtFont;

  int x, y, Wid, Hei, TxtSize, transparency;
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

  void DinColor(color a1, color a2, color a3, color b1, color b2, color b3, color c1, color c2, color c3, int tra) {
    transparency = tra;
    if (MouseInside()) {
      if (Clicked()) {
        Color(a1, a2, a3);
        if (tra == 200) {
          transparency = 100;
        }
        //Wid+=10; Hei+=10;
        //delay(100);
      } else {
        Color(b1, b2, b3);
      }
    } else {
      Color(c1, c2, c3);
    }
  }

  void show() {
    strokeWeight(2.5);
    stroke(Str, transparency);
    fill(Fill, transparency);
    rect (x, y, Wid, Hei, (Wid-Hei/2)/10);


    fill(Txt, transparency);
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
