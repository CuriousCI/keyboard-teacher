class Panel extends Component {
  private ArrayList<Component> components;

  public Panel() {
    this(0, 0, 0, 0);
  }

  public Panel(float x, float y, float _width, float _height) {
    super(x, y, _width, _height);
    components = new ArrayList<Component>();
  }

  @Override
    public void setVisible(boolean visible) {
    super.setVisible(visible);
    for (Component element : components) {
      element.setVisible(visible);
    }
  }

  public void add(Component component) {
    component.setCoordinates(
      this.getX() + component.getX(), 
      this.getY() + component.getY());
    components.add(component);
  }

  @Override
    protected void displayBackground() {
    fill(#FFFFFF);
    stroke(#AA0000);
    strokeWeight(0.1);
    rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());
  }

  @Override
    protected void displayObject() {
    super.displayObject();
    for (Component element : components) {
      element.display();
    }
  }
}
