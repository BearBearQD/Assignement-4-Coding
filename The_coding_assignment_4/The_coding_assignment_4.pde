Paddle paddle; // Declare a Paddle object
ArrayList<Ball> balls = new ArrayList<Ball>(); // List to hold multiple balls

void setup() {
  size(400, 400); // Set canvas size to 400x400 pixels
  // Add a few balls with random speeds and positions
  for (int i = 0; i < 3; i++) {
    balls.add(new Ball());
  }
  paddle = new Paddle(); // Create the Paddle object
}

void draw() {
  fill(0); // Set fill color to black
  background(255); // Set the background to white
  // Update and display each ball
  for (Ball ball : balls) {
    ball.update();  // Update ball's position and behavior
    ball.display();  // Display the ball
  }
  paddle.update(); // Update the paddle's position
  paddle.display(); // Display the paddle
}
