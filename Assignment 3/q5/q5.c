#include <stdio.h>
extern long solve(long n);

signed main()
{
    long n;
    scanf("%ld", &n);

    long ans = solve(n);

    printf("%ld\n", ans);
}