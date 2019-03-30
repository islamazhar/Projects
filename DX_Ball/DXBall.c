/*
 * DXBall.c
 *
 * Created: 22-Oct-15 4:27:35 PM
 *  Author: Zubaer & Mazhar
 */

#include <avr/io.h>
#include <avr/interrupt.h>
#define F_CPU 1000000     // Clock Frequency
#include <util/delay.h>


#define R 16
#define C 16
#define MAXLVL 4

//Mazhar
/* Global arrays to store
	- Initial brick arrangement for to levels
	- Current board position
	- Current ball position and velocity dx, dy
	- Current bar position
	- Current stage of game (If ended or running or level break. Won or lose)
	- Life remaining
	- Current level
	etc */
volatile int pattern[LVL][R][C] ;
volatile int board[R][C] ; // the board configuration
volatile int brick_remaining ; //
volatile int pos_x,pos_y ; // ball position
volatile int direction ; // +1 or -1
volatile int life_remaining ;
volatile int current_level ;
volatile int is_paused ;
volatile int velocity ;
volatile int overflows ;
volatile int barL,barR ;
///////////////////////////////////////Level One ///////////////////////////////////////////////////
pattern[0]={
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0}
        {0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0}
        {0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0}
        {0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
}
////////////////////////////////Level Two///////////////////////////////////////////////////////////
pattern[1]={
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
}
////////////////////////////////////Level Three//////////////////////////////////////////////////
pattern[2]={
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,1,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0}
        {0,0,0,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0}
        {0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,1,0,0,0,0}
        {0,0,0,1,0,0,1,0,0,0,1,1,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0}
        {0,0,0,1,0,0,1,0,0,0,1,1,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0}
        {0,0,0,1,0,0,1,0,0,0,1,1,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0}
        {0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,1,0,0,0,0}
        {0,0,0,1,0,0,1,0,0,0,1,1,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0}
        {0,0,0,1,0,0,1,0,0,0,1,1,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0}
        {0,0,0,1,0,0,1,0,0,0,1,1,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0}
        {0,0,0,1,0,0,1,0,0,0,1,1,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0}
        {0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,0,1,1,1,1,1,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
}
//Zubaer

/*Function to take input from proximity sensor*/
float ReadSensor(int sensorNo) {

}

//Zubaer
/*Function to callibrate middle position*/
void Callibrate() {

}

//Zubaer
/*Function to draw current state on matrix*/
void Show() {

}

//Mazhar
/*Interrupt Service Routine which will be triggered
after each certain time and will receive hand distance and update
current board state, level, ball position, velocity, bar position etc etc */




void restart(int incr){

    current_level+=incr ;
    brick_remaining = 0 ;
    int i,j ;
    for(i=0;i<R;i++){
        for(j=0;j<C;j++){
            board[i][j] = pattern[current_level][i][j] ;
            brick_remaining+=board[i][j] ;
        }
    }

    overflows = 0 ;
    direction = 1 ;
    velocity = 1 ;
    pos_x = R/2 ;
    pos_y = 0 ;
    barL = R/2-3 ; // need some change
    barR = R/2+3 ;// need some change
    //is_paused = 1 ; // at the start of the new level game is paused


    // paused button is on =
    unsigned char portc = PORTC ;
    PORTC = 0b11111101  ;
    PORTC  = PORTC & portc ;
}

// input capture interrupt for is_pause

// after 0.065536 seconds it called
ISR(TIMER1_OVF_vect)
{

    unsigned char ddrc = PINC ;
    if(ddrc &(1<<1)==1){
        is_paused = 1 ;
    }else is_paused = 0 ;



    if(is_paused){
        return ;
    }

    //////////////////////////////////////////////////////////////////////////////////////
    int pos_x = pos_x+direction*velocity ;
    int pos_y = pos_y+direction*velocity ;
    /*
    if(pos_y<0){ // ball is out of the board
        life_remaining-- ;
        return ;
    }
    */
    // code to contain the ball in the board and change direction
    if(pos_y>C){
          pos_y = C ;
          direction*=-1 ;
    }
    if(pos_x<0){
        pos_x=0 ;
        direction*=-1 ;
    }
    if(pos_x>R){
        pos_x=R ;
        direction*=-1 ;
    }
    ////////////////////////////////////////////////////////////////

    overflows++ ;
    if(overflows==42){ // after about 10s velocity is increased
            overflows = 0 ;
            velocity++ ; // velocity is increased
    }

    //////////////////////////////////////////////////////////////////

    if(board[pos_x][pos_y]==1){
        board[pos_x][pos_y] = 0 ;
        brick_remaining-- ;
        if(brick_remaining==0){
                restart(1) ;
                return ;
            // restart the game ;
        }
    }
///////////////////////update bar position /////////////////////////////////////////////////////
    if(pos_y==0){
        if(barL<=pos_x && pos_x>=barR){
            direction*=-1 ;
        }
        else{
            life_remaining-- ;
            if(life_remaining>0){
                restart(0) ;
            }else exit(0) ; // game has ended
        }
    }
}
// pause button (pin D3 is pressed ) so this interrupt is called
/*
ISR(INT1_vect)
{
    is_paused = !is_paused ;
    return ;
}
*/
/*The main funtion*/
int main(void) {
	//Zubaer
	/*Necessary initialization for taking input and showing output*/

	//Mazhar
	/*Necessary initializations in global variables and interrupt settings*/

    current_level = 0 ;
    life_remaining = 3 ;
    restart(0) ;
    unsigned char ddrc = DDRC ;
    DDRC = 0b11111101  ; // configuring the  2nd pin of port C as
    DDRC  = ddrc & DDRC ;
    // configure timer
    TCCR1A = 0x00 ;
    TCCR1B = 0x01 ;
    // enable overflow interrupt
    TIMSK = 0x04 ;
    // configure external  interrupt
  //  -GICR = (1<<INT1) ;
   // MCUCR = (1<<ISC10) ;
    // pause button is on pin D3 if there is any change then this interrupt is called

    sei() ;
	Callibrate();
    while(1) {
        Show();
	}
	return 0;
}
