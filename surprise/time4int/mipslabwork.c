/* mipslabwork.c

   This file written 2015 by F Lundevall
   Updated 2017-04-21 by F Lundevall

   This file should be changed by YOU! So you must
   add comment(s) here with your name(s) and date(s): Calin Capitanu 24/01/2019

   This file modified 2017-04-31 by Ture Teknolog 

   For copyright and licensing, see file COPYING */

#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */
int mytime = 0x5957;
volatile int* trisE = (volatile int*) 0xbf886100;
volatile int* portE = (volatile int*) 0xbf886110;
char textstring[] = "text, more text, and even more text!";
int timeoutcounter = 0;
int prime = 1234567;
int count = 0;

/* Interrupt Service Routine */
void user_isr( void ) {
  timeoutcounter++;
  if(timeoutcounter == 9){
    time2string( textstring, mytime );
    display_string( 1, "");
    display_string( 2, "");
    display_string( 3, textstring );
    display_update();
    tick( &mytime );
    timeoutcounter = 0;
  }
  if((IFS(0) >> 7) % 2 == 1)
    {
      count++;
      *portE = count;
    }
  
  //if((IFS(0) >> 8) & 1)

  IFSCLR(0) =  0x0100;
  IFSCLR(0) = 0x0080;
  
}
/* Lab-specific initialization goes here */
void labinit( void )
{
  *trisE = ~(0xff) & *trisE;
  TRISD = (0x7f << 5) | TRISD;
  TMR2 = 0;
  PR2 = 31250;
  T2CON = 0x8070;
  IEC(0) |= 3 << 7;
  IPC(2) |= 7 << 2;
  *portE = count;
  IPC(1) |= 0x3 << 24;
  enable_interrupts();
  return;
}

/* This function is called repetitively from the main program */

void labwork( void ) {
  prime = nextprime( prime );
  display_string( 0, itoaconv( prime ) );
  display_update();
}
