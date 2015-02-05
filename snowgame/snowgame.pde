/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/43940*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
//Declare Variables
 float x = 0;
 float y = 0; 
 float d = 0;
 float end;
 float radius = 150;
 float wshift = 0;
 float wshift2 = 40;
 float hshift = 20;
 int r = 25;
 PImage main;
 int menu = 0, space;
 PFont font;
 int counter;
 int floor;
 int floorEnd = 15;
 int maxScore = 555;

 //Declare variables for timer
 float timer, start, totalTime;

 //Balloon Variables
 int bSize = 75;//no of balloons
 Balloon[] balloon = new Balloon[bSize];
 int value=0;

 void setup() {
   main = loadImage("hotairbackground.jpg");
   size(1100, 750); //Size of window
   frameRate(30);
   smooth(); 
   stroke(50);
   font= loadFont("CenturyGothic-Bold-48.vlw");
   for (int i=0;i<bSize;i++) {
   balloon[i] = new Balloon(int(random(width)), int(random(height+600))); //new balloon with random positioning
 }
 }    
    
 void draw() {
   if (menu == 0) {
     mainMenu();    
   }
   else if (menu == 1){
     cursor(CROSS); //Cursor is set to cross almost like an aim
    // end=650;
     start = 600;
     timer += 1;
     totalTime = timer;
     fill(255);
     rect(0, 0, width, height);
     for (int i=0;i<bSize;i++) {
     balloon[i].update();
     }
     textFont(font, 25);
     fill(0);
     text("SCORE:" +counter, 10,35);
     text("FLOOR: " +floor, width/2, 35);
     text("MAX SCORE: " +maxScore, width-250, 35);
     if(totalTime>floor*10)
       floor++;
     }
     else if (menu == 2){
       PImage back;
       back = loadImage("hotairbackground.jpg");
       back.resize(width, height);
       background(back);
       font= loadFont("CenturyGothic-Bold-48.vlw");
       textFont(font, 38);
       fill(#000000);
       text("You Have Reachd Floor No " +floorEnd, width/4,(height/2)-100);
       text("Have a Great day", width/3,(height/2) - 50);
       text("Your Score " + counter, width/5,(height/2));
       text("Max score " + maxScore, width - width/2,(height/2));
       text("WELL DONE!!", width/3,(height/2) + 50);
       
     }
 }

  void mainMenu() {
     image(main, 0, 0); 
     fill(#919199, 230);
     rect((width-width/1.65)/2, height/5, width/1.5, height/10, 7);   //play square
     ellipse(width/4, height - height/4, radius, radius); 
     ellipse(width - width/4, height - height/4, radius, radius);
     textFont(font, 23);
     fill(255);
     text("    Hold \n and Play \n player 1", wshift + width/5, height - hshift - height/4);
     text("    Hold \n and Play \n player 2", width - 100 - width/5, height - hshift - height/4);
     textFont(font, 28);
     text("TAP AND MELT AS MANY SNOWFLAKS AS POSSIBLE", (width-width/1.8)/2.15, height/3.85);   
     if (space == 1) {
       menu = 1;
     }
  }
  
 class Balloon {

 boolean popped=false;
 
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
 //int counter=0;

 public Balloon(int centerX, int centerY) {
    cx = centerX;
    cy = centerY;
    speed = int(10/*random(1, 5)*/);
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
 public void update() {
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
 if (!popped){
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
 if ( mousePressed == true &&
 dist(cx, cy, mouseX, mouseY) < r && popped==false) {
// fill(135, 206, 250);
 cx=width+20;
 cy=height+20;
 popped=true;
 counter+=1;
 }
 if (floor > floorEnd) {
   menu=2;
 }
 }
 }

 void keyPressed(){
     if (key == ' ')
    space = 1;
 }
 
 void keyReleased() {
     if (key == ' ')
    space = 0;
}

