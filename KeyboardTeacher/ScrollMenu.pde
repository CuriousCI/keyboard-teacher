class ScrollMenu extends Component {
  private Button left, right;
  private Label content;
  private int currentOptionIndex;

  private ArrayList<String> options;

  public ScrollMenu() {
    super();
  }

  public ScrollMenu(float x, float y, float _width, float _height) {
    super(x, y, _width, _height);

    this.options = new ArrayList<String>();
    this.currentOptionIndex = -1;

    this.left = new Button("<", this.getX(), this.getY(), this.getWidth() * 0.1, this.getHeight());
    this.right = new Button(">", this.getX() + this.getWidth() * 0.9, this.getY(), this.getWidth() * 0.1, this.getHeight());
    this.content = new Label("", this.getX() + this.getWidth() * 0.1, this.getY(), this.getWidth() * 0.8, this.getHeight());
  }

  public void add(String option) {
    this.options.add(option);
    if (this.options.size() == 1) {
      this.currentOptionIndex = 0;
      this.updateContent();
    }
  }

  public String getOption() {
    return this.options.get(this.currentOptionIndex);
  }

  public String getOption(int index) {
    if (this.options.size() > index) {
      return this.options.get(index);
    } else {
      return "";
    }
  }
  
  private void updateContent() {
    this.content.setText(this.options.get(this.currentOptionIndex));
  }

  private void updateOptionIndex(int direction) {
    if (this.options.size() == 0) {
      this.content.setText("");
    } else { 
      if (direction < 0) {
        if (this.currentOptionIndex == 0) {
          this.currentOptionIndex = this.options.size() - 1;
        } else {
          this.currentOptionIndex--;
        }
      } else {
        if (this.currentOptionIndex == this.options.size() - 1) {
          this.currentOptionIndex = 0;
        } else {
          this.currentOptionIndex++;
        }
      }

      this.updateContent();
    }
  }

  private void execute() {
    if (this.left.isClicked()) {
      this.updateOptionIndex(-1);
      mousePressed = false;
    }

    if (this.right.isClicked()) {
      this.updateOptionIndex(1);
      mousePressed = false;
    }
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

    this.left.display();
    this.right.display();
    this.content.display();

    this.execute();
  }
}
