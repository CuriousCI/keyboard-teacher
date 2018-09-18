void closeButtonClicked() {
  if (close.selfClicked()) exit();
}

void startButtonClicked() {
  if (start.selfClicked() && mainMenuOpened) {
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
  if (settings.selfClicked() && mainMenuOpened) {
    mainMenuOpened = false;
    settingsMenuOpened = true;
    backMenuOpened = true;
    startMenuOpened = false;
    progressMenuOpened = false;
  }
}

void progressButtonClicked() {
  if (progress.selfClicked() && mainMenuOpened) {
    mainMenuOpened = false;
    settingsMenuOpened = false;
    backMenuOpened = true;
    startMenuOpened = false;
    progressMenuOpened = true;
  }
}

void backToMenuButtonClicked() {
  if (backToMenu.selfClicked() && !mainMenuOpened) {
    mainMenuOpened = true;
    settingsMenuOpened = false;
    backMenuOpened = false;
    startMenuOpened = false;
    progressMenuOpened = false;
    userNameWritable = false;
  }
}

void addUserButtonClicked() {
  if (addUser.selfClicked() && progressMenuOpened && everySingleUser.length < 11) {
    if (!userNameWritable) { 
      userNameWritable = true;
      addUser.text = "close";
    } else if (userNameWritable) { 
      userNameWritable = false;
      addUser.text = "Add User";
    }
    userName = "";
    userNameBox.text = userName;
    delay(100);
  }
}

void removeUserButtonClicked() {
  if (removeUser.selfClicked()) {
    if (!userRemovable) { 
      userRemovable = true;
      removeUser.text = "close";
    } else if (userRemovable) { 
      userRemovable = false;
      removeUser.text = "remove user";
    }
    delay(100);
  }
}

void restartExerciseButtonClicked() {
  if (restartExercise.selfClicked() && (exerciseActive || (!exerciseActive && !exerciseActivable))) {
    exerciseActivable = true;
    exerciseActive = false;
    frame = 0;
    second = 0;
    resetText();
  }
}

void easyModeButtonClicked() {
  if (easyMode.selfClicked() && settingsMenuVisibility == 300) {
    easyModeActive = true;
    normalModeActive = false;
    hardModeActive = false;
    setting[0] = "easy";
    currentMode.text = "mode: " + setting[0];
    saveStrings("Settings.txt", setting);
  }
}

void normalModeButtonClicked() {
  if (normalMode.selfClicked() && settingsMenuVisibility == 300) {
    easyModeActive = false;
    normalModeActive = true;
    hardModeActive = false;
    setting[0] = "normal";
    currentMode.text = "mode: " + setting[0];
    saveStrings("Settings.txt", setting);
  }
}

void hardModeButtonClicked() {
  if (hardMode.selfClicked() && settingsMenuVisibility == 300) {
    easyModeActive = false;
    normalModeActive = false;
    hardModeActive = true;
    setting[0] = "hard";
    currentMode.text = "mode: " + setting[0];
    saveStrings("Settings.txt", setting);
  }
}
