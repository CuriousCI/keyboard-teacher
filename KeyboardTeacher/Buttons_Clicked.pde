void closeButtonClicked() {
  if (close.selfClicked(true)) {
    exit();
  }
}

void startButtonClicked() {
  if (start.selfClicked(mainMenuOpened)) {
    mainMenuOpened = false;
    settingsMenuOpened = false;
    backMenuOpened = true;
    startMenuOpened = true;
    progressMenuOpened = false;

    resetText();
    exerciseActivable = true;
    exerciseActive = false;
  }
}

void settingsButtonClicked() {
  if (settings.selfClicked(mainMenuOpened)) {
    mainMenuOpened = false;
    settingsMenuOpened = true;
    backMenuOpened = true;
    startMenuOpened = false;
    progressMenuOpened = false;
  }
}

void progressButtonClicked() {
  if (progress.selfClicked(mainMenuOpened)) {
    mainMenuOpened = false;
    settingsMenuOpened = false;
    backMenuOpened = true;
    startMenuOpened = false;
    progressMenuOpened = true;
  }
}

void backToMenuButtonClicked() {
  if (backToMenu.selfClicked(!mainMenuOpened)) {
    mainMenuOpened = true;
    settingsMenuOpened = false;
    backMenuOpened = false;
    startMenuOpened = false;
    progressMenuOpened = false;
    userNameWritable = false;
  }
}

void addUserButtonClicked() {
  if (addUser.selfClicked(progressMenuOpened && everySingleUser.length < 11)) {
    if (!userNameWritable) {
      userNameWritable = true;
    } else if (userNameWritable) {
      userNameWritable = false;
    }
    userName = "";
    userNameBox.text = userName;
    delay(100);
  }
}

void restartExerciseButtonClicked() {
  if (restartExercise.selfClicked(exerciseActive || (!exerciseActive && !exerciseActivable))) {
    exerciseActivable = true;
    exerciseActive = false;

    frame = 0;
    second = 0;

    resetText();
  }
}

void easyModeButtonClicked() {
  if (easyMode.selfClicked(settingsMenuOpened && settingsMenuVisibility == 300)) {
    //delay(100);
    easyModeActive = true;
    normalModeActive = false;
    hardModeActive = false;
    setting[0] = "easy";
    saveStrings("Settings.txt", setting);
  }
}

void normalModeButtonClicked() {
  if (normalMode.selfClicked(settingsMenuOpened && settingsMenuVisibility == 300)) {
    //delay(100);
    easyModeActive = false;
    normalModeActive = true;
    hardModeActive = false;
    setting[0] = "normal";
    saveStrings("Settings.txt", setting);
  }
}

void hardModeButtonClicked() {
  if (hardMode.selfClicked(settingsMenuOpened && settingsMenuVisibility == 300)) {
    //delay(100);
    easyModeActive = false;
    normalModeActive = false;
    hardModeActive = true;
    setting[0] = "hard";
    saveStrings("Settings.txt", setting);
  }
}
