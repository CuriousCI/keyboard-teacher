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

  currentData();
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
    textToWrite.selfHeight = 580;
    textToWrite.y = 320;
    textToWrite.staticShow(startMenuVisibility);
    indicatorsBar.y = height - 100;
    indicatorsBar.staticShow(startMenuVisibility);
  }
  exercise();
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

void currentData() {
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

  if (progressMenuOpened && mainMenuVisibility == 0) {
    currentMode.x = 640; 
    currentMode.y = 50; 
    currentUser.x = 900; 
    currentUser.y = 50;
  } else if (mainMenuOpened && progressMenuVisibility == 0) {
    currentMode.x = width / 2; 
    currentMode.y = height / 2 + 164; 
    currentUser.x = width / 2; 
    currentUser.y = height / 2 + 218;
  }

  if (((!mainMenuOpened && settingsMenuOpened) || (mainMenuOpened && !settingsMenuOpened)) && (startMenuVisibility == 0 && progressMenuVisibility == 0)) {
    currentMode.staticShow(300);
    currentUser.staticShow(300);
  } else {
    currentMode.staticShow(mainMenuVisibility + settingsMenuVisibility + progressMenuVisibility);
    currentUser.staticShow(mainMenuVisibility + settingsMenuVisibility + progressMenuVisibility);
  }
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

void exercise() {
  if (keyPressed && !exerciseActive && exerciseActivable) {
    exerciseActive = true;
    exerciseActivable = false;
    textToWrite.text = "";
    frame = 0;
  }
  if (exerciseActive) {
    textAlign(LEFT, CENTER);
    textSize(25);
    textX = width / 2 - 925 / 2 + 14; 
    unwrittenText[line] = "Ciao questo e un testo casuale per testare la funzionalita del programma";
    textSize(22);
    if (keyPressed) {
      writtenText[line] += key;
      correctText[line] += key;
      wrongText[line] += key;
      String strangeText = unwrittenText[line];
      unwrittenText[line] = " ";
      for (int i = 0; i < writtenText[line].length(); i++) {
        unwrittenText[line] += " ";
      }
      if (writtenText[line].length() < strangeText.length()) {
        unwrittenText[line] += strangeText.substring(writtenText[line].length());
      }
      if (textWidth(writtenText[line]) > 890) line++;
      beats++;
      keyPressed = false;
      delay(100);
    }
    for (int i = 0; i <= line; i++) {
      fill(200, 200, 200, startMenuVisibility);
      text(unwrittenText[i], textX, textY  + i * 28);
      if (easyModeActive) {
        fill(0, 255, 0, startMenuVisibility);
        text(correctText[i], textX - 5, textY  + i * 28);
        fill(255, 0, 0, startMenuVisibility);
        text(wrongText[i], textX - 5, textY  + i * 28);
      } else {
        fill(0, 0, 0, startMenuVisibility);
        text(writtenText[i], textX - 5, textY + i * 28);
      }
    }
    textAlign(CENTER, CENTER);

    indicators();
    if (writtenText[line].length() > unwrittenText[line].length() + 1 && exerciseActive) {
      exerciseActive = false;
      textToWrite.text = "[Exercise is over! Good job!]";
      for (int i = 0; i <= line; i++) {
        writtenText[i] = " ";
      }
      line = 0;
      textToWrite.staticShow(300);
    }
  }
}

void indicators() {
  frame++;
  if (frame >= int(frameRate)) {
    second++;
    frame = 0;
  }
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

  charactersToWrite = 0;
  writtenCharacters = 0;
  correctCharacters = 0;
  wrongCharacters = 0;
  for (int i = 0; i < MAX_LINES; i++) {
    charactersToWrite += unwrittenText[i].length() - writtenText[i].length();
    writtenCharacters += writtenText[i].length();
    correctCharacters += correctText[i].length();
    wrongCharacters += wrongText[i].length();
  }

  if (beats != 0 && second != 0 && charactersToWrite != 0 && writtenCharacters != 0 && correctCharacters != 0 && wrongCharacters != 0) {
    beatsPerMinute.text = "BEATS/MINUTE: " + int(beats * 60 / second);
    charactersToWriteBox.text = "CHARACTERS TO WRITE: " + charactersToWrite;
    writtenCharactersBox.text = "WRITTEN CHARACTERS: " + writtenCharacters;
    time.text = "TIME: " + second; 
    percentageOfCompletion.text = "COMPLETION: " + int(writtenCharacters * 100 / charactersToWrite) + "%";
    percentageOfCorrectText.text = "CORRECT TEXT:" + int(correctCharacters * 100 / writtenCharacters) + "%";
  }

  beatsPerMinute.staticShow(startMenuVisibility);
  charactersToWriteBox.staticShow(startMenuVisibility);
  writtenCharactersBox.staticShow(startMenuVisibility);
  time.staticShow(startMenuVisibility);
  percentageOfCompletion.staticShow(startMenuVisibility);
  percentageOfCorrectText.staticShow(startMenuVisibility);
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
