#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <cctype>

#include <cmath>
#include <iostream>
#include <fstream>

#include <string>
#include <vector>
#include <queue>
#include <map>
#include <algorithm>
#include <set>
#include <sstream>
#include <stack>
#include <time.h>
using namespace std ;
#define MAXN
#define FOR(i,a,b) for(int i=(int) a ; i<=(int)b;i++)
int main(int argc, char **argv){

	srand(time(NULL)) ;
    FILE *fp;
	fp = fopen("in.txt","a+") ;
    int A,B,C ;

    for(int i=0;i<10;i++){
		A = rand() ;
		B = rand() ;
		C = A+B ;
        fprintf(fp,"%d %d %d\n",A,B,C) ;
        C = A-B ;
        fprintf(fp,"%d %d %d\n",A,B,C) ;
        if(C!=0) C = A%B ;
        fprintf(fp,"%d %d %d\n",A,B,C) ;
        C = A*B ;
        fprintf(fp,"%d %d %d\n",A,B,C) ;
    }

	return 0;
}

