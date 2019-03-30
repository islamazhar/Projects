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
#define MAXN
#define FOR(i,a,b) for(int i=(int) a ; i<=(int)b;i++)
int main(int argc, char **argv){

	//freopen("in.txt","r",stdin) ;
	//freopen("out.txt","w",stdout) ;
    int TC = 1 ;
    int A,B,C ;
    while(scanf("%d %d %d",&A,&B,&C)==3){

	    cout<<"Case No: "<<TC++ ;
		if(A+B==C){
			cout<<" +" ;
		}

		if(A-B==C){
			cout<<" -" ;
		}
		if(A*B==C){
			cout<<" *" ;
		}
		if(B!=0 && A%B==C){
			cout<<" %" ;
		}
		cout<<"\n" ;
    }


	return 0;
}

