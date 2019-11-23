#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int main(int argc,char** argv){
	int even = 0,odd=0;
	int i=0;
	int n = atoi(argv[1]);	
	for(i=0;i<strlen(argv[1]);i++){
		if((argv[1][i]-'0')%2==0){
			even++;
		}
		else{
			odd++;
		}
		
	}
	printf("Odd :%d\nEven :%d\n",odd,even);
}
