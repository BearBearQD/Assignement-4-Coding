Paddle paddle; // Declare a Paddle object
ArrayList<Ball> balls = new ArrayList<Ball>(); // List to hold multiple balls
ArrayList<Ball> ballsToRemove = new ArrayList<Ball>();  // List of balls to be removed after the update
int nextBallSpawnTime = 0;  // Next time to spawn a ball
int lives = 10;  // Start with 10 lives
boolean gameOver = false;  // Track if the game is over

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
    nextBallSpawnTime = millis() + int(random(7000, 15000));  // Schedule next ball spawn
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
}

void keyPressed() {
  // Restart the game when 'R' is pressed
  if (key == 'r' || key == 'R') {
    resetGame();
  }
}

void resetGame() {
  // Reset game variables
  lives = 10;  // Reset lives to 10
  gameOver = false;  // Reset gameOver flag
  balls.clear();  // Clear all existing balls
  nextBallSpawnTime = millis() + int(random(7000, 15000));  // Schedule next ball spawn
}
