class Paddle {
  float x, y; // Paddle position
  float w = 100, h = 20; // Paddle width and height
  
  // Constructor to set the initial position of the paddle
  Paddle() {
    y = height - h; // Set the vertical position to the bottom of the screen
  }
  
  // Update the paddle's horizontal position to follow the mouse
  void update() {
    x = mouseX - w / 2; // Paddle follows mouseX horizontally
    
    // Constrain the paddle to stay within the screen's horizontal boundaries
    x = constrain(x, 0, width - w); // Prevent the paddle from going off-screen
  }
  
  // Display the paddle
  void display() {
    fill(0); // Set the color to black
    rect(x, y, w, h); // Draw the paddle
  }
}
