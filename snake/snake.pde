int gridSize = 20;
int gridWidth, gridHeight;
int snakeLength = 1;
int[] snakeX, snakeY;
int foodX, foodY;
int direction = 1; // 0: up, 1: right, 2: down, 3: left
int gameState = 0; // 0: start screen, 1: playing, 2: game over, 3: win
int applesEaten = 0;

void setup() {
  size(800, 800);
  frameRate(10);
  gridWidth = width / gridSize;
  gridHeight = height / gridSize;
  snakeX = new int[gridWidth * gridHeight];
  snakeY = new int[gridWidth * gridHeight];
  snakeX[0] = gridWidth / 2;
  snakeY[0] = gridHeight / 2;
  spawnFood();
}

void draw() {
  background(0);
  switch (gameState) {
    case 0:
      drawStartScreen();
      break;
    case 1:
      moveSnake();
      checkCollision();
      eatFood();
      drawSnake();
      drawFood();
      break;
    case 2:
      drawGameOverScreen();
      break;
    case 3:
      drawWinScreen();
      break;
  }
}

void keyPressed() {
  if (gameState == 0 || gameState == 2 || gameState == 3) {
    if (key == ' ') {
      resetGame();
      gameState = 1;
    }
  } else if (gameState == 1) {
    if (keyCode == UP && direction != 2) direction = 0;
    else if (keyCode == RIGHT && direction != 3) direction = 1;
    else if (keyCode == DOWN && direction != 0) direction = 2;
    else if (keyCode == LEFT && direction != 1) direction = 3;
  }
}

void resetGame() {
  snakeLength = 1;
  direction = 1;
  applesEaten = 0;
  snakeX[0] = gridWidth / 2;
  snakeY[0] = gridHeight / 2;
  spawnFood();
}

void moveSnake() {
  for (int i = snakeLength - 1; i > 0; i--) {
    snakeX[i] = snakeX[i - 1];
    snakeY[i] = snakeY[i - 1];
  }
  if (direction == 0) snakeY[0]--;
  else if (direction == 1) snakeX[0]++;
  else if (direction == 2) snakeY[0]++;
  else if (direction == 3) snakeX[0]--;
}

void checkCollision() {
  if (snakeX[0] < 0 || snakeX[0] >= gridWidth || snakeY[0] < 0 || snakeY[0] >= gridHeight) {
    gameState = 2;
  }
  for (int i = 1; i < snakeLength; i++) {
    if (snakeX[0] == snakeX[i] && snakeY[0] == snakeY[i]) {
      gameState = 2;
    }
  }
}

void eatFood() {
  if (snakeX[0] == foodX && snakeY[0] == foodY) {
    snakeLength++;
    applesEaten++;
    if (applesEaten >= 10) {
      gameState = 3;
    } else {
      spawnFood();
    }
  }
}

void spawnFood() {
  boolean valid;
  do {
    valid = true;
    foodX = int(random(gridWidth));
    foodY = int(random(gridHeight));
    for (int i = 0; i < snakeLength; i++) {
      if (foodX == snakeX[i] && foodY == snakeY[i]) {
        valid = false;
        break;
      }
    }
  } while (!valid);
}

void drawSnake() {
  fill(255);
  for (int i = 0; i < snakeLength; i++) {
    rect(snakeX[i] * gridSize, snakeY[i] * gridSize, gridSize, gridSize);
  }
}

void drawFood() {
  fill(255, 0, 0);
  rect(foodX * gridSize, foodY * gridSize, gridSize, gridSize);
}

void drawStartScreen() {
  textAlign(CENTER, CENTER);
  textSize(48);
  fill(255);
  text("Snake Game", width / 2, height / 2 - 100);
  textSize(24);
  text("Press SPACE to start", width / 2, height / 2);
}

void drawGameOverScreen() {
  textAlign(CENTER, CENTER);
  textSize(48);
  fill(255);
  text("Game Over", width / 2, height / 2 - 100);
  textSize(24);
  text("Press SPACE to restart", width / 2, height / 2);
}

void drawWinScreen() {
  textAlign(CENTER, CENTER);
  textSize(48);
  fill(255);
  text("You Win!", width / 2, height / 2 - 100);
  textSize(24);
  text("Press SPACE to restart", width / 2, height / 2);
}
