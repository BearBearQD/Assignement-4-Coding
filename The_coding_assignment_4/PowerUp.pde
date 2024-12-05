class PowerUp {
  float x, y;  // Position of the power-up
  float radius = 15;  // Power-up radius
  String type;  // Type of the power-up (stopTime, spawnWall, slowBalls, plusLife, clearBalls)
  boolean collected = false;  // Whether the power-up has been collected

  // Constructor for the PowerUp
  PowerUp() {
    // Randomly assign a type to the power-up
    x = random(width);  // Random horizontal position
    y = 0;  // Start at the top of the screen
    type = randomPowerUp();  // Randomly assign a power-up type
  }

  // Randomly assign a power-up type
  String randomPowerUp() {
    String[] powerUpTypes = {"stopTime", "spawnWall", "slowBalls", "plusLife", "clearBalls"};
    return powerUpTypes[int(random(powerUpTypes.length))];
  }

  // Update the position of the power-up (falling from the sky)
  void update() {
    y += 2;  // Fall down with speed 2

    // Check if the power-up has been collected by the paddle
    if (dist(x, y, paddle.x + paddle.w / 2, paddle.y) < radius + paddle.h / 2) {
      collected = true;  // Mark it as collected
    }
  }

  // Display the power-up
  void display() {
    if (!collected) {
      if (type.equals("stopTime")) {
        fill(255, 0, 255);  // Magenta for Stop Time
      } else if (type.equals("spawnWall")) {
        fill(0, 255, 255);  // Cyan for Spawn Wall
      } else if (type.equals("slowBalls")) {
        fill(0, 255, 0);  // Green for Slow Balls
      } else if (type.equals("plusLife")) {
        fill(255, 255, 0);  // Yellow for Plus 1 Life
      } else if (type.equals("clearBalls")) {
        fill(255, 165, 0);  // Orange for Clear All Balls
      }
      ellipse(x, y, radius * 2, radius * 2);  // Draw the power-up
    }
  }
}
