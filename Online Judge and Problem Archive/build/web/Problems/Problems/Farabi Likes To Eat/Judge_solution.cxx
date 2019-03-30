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
#define MAXN 10000+100
#define FOR(i,a,b) for(int i=(int) a ; i<=(int)b;i++)
int main(int argc, char **argv){
    #ifdef unlucky_13
        freopen("in.txt","r",stdin) ;
        freopen("out.txt","w",stdout) ;
    #endif // unlucky_13
    int T ,cnt[MAXN],val,n;
    scanf("%d",&T) ;
    while(T--){
		scanf("%d",&n) ;
		memset(cnt,0,sizeof(cnt)) ;
		for(int i=0;i<n;i++){
			scanf("%d",&val) ;
			cnt[val]++ ;
		}
		int res = -1 ;
		for(int i=0;i<10000;i++){
			res = max(cnt[i],res) ;
		}
		printf("%d\n",res) ;
	}
	
	return 0;
}

