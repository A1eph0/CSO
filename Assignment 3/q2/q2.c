#include<stdio.h>
extern void transpose(long *array, long n, long m);

signed main () 
{
    long n, m;
    scanf("%ld%ld", &n, &m);
    
    long array[n][m];
    
    for (long i=0; i<n; i++)
        for (long j=0; j<m; j++)
            scanf("%ld", &array[i][j]);
    
    transpose(&array[0][0], n, m);

    for (long i=0; i<n; i++)
        for (long j=0; j<m; j++)
        {
            printf("%ld ", array[i][j]);
            if ((i*m+j)%n)
                printf("\n");
        }
            

}