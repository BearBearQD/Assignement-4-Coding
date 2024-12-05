class Wall {
  float x, y;   // Position of the wall
  float w = 100, h = 10;  // Width and height of the wall

  // Constructor to set the position of the wall
  Wall(float xPos, float yPos) {
    this.x = xPos;
    this.y = yPos;
  }

  // Display the wall
  void display() {
    fill(0);  // Set the color to black
    rect(x, y, w, h);  // Draw the wall as a rectangle
  }
}
