void mainMenu() { //<>//
  start.show(mainMenuVisibility);
  startButtonClicked();

  settings.setData(width/2, height/2, 250, 75);
  settings.show(mainMenuVisibility);
  settingsButtonClicked();

  progress.show(mainMenuVisibility);
  progressButtonClicked();
}

void startMenu() {
  if (easyModeActive) {
    keyboard.staticShow(startMenuVisibility);
    textToWrite.selfHeight = 275;
    textToWrite.y = 275 / 2 + 25;
    indicatorsBar.y = height - (3 * 60 + 230);
    keyboard();
  } else if (normalModeActive) {
    keyboard.staticShow(startMenuVisibility);
    textToWrite.selfHeight = 275;
    textToWrite.y = 275 / 2 + 25;
    indicatorsBar.y = height - (3 * 60 + 230);
    keyboard();
  } else if (hardModeActive) {
    textToWrite.selfHeight = 580;
    textToWrite.y = 320;
    indicatorsBar.y = height - 100;
  }  
  textToWrite.staticShow(startMenuVisibility);
  indicatorsBar.staticShow(startMenuVisibility);

  exercise();
}

void settingsMenu() {
  settings.setData(width/2, height/2-200, 300, 90);
  settings.setColors(#0021F0, #0021F0, #F021FF);

  settings.staticShow(settingsMenuVisibility);
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
    currentMode.setCoordinates(640, 50);
    currentUser.setCoordinates(900, 50);
  } else if (mainMenuOpened && progressMenuVisibility == 0) {  
    currentMode.setCoordinates(width / 2, height / 2 + 164);
    currentUser.setCoordinates(width / 2, height / 2 + 218);
  }

  if (((!mainMenuOpened && settingsMenuOpened) || (mainMenuOpened && !settingsMenuOpened)) && (startMenuVisibility == 0 && progressMenuVisibility == 0)) {
    currentMode.staticShow(300);
    currentUser.staticShow(300);
  } else if (progressMenuOpened) {
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
    keyPressed = false;
    delay(100);
  }
  if (exerciseActive) {
    textAlign(LEFT, CENTER);
    textSize(25);

    if (keyPressed) {
      writtenText += key;
      if (key == unwrittenText.charAt(writtenText.length() - 1)) {
        correctText += key;
        wrongText += '░';
      } else {
        correctText += '░';
        wrongText += key;
      }

      String test = unwrittenText;
      unwrittenText = " ";
      for (int i = 1; i < writtenText.length(); i++) unwrittenText += ' ';          
      if (writtenText.length() < test.length()) unwrittenText += test.substring(writtenText.length());

      beats++;
      keyPressed = false;
      delay(100);
    }

    fill(200, 200, 200, startMenuVisibility);
    matrix = assignText(unwrittenText);
    display();
    if (easyModeActive) {
      fill(0, 255, 0, startMenuVisibility);
      matrix = assignText(correctText);
      display();
      fill(255, 0, 0, startMenuVisibility);
      matrix = assignText(wrongText);
      display();
    } else {
      fill(0, 0, 0, startMenuVisibility);
      matrix = assignText(writtenText);
      display();
    }
    textAlign(CENTER, CENTER);

    indicators();

    if (writtenText.length() > unwrittenText.length() - 1 && exerciseActive) {
      exerciseActive = false;
      textToWrite.text = "[Exercise is over! Good job!]";
      textToWrite.staticShow(300);
      writtenText = " ";
      correctText = " ";
      wrongText = " ";
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
    beatsPerMinute.setCoordinates(width / 2 - 306, height - 433);
    charactersToWriteBox.setCoordinates(width / 2 - 306, height - 387);
    writtenCharactersBox.setCoordinates(width / 2, height - 387);
    time.setCoordinates(width / 2, height - 433);
    percentageOfCompletion.setCoordinates(width / 2 + 306, height - 433);
    percentageOfCorrectText.setCoordinates(width / 2 + 306, height - 387);
  } else if (hardModeActive) {
    beatsPerMinute.setCoordinates(width / 2 - 306, height - 123);
    charactersToWriteBox.setCoordinates(width / 2 - 306, height - 77);
    writtenCharactersBox.setCoordinates(width / 2, height - 77);
    time.setCoordinates(width / 2, height - 123);
    percentageOfCompletion.setCoordinates(width / 2 + 306, height - 123);
    percentageOfCorrectText.setCoordinates(width / 2 + 306, height - 77);
  }

  int charactersToWrite = unwrittenText.length(), writtenCharacters = writtenText.length(), correctCharacters = 0, wrongCharacters = 0;
  for (int i = 0; i < writtenText.length(); i++) {
    if (correctText.charAt(i) != '░') {
      correctCharacters++;
    } else if (wrongText.charAt(i) != '░') {
      wrongCharacters++;
    }
  }

  if (beats != 0 && second != 0 && charactersToWrite != 0 && writtenCharacters != 0 /*&& correctCharacters != 0 && wrongCharacters != 0*/) {
    beatsPerMinute.text = "BEATS/MINUTE: " + int(beats * 60 / second);
    charactersToWriteBox.text = "CHARACTERS TO WRITE: " + charactersToWrite;
    writtenCharactersBox.text = "WRITTEN CHARACTERS: " + writtenCharacters;
    time.text = "TIME: " + second; 
    percentageOfCompletion.text = "COMPLETION: " + int((writtenCharacters * 100) / charactersToWrite) + "%";
    percentageOfCorrectText.text = "CORRECT TEXT:" + int((correctCharacters * 100) / writtenCharacters) + "%";
  }

  beatsPerMinute.staticShow(startMenuVisibility);
  charactersToWriteBox.staticShow(startMenuVisibility);
  writtenCharactersBox.staticShow(startMenuVisibility);
  time.staticShow(startMenuVisibility);
  percentageOfCompletion.staticShow(startMenuVisibility);
  percentageOfCorrectText.staticShow(startMenuVisibility);
}

char[][] assignText(String text) {
  char[][] array = new char[MAX_ROWS][MAX_COLUMNS];
  int row = 0, index = 0;
  for (int column = 0; column < MAX_COLUMNS && row < MAX_ROWS; column++) {
    if (index < text.length()) {
      array[row][column] = text.charAt(index);
    } else {
      array[row][column] = '░';
    }
    if (column == MAX_COLUMNS - 1 && row < MAX_ROWS - 1) {
      row++;
      column = -1;
    }
    index++;
  }
  return array;
}

void display() {
  textAlign(CENTER, CENTER);
  for (int i = 0; i < MAX_ROWS; i++) {
    for (int j = 0; j < MAX_COLUMNS; j++) {
      if (matrix[i][j] != '░') {
        text(matrix[i][j], 249 + j * 10, 65 + i * 27);
      }
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
