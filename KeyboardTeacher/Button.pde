class Button extends Label {
  public Button(String text) {
    super(text);
  }

  public boolean hasMouseInside() {
    return
      mouseX > x &&
      mouseX < x + _width &&
      mouseY > y && 
      mouseY < y + _height;
  }

  public boolean isClicked() {
    return 
      hasMouseInside() && 
      mousePressed && 
      isVisible;
  }

  @Override 
    protected void paint() {
      super.paint();
  }
}
