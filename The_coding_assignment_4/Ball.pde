class Ball {
  float x, y;  // Ball position
  float speedX, speedY;  // Ball speed in both directions
  float radius = 10;  // Ball radius
  int spawnTime;  // Time when the ball was spawned
  int lifetime;   // Randomly decided lifetime for the ball (between 30-45 seconds)
  
  // Constructor to initialize ball with random properties
  Ball() {
    x = random(20,380);  // Random horizontal position
    y = random(100, 200);  // Random vertical position
    speedX = random(2, 4);  // Random horizontal speed
    speedY = random(2, 4);  // Random vertical speed
    
    spawnTime = millis();  // Store the spawn time
    lifetime = int(random(15000, 20000));  // Lifetime between 30-45 seconds
  }
  
  // Update the ball's position and handle collisions
  void update() {
    // Move the ball by its speed
    x += speedX;
    y += speedY;
    
    // Bounce off left and right walls
    if (x - radius <= 0 || x + radius >= width) {
      speedX *= -1;  // Reverse horizontal direction
    }
    
    // Bounce off top wall
    if (y - radius <= 0) {
      speedY *= -1;  // Reverse vertical direction
    }
    
    // Bounce off paddle
    if (y + radius >= paddle.y && x >= paddle.x && x <= paddle.x + paddle.w) {
      speedY *= -1;  // Reverse vertical direction after hitting the paddle
      speedX += random(-1, 1);  // Slight random horizontal speed change for variation
      
      // Special behavior: increase speed after bounce
      speedX *= 1.1;
      speedY *= 1.1;
      
      // Random chance to split the ball after bouncing
      if (random(1) < 0.1) {
        balls.add(new Ball());  // Create a new ball when this one bounces
      }
    }
  }
  
  // Display the ball
  void display() {
    fill(255, 0, 0);  // Set the ball color to red
    ellipse(x, y, radius * 2, radius * 2);  // Draw the ball
  }
  
  // Check if the ball has passed the paddle and fallen off the screen
  boolean passedPaddle() {
    return y - radius > height;  // If the ball's y-coordinate is beyond the bottom of the screen
  }
  
  // Check if the ball should be removed (based on lifetime)
  boolean shouldDespawn() {
    return millis() - spawnTime > lifetime;  // Check if lifetime has passed
  }
}
