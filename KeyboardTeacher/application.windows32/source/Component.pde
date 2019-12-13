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
    fill(#FFFFFF);
    noStroke();
    rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());
  }

  protected void displayObject() {
    this.displayBackground();
  }
}
