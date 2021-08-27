#include <stdio.h>
extern long solve(long n, long m);

signed main()
{
    long n, m;
    scanf("%ld%ld", &n, &m);

    long ans = solve(n, m);

    printf("%ld\n", ans);
}