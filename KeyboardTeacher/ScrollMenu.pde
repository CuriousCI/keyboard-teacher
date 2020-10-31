class ScrollMenu extends Component {
  private Button left, right;
  private Label content;

  public ArrayList<String> options;
  private int optionIndex;


  public ScrollMenu(String...options) {
    this.options = new ArrayList<String>();
    for (String option : options) this.options.add(option);
    optionIndex = 0;

    left = new Button("<").geometry(x, y, _width * 0.1, _height);
    right = new Button(">").geometry(x + _width * 0.9, y, _width * 0.1, _height);
    content = new Label("").geometry(x + _width * 0.1, y, _width * 0.8, _height);
  }
  
  public String option() {
    return content.text;
  }

  private void handleEvents() {
    if (options.size() > 0) {
      if (left.isClicked()) {
        if (optionIndex < options.size()) optionIndex++;
        else optionIndex = 0;
        content.text = options.get(optionIndex);
        mousePressed = false;
      }

      if (right.isClicked()) {
        if (optionIndex > 0) optionIndex--;
        else optionIndex = 0;
        content.text = options.get(optionIndex);
        mousePressed = false;
      }
    }
  }

  @Override
    protected void paint() {
      super.paint();

    left.display();
    right.display();
    content.display();

    handleEvents();
  }
}
