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
    if (dist(x, y, paddle.position.x + paddle.size.x / 2, paddle.position.y) < radius + paddle.size.y / 2) {
      collected = true;  // Mark it as collected
    }
  }
}
