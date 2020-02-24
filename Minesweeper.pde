import de.bezier.guido.*;
private final static int NUM_ROWS=20; int NUM_COLS=20;   //Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined



void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];

    for (int i=0; i<buttons.length; i++) {
        for (int j=0; j<buttons[i].length; j++) {
            buttons[i][j] = new MSButton(i,j);
        }
    }
    
    mines = new ArrayList <MSButton> ();
    for (int i=0; i<(NUM_ROWS*NUM_COLS/7); i++)
        setMines();
}
public void setMines()
{
    //your code
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
    if (!mines.contains(buttons[r][c]))
        mines.add(buttons[r][c]);
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for (int i=0; i<mines.size(); i++)
        if (mines.get(i).flagged==false)
            return false;
    return true;
}
public void displayLosingMessage()
{
    fill(255);
    textSize(30);
    text("You lose!",150,185);
}
public void displayWinningMessage()
{
    for (int i=0; i<mines.size(); i++)
        mines.get(i).mousePressed();
    fill(255);
    textSize(30);
    text("You win!",150,185);
}
public boolean isValid(int r, int c)
{
    if (r<NUM_ROWS&&r>-1&&c<NUM_COLS&&c>-1)
        return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    if (isValid(row-1,col-1)&&mines.contains(buttons[row-1][col-1]))
        numMines++;
    if (isValid(row-1,col)&&mines.contains(buttons[row-1][col]))
        numMines++;
    if (isValid(row-1,col+1)&&mines.contains(buttons[row-1][col+1]))
        numMines++;
    if (isValid(row,col-1)&&mines.contains(buttons[row][col-1]))
        numMines++;
    if (isValid(row,col+1)&&mines.contains(buttons[row-1][col+1]))
        numMines++;
    if (isValid(row+1,col-1)&&mines.contains(buttons[row+1][col-1]))
        numMines++;
    if (isValid(row+1,col)&&mines.contains(buttons[row-1][col]))
        numMines++;
    if (isValid(row+1,col+1)&&mines.contains(buttons[row+1][col+1]))
        numMines++;

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
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if (mouseButton==RIGHT){
            flagged = !flagged;
            if (flagged==false)
                clicked = false;
        }
        else if (mines.contains(this))
            displayLosingMessage();
        else if (countMines(myRow,myCol)>0)
            myLabel = ""+(countMines(myRow,myCol));
        else {
            buttons[myRow-1][myCol-1].mousePressed();
            buttons[myRow-1][myCol].mousePressed();
            buttons[myRow-1][myCol+1].mousePressed();
            buttons[myRow][myCol-1].mousePressed();
            buttons[myRow][myCol+1].mousePressed();
            buttons[myRow+1][myCol-1].mousePressed();
            buttons[myRow+1][myCol].mousePressed();
            buttons[myRow+1][myCol+1].mousePressed();
        }
            
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill(200);
        else 
            fill(100);

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
