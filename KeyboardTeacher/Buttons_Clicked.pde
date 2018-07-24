void closeButtonClicked() {
  if (close.selfClicked(true)) {
    delay(100);
    exit();
  }
}

void startButtonClicked() {
  if (start.selfClicked(mainMenuOpened)) {
    delay(100);
    mainMenuOpened = false;
    settingsMenuOpened = false;
    backMenuOpened = true;
    startMenuOpened = true;
  }
}

void settingsButtonClicked() {
  if (settings.selfClicked(mainMenuOpened)) {
    delay(100);
    mainMenuOpened = false;
    settingsMenuOpened = true;
    backMenuOpened = true;
    startMenuOpened = false;
  }
}

void progressButtonClicked() {
  if (progress.selfClicked(mainMenuOpened)) {
    delay(100);
    mainMenuOpened = false;
    settingsMenuOpened = false;
    backMenuOpened = true;
    startMenuOpened = false;
  }
}

void backToMenuButtonClicked() {
  if (backToMenu.selfClicked(!mainMenuOpened)) {
    delay(100);
    mainMenuOpened = true;
    settingsMenuOpened = false;
    backMenuOpened = false;
    startMenuOpened = false;
  }
}

void easyModeButtonClicked() {
  if (easyMode.selfClicked(settingsMenuOpened)) {
    delay(100);
    easyModeActive = true;
    normalModeActive = false;
    hardModeActive = false;
  }
}

void normalModeButtonClicked() {
  if (normalMode.selfClicked(settingsMenuOpened)) {
    delay(100);
    easyModeActive = false;
    normalModeActive = true;
    hardModeActive = false;
  }
}

void hardModeButtonClicked() {
  if (hardMode.selfClicked(settingsMenuOpened)) {
    delay(100);
    easyModeActive = false;
    normalModeActive = false;
    hardModeActive = true;
  }
}
