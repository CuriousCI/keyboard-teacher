class Panel extends Component {
  public ArrayList<Component> components;

  public Panel(Component...components) {
    this.components = new ArrayList<Component>();
    for (Component component : components) this.components.add(component);
  }

  @Override
    protected void paint() {
      super.paint();
    for (Component component : components) {
      pushMatrix();
      translate(x, y);
      component.display();
      popMatrix();
    }
  }
}
