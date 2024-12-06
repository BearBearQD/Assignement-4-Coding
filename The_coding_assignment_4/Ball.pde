class Ball {
  PVector position;  // Ball position as a PVector
  PVector velocity;  // Ball velocity as a PVector
  float radius = 10;  // Ball radius
  int spawnTime;  // Time when the ball was spawned
  int lifetime;   // Randomly decided lifetime for the ball (between 30-45 seconds)
  int colour;  // Ball color
  String ability;  // The ability of the ball (split, small, gravity, speed, slow)
  boolean hasSplit = false;  // Track if the ball has already split
  // Constructor to initialize ball with random properties
  Ball() {
    position = new PVector(random(20, 380), random(100, 200));  // Random position
    velocity = new PVector(random(2, 4), random(2, 4));  // Random velocity

    spawnTime = millis();  // Store the spawn time
    lifetime = int(random(15000, 20000));  // Lifetime between 30-45 seconds

    // Assign a random ability
    String[] abilities = {"split", "small", "gravity", "speed", "slow"};
    ability = abilities[int(random(abilities.length))];

    // Assign colors based on the ability
    if (ability.equals("split")) {
      colour = color(255, 0, 0);  // Red for split
    } else if (ability.equals("small")) {
      colour = color(0, 0, 255);  // Blue for small
    } else if (ability.equals("gravity")) {
      colour = color(0, 255, 0);  // Green for gravity
    } else if (ability.equals("speed")) {
      colour = color(255, 255, 0);  // Yellow for speed
    } else if (ability.equals("slow")) {
      colour = color(128, 0, 128);  // Purple for slow
    }
  }

  // Update the ball's position and handle collisions
  void update() {
    // Gravity effect for certain balls
    if (ability.equals("gravity")) {
      velocity.y += 0.1;  // Gravity force that affects vertical speed
    }

    // Move the ball by its velocity (position += velocity)
    position.add(velocity);

    // Ball behavior based on ability
    if (ability.equals("small")) {
      radius = 5;  // Make the ball smaller
    }

    // Bounce off left and right walls
    if (position.x - radius <= 0 || position.x + radius >= width) {
      velocity.x *= -1;  // Reverse horizontal direction
    }

    // Bounce off top wall
    if (position.y - radius <= 0) {
      velocity.y *= -1;  // Reverse vertical direction
    }

    // Bounce off paddle
    if (position.y + radius >= paddle.position.y && position.x >= paddle.position.x && position.x <= paddle.position.x + paddle.size.x) {
      velocity.y *= -1;  // Reverse vertical direction after hitting the paddle
      velocity.x += random(-1, 1);  // Slight random horizontal speed change for variation

      // Special behavior: increase speed after bounce for "speed" ability
      if (ability.equals("speed")) {
        velocity.x *= 1.1;
        velocity.y *= 1.1;
      }

      // Split the ball into two if it has the "split" ability and hasn't split yet
      if (ability.equals("split") && !hasSplit) {
        balls.add(new Ball());  // Add a new ball with the same properties
        hasSplit = true;  // Mark as split
      }

      // Check if the ball has passed the paddle and fallen off the screen
      if (position.y - radius > height) {
        if (ability.equals("slow")) {
          lives -= 2;  // Decrease 2 lives when the "slow" ball passes the paddle
          if (lives <= 0) {
            gameOver = true;  // End game if lives go to 0
          }
        }
        balls.remove(this);  // Remove the ball from the game when it falls off screen
      }
    }

    // Check for collision with walls
    for (Wall w : walls) {
      if (checkCollisionWithWall(w)) {
        handleWallCollision(w);
      }
    }
  }

  // Display the ball
  void display() {
    fill(colour);  // Set the ball's color based on its ability
    ellipse(position.x, position.y, radius * 2, radius * 2);  // Draw the ball
  }

  // Check if the ball has passed the paddle and fallen off the screen
  boolean passedPaddle() {
    return position.y - radius > 415;  // If the ball's y-coordinate is beyond the bottom of the screen
  }

  // Check if the ball should be removed (based on lifetime)
  boolean shouldDespawn() {
    return millis() - spawnTime > lifetime;  // Check if lifetime has passed
  }

  // Check if the ball collides with a wall
  boolean checkCollisionWithWall(Wall w) {
    // Check if ball intersects the wall's rectangle
    return (position.x + radius > w.x && position.x - radius < w.x + w.w && position.y + radius > w.y && position.y - radius < w.y + w.h);
  }

  // Handle the collision with a wall
  void handleWallCollision(Wall w) {
    // Reflect ball's speed when it hits the wall
    if (position.x - radius < w.x || position.x + radius > w.x + w.w) {
      velocity.x *= -1;  // Reverse horizontal direction
    }
    if (position.y - radius < w.y || position.y + radius > w.y + w.h) {
      velocity.y *= -1;  // Reverse vertical direction
    }
  }
}
