SnowFlake[] snowflakes;
float wind;

void setup() {
  frameRate(15);
  size((int)(1440*1), (int)(900*1));
  background(0);
  snowflakes = new SnowFlake[0];
  for (int i=0; i<60; i++) {
    SnowFlake mySnowFlake = new SnowFlake(int(random(0, width)), int(random(0, height)));

    if (i==5 || i==15) mySnowFlake.setMessage("qrcode_magic_plane.png", "Magic plane", "News/ Missing Malaysia plane- search continues underwater");
    if (i==7 || i==30) mySnowFlake.setMessage("qrcode_listen_cello.png", "Listen to my Cello", "Concert/ Conservatory students presenting their graduating recitals");
    if (i==25 || i==39) mySnowFlake.setMessage("qrcode_makers_meet_up.png", "Makers meet up", "Talk/ Don't be bored. Learning to make, making to learn. Craft and Technology");

    snowflakes = (SnowFlake[]) append(snowflakes, mySnowFlake);
  }
}

void draw() {
  background(255);
  wind = map(mouseX, 0, width, -2, 2);
  SnowFlake stoppedSnowFlake = null;
  for (int i=0; i<snowflakes.length; i++) {
    snowflakes[i].fall();
    snowflakes[i].display();
    if (snowflakes[i].speed==0) stoppedSnowFlake = snowflakes[i];
    if (snowflakes[i].speed!=0) snowflakes[i].cx=snowflakes[i].cx+wind;
  }

  if (stoppedSnowFlake!=null) {
    float scale = 1.1;
    stroke(255);
    fill(255);
    float rectX = stoppedSnowFlake.cx-stoppedSnowFlake.spokeLengthMax*2.5;
    float rectY = stoppedSnowFlake.cy+stoppedSnowFlake.spokeLengthMax*3;
    rect(rectX, rectY, 200*scale, 81*scale);
    image(stoppedSnowFlake.image, 120*scale+rectX, 1+rectY, 80*scale, 80*scale);
    textSize(9*scale);
    fill(0);
    text(stoppedSnowFlake.text, 5*scale+rectX, 8*scale+rectY, 110*scale, 65*scale);
  }
}

void mousePressed() {

  for (int i=0; i<snowflakes.length; i++) {
    snowflakes[i].restart();
  }

  for (int i=0; i<snowflakes.length; i++) {
    if (snowflakes[i].clicked(mouseX, mouseY)) {
      break;
    }
  }
}

class SnowFlake {
  int radius;
  int spokeLength;
  int spokeLengthMax;
  float cx;
  float cy;
  int rotated;
  int howComplex;
  int speed;
  int tmpSpeed;
  int numSpokes;
  int transparency;
  int[] rotatedList;
  int[] radiusList;
  int[] spokeLengthList;
  int colorNum;
  String info;
  String text;
  PImage image;

  SnowFlake(int centerX, int centerY) {
    cx = centerX;
    cy = centerY;
    speed = int(random(1, 5));
    tmpSpeed = 0;
    howComplex = int(random(3, 6));
    numSpokes = int(random(5, 8));
    transparency = int(random(20, 180));
    rotatedList = new int[howComplex];
    radiusList = new int[howComplex];
    spokeLengthList = new int[howComplex];
    colorNum = int(random(80, 200));
    spokeLengthMax = 0;
    info = null;
    text = null;
    image = null;

    for (int i=0; i<howComplex; i++) {
      rotated = int(random(0, 55));
      radius = int(random(2, 5));
      spokeLength = int(random(2, 15));
      if (spokeLength>spokeLengthMax) spokeLengthMax = spokeLength;
      rotatedList[i] = rotated;
      radiusList[i] = radius;
      spokeLengthList[i] = spokeLength;
    }
  }

  void setMessage(String imageName, String infoText, String textText) {
    info = infoText;
    text = textText;
    image = loadImage(imageName);
  }

  void display() {
    ellipseMode(CENTER);
    stroke(colorNum, colorNum, colorNum, transparency);
    fill(0, 0, 0, transparency);
    for (int i = 0; i < howComplex; i++) {
      rotated = rotatedList[i];
      radius = radiusList[i];
      spokeLength = spokeLengthList[i];
      float theAngle = 360/numSpokes;
      //ellipse(cx, cy, radius, radius);
      for (int j = 0; j < numSpokes; j++) {
        float elbowX = cx + cos(radians(theAngle*j+rotated)) * spokeLength;
        float elbowY = cy + sin(radians(theAngle* j+rotated))* spokeLength;
        float wristX = elbowX + cos(radians(theAngle*j+rotated)) * spokeLength * 1.5;
        float wristY = elbowY + sin(radians(theAngle*j+rotated)) * spokeLength * 1.5;

        line(cx, cy, elbowX, elbowY);
        ellipse(elbowX, elbowY, radius, radius);
        line(elbowX, elbowY, wristX, wristY);
        ellipse(wristX, wristY, radius, radius);
      }
    }

    if (info!=null) {
      textSize(12);
      fill(0, 0, 255);
      text(info, cx+spokeLengthMax*2, cy+spokeLengthMax*2);
    }
  }

  void fall() {
    if (cy < height+50) {
      cy = cy + speed;
    } 
    else {
      cy = -50;
    }

    if (cx < -50) {
      cx = width +50;
    } 
    else if (cx > width+50) {
      cx = -50;
    }

    for (int i=0; i<howComplex; i++) {
      rotatedList[i]=rotatedList[i]+1;
    }
  }

  boolean clicked(int x, int y) {
    if (info!=null && x>(cx-spokeLengthMax*2) && x<(cx+spokeLengthMax*2) && y>(cy-spokeLengthMax*2) && y<(cy+spokeLengthMax*2)) {
      tmpSpeed = speed;
      speed = 0;
      return true;
    }
    return false;
  }

  void restart() {
    if (speed==0) {
      speed = tmpSpeed;
    }
  }
}

