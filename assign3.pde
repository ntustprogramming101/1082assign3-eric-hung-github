final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

// chunk
final int chunkSize=80;

// sun setting
final int sunInnerSize=120,sunOutterSize=10;

// grass setiing
final int grassHeight=15;

// life setting
int lifePoint;
final float lifeSpace=20,lifeSize=50;

// groundhog setting
float groundhogPosX,groundhogPosY;
boolean groundhogMove;
int 	groundhogMoveX,groundhogMoveY;
final int groundhogFrame=16;
int groundhogFrameCount=0;

// soil setting
final int soilColorSpan=4;

// move canva
float nowLevel=0;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg,life;
PImage groundhogDown,groundhogRight,groundhogLeft,groundhogIdle;
PImage soil0,soil1,soil2,soil3,soil4,soil5;
PImage stone1,stone2;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");

	life = loadImage("img/life.png");

	groundhogDown= loadImage("img/groundhogDown.png");
	groundhogRight= loadImage("img/groundhogRight.png");
	groundhogLeft= loadImage("img/groundhogLeft.png");
	groundhogIdle= loadImage("img/groundhogIdle.png");

	soil0 = loadImage("img/soil0.png");
	soil1= loadImage("img/soil1.png");
	soil2= loadImage("img/soil2.png");
	soil3= loadImage("img/soil3.png");
	soil4= loadImage("img/soil4.png");
	soil5= loadImage("img/soil5.png");
	stone1= loadImage("img/stone1.png");
	stone2= loadImage("img/stone2.png");

	// intializng life
	lifePoint=2;

	// intializng ground
	groundhogMove=false;
	groundhogMoveX=0;
	groundhogMoveY=0;
	groundhogFrameCount=0;
	groundhogPosX=4*chunkSize;
	groundhogPosY=-chunkSize;


	nowLevel=0;
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);




		translate(0,nowLevel+2*chunkSize);//RECOVER----------------

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0,  - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		

		for(int i=0;i<24;i++){
			for(int j=0;j<8;j++){
				switch (i/soilColorSpan) {
					case 0:
						image(soil0,j*chunkSize ,i*chunkSize);
						if(i==j){
							image(stone1, j*chunkSize, i*chunkSize);
						}
					break;
					case 1:
						image(soil1,j*chunkSize ,i*chunkSize);
						if(i==j){
							image(stone1, j*chunkSize, i*chunkSize);
						}
					break;
					case 2:
						image(soil2,j*chunkSize ,i*chunkSize);
						if((i%4==1||i%4==2)&&(j%4==1||j%4==2)){break;}
						if(i%4==1||i%4==2){
							image(stone1, j*chunkSize, i*chunkSize);
						}
						if(j%4==1||j%4==2){
							image(stone1, j*chunkSize, i*chunkSize);
						}
					break;
					case 3:
						image(soil3,j*chunkSize ,i*chunkSize);
						if((i%4==1||i%4==2)&&(j%4==1||j%4==2)){break;}
						if(i%4==1||i%4==2){
							image(stone1, j*chunkSize, i*chunkSize);
						}
						if(j%4==1||j%4==2){
							image(stone1, j*chunkSize, i*chunkSize);
						}
					break;
					case 4:
						image(soil4,j*chunkSize ,i*chunkSize);
						if(i%8+j%8==1||i%8+j%8==4||i%8+j%8==7||i%8+j%8==10||i%8+j%8==13){
							image(stone1, j*chunkSize, i*chunkSize);
						}
						if(i%8+j%8==2||i%8+j%8==5||i%8+j%8==8||i%8+j%8==11||i%8+j%8==14){
							image(stone1, j*chunkSize, i*chunkSize);
							image(stone2, j*chunkSize, i*chunkSize);
						}
					break;
					case 5:
						image(soil5,j*chunkSize ,i*chunkSize);
						if(i%8+j%8==1||i%8+j%8==4||i%8+j%8==7||i%8+j%8==10||i%8+j%8==13){
							image(stone1, j*chunkSize, i*chunkSize);
						}
						if(i%8+j%8==2||i%8+j%8==5||i%8+j%8==8||i%8+j%8==11||i%8+j%8==14){
							image(stone1, j*chunkSize, i*chunkSize);
							image(stone2, j*chunkSize, i*chunkSize);
						}
					break;
					
				}
			}
		}
		

		// Player

		// if moving
		if(groundhogMove){
			if(groundhogMoveX==1){
				groundhogPosX+=chunkSize/groundhogFrame;
				image(groundhogRight,groundhogPosX,groundhogPosY);
			}else if(groundhogMoveX==-1){
				groundhogPosX-=chunkSize/groundhogFrame;
				image(groundhogLeft,groundhogPosX,groundhogPosY);
			}else if(groundhogMoveY==-1){
				groundhogPosY+=chunkSize/groundhogFrame;
				if(nowLevel>-20*chunkSize){
					nowLevel-=chunkSize/groundhogFrame;
				}
				image(groundhogDown,groundhogPosX,groundhogPosY);
			}
			if(groundhogFrameCount==groundhogFrame-1){
				groundhogMoveX=0;
				groundhogMoveY=0;			
				groundhogFrameCount=0;
				groundhogMove=false;
			}else{
				groundhogFrameCount++;
			}				
		}else{
			image(groundhogIdle,groundhogPosX,groundhogPosY);
		}	
			
		if(keyPressed&&!groundhogMove){
			if(keyCode==DOWN&&groundhogPosY+chunkSize<=23*chunkSize){
				groundhogMove=true;
				groundhogMoveY=-1;
			}
			if(keyCode==RIGHT&&groundhogPosX+chunkSize<=chunkSize*7){
				groundhogMove=true;
				groundhogMoveX=1;
			}
			if(keyCode==LEFT&&groundhogPosX-chunkSize>=0*chunkSize){
				groundhogMove=true;
				groundhogMoveX=-1;
			}
		}

		translate(0,-(nowLevel+2*chunkSize));//RECOVER----------------

		// Health UI
		for (int i = 0; i < lifePoint; i++) {
			image(life,10+i*(lifeSpace+lifeSize),10);
		}	
		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}

		

		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}