class Button {
  int x, y, Wid, Hei;
  String Text;
  color Str, Fill, Txt;

  Button (int X, int Y, int W, int H, String T){
    x = X;
    y = Y;
    Wid = W;
    Hei = H;
    Text = T;
  }
  
  void Color(color s, color f, color t){
    Str = s;
    Fill = f;
    Txt = t;
  }
  
  void show(){
    stroke(Str);
    fill(Fill);
    rect (x, y, Wid, Hei, 3);
    text (Text, (x+Wid)-Text.length(), (y+Hei)-20);
  }
  
  boolean MouseInside (){
    if ((mouseX < x+Wid && mouseX > x) && (mouseY < y+Hei && mouseY > y)){
      return true;
    } else {
      return false;
    }
  }
  
  boolean Clicked (){
    if (MouseInside() && mousePressed){
      return true;
    } else {
      return false;
    }
  }
}
