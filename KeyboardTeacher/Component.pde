public class Component {
  public float x, y, _width, _height;
  public boolean isVisible = true;

  public <Type extends Component> Type geometry(float x, float y, float _width, float _height) {
    this.x = x;
    this.y = y;
    this._width = _width;
    this._height = _height;

    return (Type)this;
  }

  public final void display() {
    if (isVisible) {
      paint();
    }
  }

  protected void paint() {
    rect(x, y, _width, _height);
  }
}
