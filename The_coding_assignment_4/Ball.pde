class Ball {
  float x, y;  // Ball position
  float speedX, speedY;  // Ball speed in both directions
  float radius = 10;  // Ball radius
  
  // Constructor to initialize ball with random properties
  Ball() {
    x = random(width);  // Random horizontal position
    y = random(100, 200);  // Random vertical position
    speedX = random(2, 4);  // Random horizontal speed
    speedY = random(2, 4);  // Random vertical speed
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
    
    // Prevent ball from going off the bottom of the screen
    if (y + radius > height) {
      reset();  // Reset the ball to its starting position
    }
  }
  
  // Display the ball
  void display() {
    fill(255, 0, 0);  // Set the ball color to red
    ellipse(x, y, radius * 2, radius * 2);  // Draw the ball
  }
  
  // Reset ball position if it falls off the screen
  void reset() {
    x = random(width);  // Random horizontal position
    y = random(100, 200);  // Random vertical position
    speedX = random(2, 4);  // Random horizontal speed
    speedY = random(2, 4);  // Random vertical speed
  }
}
