// Paddle
Paddle paddle; // Declare a Paddle object

//Balls
ArrayList<Ball> balls = new ArrayList<Ball>(); // List to hold multiple balls
ArrayList<Ball> ballsToRemove = new ArrayList<Ball>();  // List of balls to be removed after the update
int nextBallSpawnTime = 0;  // Next time to spawn a ball

//Score Stuff
int lives = 10;  // Start with 10 lives
boolean gameOver = false;  // Track if the game is over

//Power Ups
ArrayList<PowerUp> powerUps = new ArrayList<PowerUp>();  // List of power-ups
PowerUp currentPowerUp = null;  // Currently active power-up
boolean powerUpUsed = false;  // Flag to check if the power-up was used
boolean stopTimeActive = false;  // Flag for Stop Time power-up
int slowBallsTime = 0;  // Time left for slow balls power-up
int livesBeforeClear = lives;  // Store lives before Clear Balls power-up
int powerUpTimer = 0;  // Timer to track elapsed time for spawning power-ups
int powerUpCooldown = 7000;  // Time in milliseconds between power-up spawns (15 seconds)
String currentAbility = "No ability";  // Track the current ability

//Wall stuff
ArrayList<Wall> walls = new ArrayList<Wall>();  // List of walls spawned in the game
ArrayList<Wall> wallsToRemove = new ArrayList<Wall>();

void setup() {
  size(400, 400); // Set canvas size to 400x400 pixels
  // Add a few balls with random speeds and positions
  balls.add(new Ball());
  paddle = new Paddle(); // Create the Paddle object
}

void draw() {
  fill(0); // Set fill color to black
  background(255); // Set the background to white

  // Check if the game is over
  if (gameOver) {
    fill(255, 0, 0);  // Set text color to red
    textSize(32);
    text("Game Over", width / 2 - 100, height / 2);
    fill(0);
    textSize(16);
    text("Press 'R' to Restart", width / 2 - 85, height / 2 + 40);  // Prompt to restart
    return;  // Stop the game when it's over
  }

  // Display lives remaining
  fill(0);
  textSize(16);
  text("Lives: " + lives, 10, 20);  // Show lives in the top-left corner

  // Spawn a new ball between 7-15 seconds
  if (millis() > nextBallSpawnTime) {
    balls.add(new Ball());
    nextBallSpawnTime = millis() + int(random(5000, 10000));  // Schedule next ball spawn
  }

  // Use a standard for loop with an index
  for (int i = balls.size() - 1; i >= 0; i--) {
    Ball ball = balls.get(i);
    ball.update();  // Update ball's position and behavior
    ball.display();  // Display the ball

    // Despawn (remove) the ball if its lifetime has passed
    if (ball.shouldDespawn()) {
      balls.remove(i);  // Safely remove the ball by index
    }
    // Check if the ball passed the paddle
    else if (ball.passedPaddle()) {
      balls.remove(i);  // Remove the ball
      lives--;  // Decrease lives by 1

      // Check if lives have run out
      if (lives <= 0) {
        gameOver = true;  // Set gameOver flag to true
      }
    }
  }
  paddle.update(); // Update the paddle's position
  paddle.display(); // Display the paddle

  // Display the walls spawned by the wall power-up
  for (Wall w : walls) {
    w.display();  // Draw each wall
        if (w.shouldDespawn()) {
      wallsToRemove.add(w);  // Add wall to removal list if its lifespan is over
    }
  }
  
  // Remove walls that should despawn
  for (Wall w : wallsToRemove) {
    walls.remove(w);  // Remove the wall from the walls list
  }
  wallsToRemove.clear();  // Clear the removal list

  // Handle the power-up if it exists
  if (currentPowerUp != null) {
    currentPowerUp.update();
    //currentPowerUp.display();

    // Check if the power-up has been collected
    if (currentPowerUp.collected) {
      powerUpUsed = false;  // Reset the flag so a new power-up can spawn
      currentPowerUp = null;  // Remove the collected power-up
      currentAbility = "No ability";  // Reset ability text
    }
    // If the power-up reaches the bottom of the screen, allow a new one to spawn
    else if (currentPowerUp.y >= 405) {
      powerUpUsed = false;  // Reset flag to allow new power-up
      currentPowerUp = null;  // Remove the current power-up
      currentAbility = "No ability";  // Reset ability text
    }
  }

  // Power-up timer to spawn a new power-up every 15 seconds
  powerUpTimer += millis() - lastMillis;
  lastMillis = millis();

  if (powerUpTimer >= powerUpCooldown) {
    spawnPowerUp();  // Spawn the power-up after 15 seconds
    powerUpTimer = 0;  // Reset the timer
  }

  // If Stop Time is active, pause ball movement
  if (stopTimeActive) {
    stopTimeActive = false;
    currentAbility = "Stop Time";  // Set the active ability text
  }

  // Slow down balls for a specific time
  if (slowBallsTime > 0) {
    slowBallsTime--;
    if (slowBallsTime == 0) {
      for (Ball ball : balls) {
        ball.speedX /= 0.5;  // Restore the ball's normal speed
        ball.speedY /= 0.5;
      }
      currentAbility = "No ability";  // Reset ability text when the effect ends
    }
  }

  // Display the current ability text on screen
  fill(0);
  textSize(16);
  if (currentPowerUp != null && !powerUpUsed) {
    if (currentPowerUp.type.equals("stopTime")) {
      currentAbility = "Stop Time";  // Set the active ability text
    } else if (currentPowerUp.type.equals("spawnWall")) {
      currentAbility = "Spawn Wall";  // Set the active ability text
    } else if (currentPowerUp.type.equals("slowBalls")) {
      currentAbility = "Slow Balls";  // Set the active ability text
    } else if (currentPowerUp.type.equals("plusLife")) {
      currentAbility = "Plus 1 Life";  // Set the active ability text
    } else if (currentPowerUp.type.equals("clearBalls")) {
      currentAbility = "Clear Balls";  // Set the active ability text
    }
    text("Current Ability: " + currentAbility, 10, 30);  // Display at top-left corner
  }
}

void keyPressed() {
  // Restart the game when 'R' is pressed
  if (key == 'r' || key == 'R') {
    resetGame();
  }
  if (key == ' ') {  // Space bar to use power-up
    if (currentPowerUp != null && !powerUpUsed) {
      if (currentPowerUp.type.equals("stopTime")) {
        stopTimeActive = true;
        powerUpUsed = true;
        currentAbility = "Stop Time";  // Set the active ability text
      } else if (currentPowerUp.type.equals("spawnWall")) {
        // Spawn a wall at the mouse position
        walls.add(new Wall(mouseX - 50, mouseY));  // Subtract 50 to center the wall on the cursor
        powerUpUsed = true;
        currentAbility = "Spawn Wall";  // Set the active ability text
      } else if (currentPowerUp.type.equals("slowBalls")) {
        for (Ball ball : balls) {
          ball.speedX *= 0.5;  // Slow down all balls
          ball.speedY *= 0.5;
        }
        slowBallsTime = 600;  // Set slow balls power-up duration (10 seconds)
        powerUpUsed = true;
        currentAbility = "Slow Balls";  // Set the active ability text
      } else if (currentPowerUp.type.equals("plusLife")) {
        lives += 1;  // Add 1 life
        powerUpUsed = true;
        currentAbility = "Plus 1 Life";  // Set the active ability text
      } else if (currentPowerUp.type.equals("clearBalls")) {
        balls.clear();  // Clear all balls
        powerUpUsed = true;
        currentAbility = "Clear Balls";  // Set the active ability text
      }
    }
  }
}

// Timer variable to track the time since the last power-up spawn
int lastMillis = 0;  // Variable to store the last time millis() was called

void spawnPowerUp() {
  if (currentPowerUp == null) {
    currentPowerUp = new PowerUp();
  }
}

void resetGame() {
  // Reset game variables
  lives = 10;  // Reset lives to 10
  gameOver = false;  // Reset gameOver flag
  balls.clear();  // Clear all existing balls
  nextBallSpawnTime = millis() + int(random(1000, 3000));  // Schedule next ball spawn
}
