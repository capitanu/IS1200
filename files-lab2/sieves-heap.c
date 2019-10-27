#include <stdio.h>
#include <stdlib.h>
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
  char *a = malloc(n + 1);
  if( a == NULL)
    fprintf(stderr, "is null");
  for(int i = 1; i <= n; i++)
    a[i] = 1;
  for( int i = 2; i <= n/2; i++) //sqrt does not work
    {
      if(a[i] == 1)
	{
	  for( int j = i*i; j <= n; j = j + i)
	    a[j] = 0;
	}
    }
  for(int i = 2; i <= n; i++)
    if(a[i] == 1)
      print_number(i);
  free(a);
}
int main(int argc, char *argv[]){
  if(argc == 2)
    print_sieves(atoi(argv[1]));
  else
    printf("Please state an interger number.\n");
  printf("\n");
  return 0;
}
