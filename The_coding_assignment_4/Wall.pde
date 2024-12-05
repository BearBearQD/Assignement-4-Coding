class Wall {
  float x, y;   // Position of the wall
  float w = 100, h = 10;  // Width and height of the wall
  int spawnTime;  // Time when the wall was created
  int lifespan = 5000;  // Wall lifespan in milliseconds (5 seconds)

  // Constructor to set the position of the wall
  Wall(float xPos, float yPos) {
    this.x = xPos;
    this.y = yPos;
    this.spawnTime = millis();  // Set the spawn time when the wall is created
  }

  // Display the wall
  void display() {
    fill(0);  // Set the color to black
    rect(x, y, w, h);  // Draw the wall as a rectangle
  }
  boolean shouldDespawn() {
    return millis() - spawnTime > lifespan;  // Check if the wall's lifespan has passed
  }
}
