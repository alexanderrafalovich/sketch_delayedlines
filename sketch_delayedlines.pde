PGraphics pg; 
 
float opacity = 255; 
float red = 120; 
float blue = 120;
float green = 120;
 
int framenum = 0; 
 
boolean shouldClearScreen = true; 
boolean isPaused = false; 
 
int pgWidth = 1920; 
int pgHeight = 1080; 
 
int increaseAmt = 1; 

float widthRatio;
float heightRatio;
 
//---------------------- 
void setup(){ 
  //size(800,600,P3D); 
  fullScreen(P3D); 
  frameRate(1000); 
  //noStroke(); 
  //noCursor(); 
  background(255); 
   
  pg = createGraphics(pgWidth,pgHeight); 
} 
 
//---------------------- 
void draw(){ 
   
  background(0,0,0,255); 
  
  //allows the line draw point to go very far offscreen.
  widthRatio = width/100; 
  heightRatio = height/100; 
   
  if(!isPaused){ 
     pg = drawDelayedLines(pg);
  }
  
  image(pg,0,0,width,height); 
 
  drawGui();
   
  framenum++; 
   
} 

//---------------------- 
void keyPressed(){ 
  if(key == CODED){ 
     //for UP, DOWN, LEFT, RIGHT, ALT, CONTROL, SHIFT 
  }else{ 
    //ASCII spec includes BACKSPACE, TAB, ENTER, RETURN, ESC, DELETE 
    
    switch(key){
      
      //Utilities
      case DELETE:
        pg.save("screen"+floor(random(100000000.0))+".png");
        break;
      case ' ':
        isPaused = !isPaused; 
        
      //Increments
      case 'q':
        red = incrementToMax(red, increaseAmt, 255);
        break;
      case 'w':
        green = incrementToMax(green, increaseAmt, 255);
        break;
      case 'e':
        blue = incrementToMax(blue, increaseAmt, 255);
        break;
      case 'r':
        opacity = incrementToMax(opacity, increaseAmt, 255);
        break;
        
      //Decerements
      case 'a':
        red = decrementToMin(red, increaseAmt, 0);
        break;
      case 's':
        green = decrementToMin(green, increaseAmt, 0);
        break;
      case 'd':
        blue = decrementToMin(blue, increaseAmt, 0);
        break;
      case 'f':
        opacity = decrementToMin(opacity, increaseAmt, 0);
        break;
        
      //Modify increase amount
      case '1':
        increaseAmt = 1;
        break;
      case '2':
        increaseAmt = 2;
        break;
      case '3':
        increaseAmt = 4;
        break;
      case '4':
        increaseAmt = 8;
        break;
      case '5':
        increaseAmt = 16;
        break;
      case '6':
        increaseAmt = 32;
        break;
    }
  } 
}

//------------------------
float incrementToMax(float original, float increment, float max){
  original += increment;
  return original>max?max:original;
}
float decrementToMin(float original, float increment, float min){
  original -= increment;
  return original<min?min:original;
}

//------------------------
void drawGui(){
 
  fill(red,green,blue); 
  noStroke(); 
  rect(10,10,20,20); 
   
  fill(0,0,0); 
  stroke(255,255,255); 
  ellipse((mouseX-width/2)*widthRatio,(mouseY-height/2)*heightRatio,3,3); 
   
  textSize(12);
  fill(0,0,0);
  text("Opacity: "+opacity,40,14);
  fill(255,255,255);
  text("Opacity: "+opacity,42,14);
  
  fill(0,0,0);
  text("Increase: "+increaseAmt,40,28);
  fill(255,255,255);
  text("Increase: "+increaseAmt,42,28); 
}

//---------------------
PGraphics drawDelayedLines(PGraphics pg){
   
  pg.beginDraw(); 
     
    if(shouldClearScreen){ 
     shouldClearScreen = false; 
     pg.background(255,255,255,0); 
    } 
     
    for(int i = 0; i<10; i++){ 
      float sRed; 
      float sGreen; 
      float sBlue; 
      if(framenum%50 < 24){ 
        sRed = red + (random(10)-5); 
        sGreen = green + (random(10)-5); 
        sBlue = blue + (random(10)-5);     
      }else{ 
        sRed = 0; 
        sGreen = 0; 
        sBlue = 0; 
      } 
      pg.stroke(sRed,sGreen,sBlue,opacity); 
       
      float xStart = random(pgWidth+100)-50; 
      float yStart = random(pgHeight+100)-50; 
      pg.line( 
        xStart, 
        yStart, 
        (mouseX-width/2)*widthRatio, 
        (mouseY-height/2)*heightRatio); 
    } 
     
    pg.endDraw();
    
    return pg;
}
