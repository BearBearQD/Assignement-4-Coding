Paddle paddle; // Declare a Paddle object

void setup() {
  size(400, 400); // Set canvas size to 400x400 pixels

  paddle = new Paddle(); // Create the Paddle object
}

void draw() {
  fill(0); // Set fill color to black
  background(255); // Set the background to white
  paddle.update(); // Update the paddle's position
  paddle.display(); // Display the paddle
}
