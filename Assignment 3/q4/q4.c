#include <stdio.h>
extern void solve(long *brd, long n);

signed main()
{
    long n;
    scanf("%ld", &n);
    long brd[n*n];

    for (long i = 0; i<n*n; i++)
        brd[i] = 0;
    
    solve(&brd[0], n);

    for (long i = 0; i<n; i++)
    {
        for(long j = 0; j<n; j++)
            printf("%ld ", brd[i*n+j]);
        printf("\n");
    }
}