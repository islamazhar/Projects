#include <stdio.h>
#define MAX_N 1000
int N, B, P[MAX_N], S[MAX_N];

void sort_by_p_plus_s(void){

  int i, tmp, done=0;

  while (!done) {
    done = 1;
    for (i=0; i<N-1; i++)
      if (P[i]+S[i] > P[i+1]+S[i+1]) {
        tmp = P[i]; P[i] = P[i+1]; P[i+1] = tmp;
        tmp = S[i]; S[i] = S[i+1]; S[i+1] = tmp;
        done = 0;
      }
  }
}

int try_coupon(int c)
{
  int i, budget = B - (P[c]/2+S[c]), total=1;

  if (budget < 0) return 0;

  for (i=0; i<N; i++)
    if (P[i]+S[i] <= budget && i!=c) {
      budget -= P[i]+S[i];
      total++;
    }

  return total;
}

int main(void){

  int i, best=0;

  freopen ("in.txt", "r", stdin);
  freopen ("out.txt", "w", stdout);
  int testcases ;
  scanf("%d",&testcases) ;
  while(testcases--){
	  scanf ("%d %d", &N, &B);
	  for (i=0; i<N; i++){
		scanf ("%d %d", &P[i], &S[i]);
	  }

	  sort_by_p_plus_s();

	  for (i=0; i<N; i++){
		if (try_coupon(i) > best)
		  best = try_coupon(i);
	  }

	  printf ("%d\n", best);
  }

  return 0;
}
