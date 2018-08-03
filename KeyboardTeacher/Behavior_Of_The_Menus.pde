int sosTESTY = 0; //<>// //<>//
int abc = 0;

void mainMenu() {
  start.show(mainMenuVisibility);
  startButtonClicked();

  settings.x = width/2;
  settings.y =  height/2;
  settings.selfWidth = 250;
  settings.selfHeight = 75;
  settings.show(mainMenuVisibility);
  settingsButtonClicked();

  progress.show(mainMenuVisibility);
  progressButtonClicked();

  if (easyModeActive) {
    currentMode.text = "current mode: [EASY]";
  } else if (normalModeActive) {
    currentMode.text = "current mode: [NORMAL]";
  } else if (hardModeActive) {
    currentMode.text = "current mode: [HARD]";
  }

  currentMode.setColors(#0021F0, #0021F0, #F021FF);
  currentMode.textSize = currentMode.selfWidth / currentMode.text.length() * 2; 
  currentUser.setColors(#0021F0, #0021F0, #F021FF);
  currentUser.textSize = currentUser.selfWidth / currentUser.text.length() * 2; 
  if (((!mainMenuOpened && settingsMenuOpened) || (mainMenuOpened && !settingsMenuOpened)) && (startMenuVisibility == 0 && progressMenuVisibility == 0)) {
    currentMode.staticShow(300);
    currentUser.staticShow(300);
  } else {
    currentMode.staticShow(mainMenuVisibility + settingsMenuVisibility);
    currentUser.staticShow(mainMenuVisibility + settingsMenuVisibility);
  }
}

void startMenu() {
  if (easyModeActive) {
    keyboard.staticShow(startMenuVisibility);
    textToWrite.selfHeight = 275;
    textToWrite.y = 275 / 2 + 25;
    textToWrite.staticShow(startMenuVisibility);
    indicatorsBar.y = height - (3 * 60 + 230);
    indicatorsBar.staticShow(startMenuVisibility);
    keyboard();
  } else if (normalModeActive) {
    keyboard.staticShow(startMenuVisibility);
    textToWrite.selfHeight = 275;
    textToWrite.y = 275 / 2 + 25;
    textToWrite.staticShow(startMenuVisibility);
    indicatorsBar.y = height - (3 * 60 + 230);
    indicatorsBar.staticShow(startMenuVisibility);
    keyboard();
  } else if (hardModeActive) {
    textToWrite.selfHeight = 570;
    textToWrite.y = 325;
    textToWrite.staticShow(startMenuVisibility);
    indicatorsBar.y = height - 100;
    indicatorsBar.staticShow(startMenuVisibility);
  }

  indicators();

  beatsPerMinute.staticShow(startMenuVisibility);
  charactersToWriteBox.staticShow(startMenuVisibility);
  writtenCharactersBox.staticShow(startMenuVisibility);
  time.staticShow(startMenuVisibility);
  percentageOfCompletion.staticShow(startMenuVisibility);
  percentageOfCorrectText.staticShow(startMenuVisibility);

  textAlign(LEFT, CENTER);
  fill(200, 200, 200, startMenuVisibility);
  if (int(textWidth(unwrittenText.substring(abc + 1))) > 870) {
    abc =  unwrittenText.indexOf("\n", abc + 1);
    unwrittenText += "\n";
    sosTESTY += 14;
    delay(10);
  } 
  text(unwrittenText, width / 2 - 925 / 2 + 20, 50 + sosTESTY);
  if (keyPressed) {
    unwrittenText += key;
    beats++;
    delay(50);
  }
  if (easyModeActive) {
    fill(0, 255, 0, startMenuVisibility);
    text(correctText, 200, 200);
    fill(255, 0, 0, startMenuVisibility);
    text(wrongText, 200, 200);
  } else {
    fill(0, 0, 0, startMenuVisibility);
    text(writtenText, 200, 200);
  }
  textAlign(CENTER, CENTER);
}

void settingsMenu() {
  settings.x = width/2;
  settings.y =  height/2-200;
  settings.selfWidth = 300;
  settings.selfHeight = 90;

  settings.show(settingsMenuVisibility);
  easyMode.show(settingsMenuVisibility);
  easyModeButtonClicked();
  normalMode.show(settingsMenuVisibility);
  normalModeButtonClicked();
  hardMode.show(settingsMenuVisibility);
  hardModeButtonClicked();
}

void progressMenu() {
  addUser.show(progressMenuVisibility);
  selectUser.show(progressMenuVisibility);
}

void backMenu() {
  backToMenu.show(backMenuVisibility);
  backToMenuButtonClicked();
}

void keyboard() {
  if (startMenuOpened && startMenuVisibility >= 150) {
    for (int i = 116; i >= 0; i--) {
      keysOfKeyboard[i].show(300);
    }
  }
}

void indicators() {
  frame++;
  if (frame >= int(frameRate)) {
    second++;
    frame = 0;
  }
  charactersToWrite = unwrittenText.length() - writtenText.length() + 1;
  writtenCharacters = writtenText.length() + 1;

  if (easyModeActive || normalModeActive) {
    beatsPerMinute.x = width / 2 - 306; 
    beatsPerMinute.y = height - 433; 
    charactersToWriteBox.x = width / 2 - 306; 
    charactersToWriteBox.y = height - 387; 
    writtenCharactersBox.x = width / 2; 
    writtenCharactersBox.y = height - 387; 
    time.x = width / 2; 
    time.y = height - 433; 
    percentageOfCompletion.x = width / 2 + 306; 
    percentageOfCompletion.y = height - 433; 
    percentageOfCorrectText.x =width / 2 + 306; 
    percentageOfCorrectText.y = height - 387;
  } else if (hardModeActive) {
    beatsPerMinute.x = width / 2 - 306; 
    beatsPerMinute.y = height - 123; 
    charactersToWriteBox.x = width / 2 - 306; 
    charactersToWriteBox.y = height - 77; 
    writtenCharactersBox.x = width / 2; 
    writtenCharactersBox.y = height - 77; 
    time.x = width / 2; 
    time.y = height - 123; 
    percentageOfCompletion.x = width / 2 + 306; 
    percentageOfCompletion.y = height - 123; 
    percentageOfCorrectText.x =width / 2 + 306; 
    percentageOfCorrectText.y = height - 77;
  }
  beatsPerMinute.text = "BEATS/MINUTE: " + beats / (second + 1) * 60;
  charactersToWriteBox.text = "CHARACTERS TO WRITE: " + charactersToWrite;
  writtenCharactersBox.text = "WRITTEN CHARACTERS: " + writtenCharacters;
  time.text = "TIME: " + second; 
  percentageOfCompletion.text = "COMPLETION: " + int(writtenCharacters * 100 / charactersToWrite) + "%";
  percentageOfCorrectText.text = "CORRECT TEXT:" + int(correctText.length() * 200 / writtenText.length()) + "%";
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
    } else if (progressMenuOpened && progressMenuVisibility != 300) {
      progressMenuVisibility += transitionSpeed;
    }
  } else if (mainMenuOpened && mainMenuVisibility == 0 && backMenuVisibility != 0) {
    backMenuVisibility -= transitionSpeed;
    if (!settingsMenuOpened && settingsMenuVisibility != 0) {
      settingsMenuVisibility -= transitionSpeed;
    }
    if (!startMenuOpened && startMenuVisibility != 0) {
      startMenuVisibility -= transitionSpeed;
    }
    if (!progressMenuOpened && progressMenuVisibility != 0) {
      progressMenuVisibility -= transitionSpeed;
    }
  }
}
