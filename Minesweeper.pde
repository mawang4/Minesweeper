import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20; 
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
public boolean gameOver = false;

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);

    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS]; 
    for(int i = 0; i < NUM_ROWS; i++){
      for(int j = 0; j < NUM_COLS; j++){
        buttons[i][j] = new MSButton(i, j); 
      }
    }
    setMines();
}
public void setMines()
{
   for(int k = 1; k < 35; k++){ 
    int i = (int)(Math.random() * NUM_ROWS); 
    int j = (int)(Math.random() * NUM_COLS); 
    if(!mines.contains(buttons[i][j])){
      mines.add(buttons[i][j]);
    }
   }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    for(int i = 0; i < NUM_ROWS; i++){
      for(int j = 0; j < NUM_COLS; j++){
        if(buttons[i][j].clicked == false)
          return false;
      }
    }
    return true;
}
public void displayLosingMessage()
{
    for(int i = 0; i < NUM_ROWS; i++){
      for(int j = 0; j < NUM_COLS; j++){
        if(mines.contains(buttons[i][j])){
          buttons[i][j].clicked = true; 
        }
      }
    }  
    gameOver = true; 
    buttons[NUM_ROWS/2][NUM_COLS/2 - 5].setLabel("Y"); 
    buttons[NUM_ROWS/2][NUM_COLS/2 - 4].setLabel("O"); 
    buttons[NUM_ROWS/2][NUM_COLS/2 - 3].setLabel("U"); 
    buttons[NUM_ROWS/2][NUM_COLS/2 - 1].setLabel("L"); 
    buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("O"); 
    buttons[NUM_ROWS/2][NUM_COLS/2 + 1].setLabel("S"); 
    buttons[NUM_ROWS/2][NUM_COLS/2 + 2].setLabel("E");
    buttons[NUM_ROWS/2][NUM_COLS/2 + 3].setLabel("!"); 
}
public void displayWinningMessage()
{
    buttons[NUM_ROWS/2][NUM_COLS/2 - 5].setLabel("Y"); 
    buttons[NUM_ROWS/2][NUM_COLS/2 - 4].setLabel("O"); 
    buttons[NUM_ROWS/2][NUM_COLS/2 - 3].setLabel("U"); 
    buttons[NUM_ROWS/2][NUM_COLS/2 - 1].setLabel("W"); 
    buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("I"); 
    buttons[NUM_ROWS/2][NUM_COLS/2 + 1].setLabel("N"); 
    buttons[NUM_ROWS/2][NUM_COLS/2 + 2].setLabel("!");
}
public boolean isValid(int r, int c)
{
    if(r > -1 && r < NUM_ROWS && c > -1 && c < NUM_COLS){
      return true;
    } else {
      return false;
    }
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if(isValid(row - 1, col - 1) && mines.contains(buttons[row - 1][col - 1])){
      numMines++; 
    } if(isValid(row, col - 1) && mines.contains(buttons[row][col - 1])){
      numMines++;
    } if(isValid(row + 1, col - 1) && mines.contains(buttons[row + 1][col - 1])){
      numMines++;
    } if(isValid(row + 1, col) && mines.contains(buttons[row + 1][col])){
      numMines++;
    } if(isValid(row + 1, col + 1) && mines.contains(buttons[row + 1][col + 1])){
      numMines++; 
    } if(isValid(row, col + 1) && mines.contains(buttons[row][col + 1])){
      numMines++;
    } if(isValid(row - 1, col + 1) && mines.contains(buttons[row - 1][col + 1])){
      numMines++;
    } if(isValid(row - 1, col) && mines.contains(buttons[row - 1][col])){
      numMines++;
    }
    return numMines;
}

public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol * width;
        y = myRow * height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    { 
        if(gameOver == true){
          return; 
        }
        clicked = true;
        if(mouseButton == RIGHT){
          if(flagged == true){
            flagged = false; 
          } else {
            flagged = true; 
            clicked = false;
          }
        }
        else if(mines.contains(this)){
             displayLosingMessage(); 
        } else if(countMines(myRow, myCol) > 0){
             myLabel = "" + countMines(myRow, myCol);
        } else {
              if(isValid(myRow - 1, myCol - 1) && buttons[myRow - 1][myCol - 1].clicked == false){
                buttons[myRow - 1][myCol - 1].mousePressed();
              } if(isValid(myRow, myCol - 1) && buttons[myRow][myCol - 1].clicked == false){
                  buttons[myRow][myCol - 1].mousePressed();
              } if(isValid(myRow + 1, myCol - 1) && buttons[myRow + 1][myCol - 1].clicked == false){
                  buttons[myRow + 1][myCol - 1].mousePressed();
              } if(isValid(myRow + 1, myCol) && buttons[myRow + 1][myCol].clicked == false){
                  buttons[myRow + 1][myCol].mousePressed();
              } if(isValid(myRow - 1, myCol) && buttons[myRow - 1][myCol].clicked == false){
                  buttons[myRow - 1][myCol].mousePressed();
              } if(isValid(myRow - 1, myCol + 1) && buttons[myRow - 1][myCol + 1].clicked == false){
                  buttons[myRow - 1][myCol + 1].mousePressed();
              } if(isValid(myRow, myCol + 1) && buttons[myRow][myCol + 1].clicked == false){
                  buttons[myRow][myCol + 1].mousePressed();
              } if(isValid(myRow + 1, myCol + 1) && buttons[myRow][myCol + 1].clicked == false){
                  buttons[myRow + 1][myCol + 1].mousePressed();
              }
          }
    }
        
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this)) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
