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
using namespace std ;
#define MAXN 101
#define FOR(i,a,b) for(int i=(int) a ; i<=(int)b;i++)
int main(int argc, char **argv){
    #ifdef unlucky_13
        freopen("in.txt","w",stdout) ;
    #endif
    srand(time(NULL)) ;
    int n = 1 ;
    printf("1000") ;
    while(n<1000){
		printf("%d\n",n) ;
		for(int i=0;i<n;i++){
			int val = rand()%1000 ;
			printf("%d\n",val) ;
		}
		n++ ;
	}

	return 0;
}

