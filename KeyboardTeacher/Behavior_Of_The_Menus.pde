void mainMenu() {
  start.show(mainMenuVisibility, start.changeDynamicColors());
  startButtonClicked();

  settings.x = width/2;
  settings.y =  height/2;
  settings.selfWidth = 250;
  settings.selfHeight = 75;
  settings.show(mainMenuVisibility, settings.changeDynamicColors());
  settingsButtonClicked();

  progress.show(mainMenuVisibility, progress.changeDynamicColors());
  progressButtonClicked();
}

void startMenu() {
  if (easyModeActive) {
    keyboard.show(startMenuVisibility, 1);
    textToWrite.show(startMenuVisibility, 1);
    indicators.show(startMenuVisibility, 1);
  } else if (normalModeActive) {
    keyboard.show(startMenuVisibility, 1);
    textToWrite.show(startMenuVisibility, 1);
    indicators.show(startMenuVisibility, 1);
  } else if (hardModeActive) {
    textToWrite.selfHeight = 450;
    textToWrite.y = 300;
    textToWrite.show(startMenuVisibility, 1);
    indicators.y = (height - (3 * 60 + 230)) + indicators.selfWidth;
    indicators.show(startMenuVisibility, 1);
  }

  keyboard();
}

void backMenu() {
  backToMenu.show(backMenuVisibility, backToMenu.changeDynamicColors());
  backToMenuButtonClicked();
}

void settingsMenu() {
  settings.x = width/2;
  settings.y =  height/2-200;
  settings.selfWidth = 300;
  settings.selfHeight = 90;

  settings.show(settingsMenuVisibility, /*settings.changeDynamicColors()*/ 2);
  easyMode.show(settingsMenuVisibility, easyMode.changeDynamicColors());
  easyModeButtonClicked();
  normalMode.show(settingsMenuVisibility, normalMode.changeDynamicColors());
  normalModeButtonClicked();
  hardMode.show(settingsMenuVisibility, hardMode.changeDynamicColors());
  hardModeButtonClicked();
}

void keyboard() {
  if (startMenuOpened && mainMenuVisibility == 0) {
    for (int i = 0; i < 117; i++) {
      keysOfKeyboard[i].show(300, keysOfKeyboard[i].changeDynamicColors());
    }
  }
}

void changeMenuVisibility() { // Function switching from a menu to another
  if (mainMenuOpened && mainMenuVisibility != 300 && backMenuVisibility == 0) {
    mainMenuVisibility += transitionSpeed;
  } else if (!mainMenuOpened && mainMenuVisibility != 0 && backMenuVisibility == 0) {
    mainMenuVisibility -= transitionSpeed;
  } else if (!mainMenuOpened && backMenuOpened && mainMenuVisibility == 0 && backMenuVisibility != 300) {
    backMenuVisibility += transitionSpeed;
    if (settingsMenuOpened && settingsMenuVisibility != 300) {
      settingsMenuVisibility += transitionSpeed;
    } else if (startMenuOpened && startMenuVisibility != 300) {
      startMenuVisibility += transitionSpeed;
    }
  } else if (mainMenuOpened && mainMenuVisibility == 0 && backMenuVisibility != 0) {
    backMenuVisibility -= transitionSpeed;
    if (!settingsMenuOpened && settingsMenuVisibility != 0) {
      settingsMenuVisibility -= transitionSpeed;
    }
    if (!startMenuOpened && startMenuVisibility != 0) {
      startMenuVisibility -= transitionSpeed;
    }
  }
}
