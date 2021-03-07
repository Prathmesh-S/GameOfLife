import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 50;
public final static int NUM_COL = 50;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program
public int size = 800; 

public void setup () {
  size(800, 800);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new Life[NUM_ROWS][NUM_COL]; 
  for (int i = 0; i<NUM_ROWS; i++){
     for (int k = 0;k<NUM_COL;k++){
       buttons[i][k] = new Life(i,k);
    }
  }
  buffer = new boolean[NUM_ROWS][NUM_COL];
   for (int i= 0; i < NUM_ROWS; i++) {
    for (int k = 0; k < NUM_COL; k++) {
      buffer[i][k] = buttons[i][k].getLife();
    }
  }
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
   for (int i = 0; i<NUM_ROWS; i++){
     for (int k = 0;k<NUM_COL;k++){
       if (countNeighbors(i,k) == 3) {
       buffer[i][k]=true;
       }
       
      else  if ((countNeighbors(i,k)== 2) && (buttons[i][k].getLife())) {
       buffer[i][k]=true;;
       }
       else {
        buffer[i][k]=false;;
       }
       buttons[i][k].draw(); 
    }
  }

  copyFromBufferToButtons();
}

public void keyPressed() {
  //your code here
  if (key == 'e'){
  running = !running;
  }
   if (key == 'a'){
  size =size-100;
  }
   if (key == 'd'){
  size =size+100;
  }
}

public void copyFromBufferToButtons() {
   for (int i = 0; i<NUM_ROWS; i++){
     for (int k = 0;k<NUM_COL;k++){
       //buttons[i][k]=buffer[i][k];
       if ( buffer[i][k]==true){
       buttons[i][k].setLife(true);
    }
    else { buttons[i][k].setLife(false);}
    }
  }
}

public void copyFromButtonsToBuffer() {
    for (int i = 0; i<NUM_ROWS; i++){
     for (int k = 0;k<NUM_COL;k++){
       buffer[i][k]=buttons[i][k].getLife();
    }
  }
}

public boolean isValid(int r, int c) {
  if ((r>=0) && (r<NUM_ROWS) && (c>=0) && (c<NUM_COL)) {
  return(true);
  }
  return false;
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  if ((isValid(row-1,col)==true)&& (buttons[row-1][col]).getLife()==true) {
  neighbors++;
  }
  if ((isValid(row-1,col-1)==true)&& (buttons[row-1][col-1]).getLife()==true) {
  neighbors++;
  }
  if ((isValid(row-1,col+1)==true)&& (buttons[row-1][col+1]).getLife()==true) {
  neighbors++;
  }
  if ((isValid(row,col+1)==true)&& (buttons[row][col+1]).getLife()==true) {
  neighbors++;
  }
  if ((isValid(row,col-1)==true)&& (buttons[row][col-1]).getLife()==true) {
  neighbors++;
  }
  if ((isValid(row+1,col)==true)&& (buttons[row+1][col]).getLife()==true) {
  neighbors++;
  }
  if ((isValid(row+1,col-1)==true)&& (buttons[row+1][col-1]).getLife()==true) {
  neighbors++;
  }
  if ((isValid(row+1,col+1)==true)&& (buttons[row+1][col+1]).getLife()==true) {
  neighbors++;
  }
  
  return neighbors;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = size/NUM_COL;
    height = size/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill((int)(Math.random()*225), (int)(Math.random()*225),(int)(Math.random()*225) );
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    return(alive);
    //return false;
  }
  public void setLife(boolean living) {
    if (living==true) {
    alive=true;
    }
    else {
    alive=false;
    }
  }
}
