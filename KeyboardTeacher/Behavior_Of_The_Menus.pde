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
  if (exerciseActive) textToWrite.setColors(50, #E3E3E3, 1000); 
  else textToWrite.setColors(50, #E3E3E3, 20);

  textToWrite.staticShow(startMenuVisibility);
  indicatorsBar.staticShow(startMenuVisibility);

  if ((exerciseActive || (!exerciseActive && !exerciseActivable)) && restartExerciseButtonVisibility != 300) {
    restartExerciseButtonVisibility += transitionSpeed;
  } else if (!exerciseActive && restartExerciseButtonVisibility != 0) {
    restartExerciseButtonVisibility -= transitionSpeed;
  }
  restartExerciseButtonClicked();
  restartExercise.show(restartExerciseButtonVisibility);

  exercise();
}

void settingsMenu() {
  easyMode.show(settingsMenuVisibility);
  easyModeButtonClicked();
  normalMode.show(settingsMenuVisibility);
  normalModeButtonClicked();
  hardMode.show(settingsMenuVisibility);
  hardModeButtonClicked();
  selectText.show(settingsMenuVisibility);
}

void progressMenu() {
  addUserButtonClicked();
  addUser.show(progressMenuVisibility);
  removeUser.show(progressMenuVisibility);

  for (int i = 0; i < everySingleUser.length; i++) {
    everySingleUser[i].show(progressMenuVisibility);
  }

  if (userNameWritable && userNameBoxVisibility != 300) {
    userNameBoxVisibility += transitionSpeed;
  } else if (!userNameWritable && userNameBoxVisibility != 0) {
    userNameBoxVisibility -= transitionSpeed;
  }


  if (userNameWritable) {
    textSize(userNameBox.textSize);
    if (keyPressed) {
      if (key == ENTER) {
        String[] TEST = new String[1];
        TEST[0] = "CREATION Date " + day() + "/" + month() + "/" + year() + "  Hour " + hour() + ":" + minute() + ":" + second();

        saveStrings((userName + ".txt"), TEST);
        users = append(users, userName);
        saveStrings("Users.txt", users);

        everySingleUser = new Button[users.length];
        for (int i = 0; i < everySingleUser.length; i++) {
          everySingleUser[i] = new Button(165, 150 + i * 60, 250, 50, users[i]);
          everySingleUser[i].edgeRoundness = 7;
        }

        userNameWritable = false;
        userName = "";
        userNameBox.text = userName;
      }
      if (key == BACKSPACE && userName.length() > 0) {
        userName = userName.substring(0, userName.length() - 1);
      } else if (key != CODED && key != '\t' && key != '\n' && key != '\b' && key != 'f' && key != '\r' && key != '.' && key != '?' && textWidth(userNameBox.text) < userNameBox.selfWidth - 60) {
        userName += key;
      }
      userNameBox.text = userName;
      keyPressed = false;
      //delay(75);
    }
  }
  userNameBox.staticShow(userNameBoxVisibility);

  for (int i = 0; i < everySingleUser.length; i++) {
    if (everySingleUser[i].selfClicked(progressMenuOpened)) {
      currentUser.text = "user: " + everySingleUser[i].text;
      setting[1] = everySingleUser[i].text;
      saveStrings("Settings.txt", setting);
      delay(100);
    }
  }
}

void currentData() {
  if (easyModeActive) {
    currentMode.text = "mode: [EASY]";
  } else if (normalModeActive) {
    currentMode.text = "mode: [NORMAL]";
  } else if (hardModeActive) {
    currentMode.text = "mode: [HARD]";
  }

  currentMode.textSize = currentMode.selfWidth / currentMode.text.length() * 2; 
  currentUser.textSize = currentUser.selfWidth / currentUser.text.length() * 2; 

  currentMode.setCoordinates(width - 50 - close.selfWidth - 10 - currentMode.selfWidth / 2, 50 + currentMode.selfHeight / 2);
  currentUser.setCoordinates(width - 50 - close.selfWidth - 10 - currentMode.selfWidth - 10 - currentUser.selfWidth / 2, 50 + currentUser.selfHeight / 2);

  if (((!mainMenuOpened && settingsMenuOpened || progressMenuOpened) || (mainMenuOpened && !settingsMenuOpened && !progressMenuOpened)) && startMenuVisibility == 0) {
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
    for (int i = 0; i < keysOfKeyboard.length; i++) {
      if (keysOfKeyboard[i].text.charAt(0) == unwrittenText.charAt(writtenText.length()) && keysOfKeyboard[i].text.length() == 1 /*&& keyPressed == false*/ && exerciseActive) {
        keysOfKeyboard[i].setColors(0, 0, 255);
        keysOfKeyboard[i].staticShow(startMenuVisibility);
      } else {
        int currentLayer = 0;
        if (keysOfKeyboard[i].layer == currentLayer) {
          keysOfKeyboard[i].show(startMenuVisibility);
        }
        if (key != CODED) currentLayer = 1; 
        else if (keyCode == SHIFT && keyPressed) currentLayer = 2; 
        else currentLayer = 1;
        if (keysOfKeyboard[i].layer == currentLayer) {
          keysOfKeyboard[i].show(startMenuVisibility);
        }
        if (keysOfKeyboard[i].layer == currentLayer) {
          keysOfKeyboard[i].show(startMenuVisibility);
        }
      }
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
  }

  if (exerciseActive) {
    textAlign(LEFT, CENTER);
    textSize(25);
    textToWrite.text = "";
    if (keyPressed && key != '\t' && keyCode != SHIFT && keyCode != CONTROL && keyCode != BACKSPACE && keyCode != ENTER && keyCode != RETURN) {
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
    }

    matrix = assignText(unwrittenText);
    display(color(200, 200, 200, startMenuVisibility));
    if (easyModeActive) {     
      matrix = assignText(correctText);
      display(color(0, 255, 0, startMenuVisibility));
      matrix = assignText(wrongText);
      display(color(255, 0, 0, startMenuVisibility));
    } else {
      matrix = assignText(writtenText);
      display(color(0, 0, 0, startMenuVisibility));
    }
    textAlign(CENTER, CENTER);

    indicators();

    if (writtenText.length() >= unwrittenText.length() && exerciseActive) {
      exerciseActive = false;
      exerciseActivable = false;

      String[] ses = loadStrings(currentUser.text.substring(6) + ".txt");
      ses = append(ses, "Date " + day() + "/" + month() + "/" + year() + "  Hour " + hour() + ":" + minute() + ":" + second() + " " + textToWrite.text);
      saveStrings(currentUser.text.substring(6) + ".txt", ses);
      textToWrite.text += " \n[EXERCISE IS OVER, GOOD JOB!]";
      textToWrite.staticShow(300);

      unwrittenText = sentences[int(random(0, sentences.length - 1))];
      writtenText = "";
      correctText = "";
      wrongText = "";
    }
  }
}

void indicators() {  
  frame++;
  if (frame >= int(frameRate) || second == 0) {
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

  int charactersToWrite = unwrittenText.length(), writtenCharacters = writtenText.length(), correctCharacters = 0;
  for (int i = 0; i < writtenText.length(); i++) {
    if (correctText.charAt(i) != '░') {
      correctCharacters++;
    }
  }

  if (writtenCharacters == 0) {
    writtenCharacters = 1;
  }  
  beatsPerMinute.text = "BEATS/MINUTE: " + int(beats * 60 / second);
  percentageOfCompletion.text = "COMPLETION: " + int((writtenCharacters * 100) / charactersToWrite) + "%";
  percentageOfCorrectText.text = "CORRECT TEXT: " + int((correctCharacters * 100) / writtenCharacters) + "%";
  writtenCharactersBox.text = "WRITTEN CHARACTERS: " + writtenCharacters;
  charactersToWriteBox.text = "CHARACTERS TO WRITE: " + charactersToWrite;
  time.text = "TIME: " + second; 

  textToWrite.text = beatsPerMinute.text + " \n" + writtenCharactersBox.text + " \n" + time.text + " \n" + percentageOfCorrectText.text;

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

void display(color textFill) {
  textAlign(CENTER, CENTER);
  int index = 0;
  for (int i = 0; i < MAX_ROWS; i++) {
    for (int j = 0; j < MAX_COLUMNS; j++) {
      if (matrix[i][j] != '░') {
        fill(250);
        stroke(250);
        if (index < writtenText.length()) rect(249 + j * 10, 65 + i * 27, 10, 27, 2);
        fill(textFill);
        text(matrix[i][j], 249 + j * 10, 65 + i * 27);
        index++;
      }
    }
  }
}

void resetText() {
  textToWrite.text = "[press a key to start]";
  unwrittenText = sentences[int(random(0, sentences.length - 1))];
  writtenText = "";
  correctText = "";
  wrongText = "";
  beats = 0;
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
    } else if (exerciseActive && restartExerciseButtonVisibility != 300) {
      restartExerciseButtonVisibility += transitionSpeed;
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
    if (!exerciseActive && restartExerciseButtonVisibility != 0) {
      restartExerciseButtonVisibility -= transitionSpeed;
    }
  }
}
