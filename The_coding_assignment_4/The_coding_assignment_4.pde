Paddle paddle; // Declare a Paddle object
ArrayList<Ball> balls = new ArrayList<Ball>(); // List to hold multiple balls
ArrayList<Ball> ballsToRemove = new ArrayList<Ball>();  // List of balls to be removed after the update

void setup() {
  size(400, 400); // Set canvas size to 400x400 pixels
  // Add a few balls with random speeds and positions
  balls.add(new Ball());
  paddle = new Paddle(); // Create the Paddle object
}

void draw() {
  fill(0); // Set fill color to black
  background(255); // Set the background to white
  // Use a standard for loop with an index
  for (int i = balls.size() - 1; i >= 0; i--) {
    Ball ball = balls.get(i);
    ball.update();  // Update ball's position and behavior
    ball.display();  // Display the ball
    
    // If the ball meets a condition (e.g., falls off screen), remove it
    //if (/* condition to remove ball */) {
      //balls.remove(i);  // Safely remove the ball by index
    //}
  }
  paddle.update(); // Update the paddle's position
  paddle.display(); // Display the paddle
}
