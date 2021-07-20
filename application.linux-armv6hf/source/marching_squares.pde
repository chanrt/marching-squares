float[][] squares;

int res, mid;
int num_rows, num_cols;
float x_off, y_off, t_off;
float prec, speed;

void setup() {
  fullScreen(P2D);

  res = 10;
  mid = res / 2;
  num_rows = 1 + height / res;
  num_cols = 1 + width / res;

  squares = new float[num_rows][num_cols];

  t_off = random(10000);
  prec = 0.1;
  speed = 0.002;
}

void draw() {
  background(0);
  
  // initialising array
  y_off = 0;
  for (int row = 0; row < num_rows; row++) {
    x_off = 0;
    for (int col = 0; col < num_cols; col++) {
      if(noise(x_off, y_off, t_off) > 0.5) {
        squares[row][col] = 1;
      }
      else {
        squares[row][col] = 0;
      }
      x_off += prec;
    }
    y_off += prec;
  }
  t_off += speed;

  // rendering contours
  stroke(255);
  strokeWeight(2);
  noFill();
  int config;
  PVector top = new PVector(), right = new PVector(), bottom = new PVector(), left = new PVector();
  for (int row = 0; row < num_rows - 1; row++) {
    for (int col = 0; col < num_cols - 1; col++) {
      top.set(col * res + mid, row * res);
      right.set((col + 1) * res, row * res + mid);
      bottom.set(col * res + mid, (row + 1) * res);
      left.set(col * res, row * res + mid);
      config = floor(squares[row][col]) + 2 * floor(squares[row][col+1]) + 4 * floor(squares[row+1][col+1]) + 8 * floor(squares[row+1][col]);
      switch(config) {
      case 1:
      case 14:
        line(top.x, top.y, left.x, left.y);
        break;
      case 2:
      case 13:
        line(top.x, top.y, right.x, right.y);
        break;
      case 3:
      case 12:
        line(left.x, left.y, right.x, right.y);
        break;
      case 4:
      case 11:
        line(right.x, right.y, bottom.x, bottom.y);
        break;
      case 5:
      case 10:
        line(top.x, top.y, right.x, right.y);
        line(left.x, left.y, bottom.x, bottom.y);
        break;
      case 6:
      case 9:
        line(top.x, top.y, bottom.x, bottom.y);
        break;
      case 7:
      case 8:
        line(left.x, left.y, bottom.x, bottom.y);
        break;
      default:
        break;
      }
    }
  }
}

void keyPressed() {
  if((key == 'q' || key == 'Q') && prec > 0) {
    prec -= 0.01;
  }
  else if(key == 'e' || key == 'E') {
    prec += 0.01;
  }
  
  if((key == 'a' || key == 'A') && speed > 0) {
    speed -= 0.0002;
  }
  else if(key == 'd' || key == 'D') {
    speed += 0.0002;
  }
  
  else if(key == 'r' || key == 'R') {
    t_off = random(10000);
  }
}
