class Paddle {
  PVector position;  // Paddle position as a PVector
  PVector size;      // Paddle size (width and height) as a PVector
  
  // Constructor to set the initial position of the paddle
  Paddle() {
    position = new PVector(width / 2, height - 30);  // Set initial position
    size = new PVector(100, 20);  // Set paddle width and height
  }
  
  // Update the paddle's horizontal position to follow the mouse
  void update() {
   // Get the mouse's x position and move the paddle accordingly
    position.x = constrain(mouseX - size.x / 2, 0, width - size.x);  // Make sure paddle stays within screen bounds
  }
  
  // Display the paddle
  void display() {
    fill(0); // Set the color to black
    rect(position.x, position.y, size.x, size.y);  // Draw the paddle at the current position
  }
}
