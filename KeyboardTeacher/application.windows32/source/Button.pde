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
    fill(#FFFFFF);
    stroke(#AA0000);
    strokeWeight(0.5);
    rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());
    fill(#AA0000);
    rect(this.getX(), this.getY() + this.getHeight() - 1, this.getWidth(), 1);
  }

  @Override
    public void displayObject() {
    super.displayObject();
    if (this.hasMouseInside()) {
      fill(#EEDDDD, 100);
      strokeWeight(1);
      rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());
    }
  }
}
