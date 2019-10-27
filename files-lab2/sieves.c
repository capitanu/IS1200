#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define COLUMNS 6
void print_number (int nr){
  static int call_count = 0;
  printf("%10d", nr);
  call_count++;
  if(call_count == COLUMNS){
    printf("\n");
    call_count = 0;
  }
	  
}
void print_sieves ( int n ){
  char a[n+1];
  for(int i = 1; i <= n; i++)
    a[i] = 1;
  for( int i = 2; i <= n/2; i++)
    {
      if(a[i] == 1)
	{
	  for( int j = i*i; j <= n; j = j + i)
	    a[j] = 0;
	}
    }
  int count = 0;
  int first;
  for(int i = 2; i <= n; i++)
    {
      if(a[i] == 1){
	first = i;
	break;
      }
    }
  for(int i = first + 1; i <= n; i++)
    {
      if(a[i] == 1)
	{
	  if(i - first == 8)
	    count++;  
	  first = i;
	}
    }
  for(int i = 2; i <= n; i++)
    if(a[i] == 1)
      print_number(i);
  printf("\nNumber of distances of 8 is: %d", count);
  
}
int main(int argc, char *argv[]){
  if(argc == 2)
    print_sieves(atoi(argv[1]));
  else
    printf("Please state an interger number.\n");
  printf("\n");
  return 0;
}
