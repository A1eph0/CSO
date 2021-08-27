#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define BLOCK 16

int A[3500][3500], B[3500][3500], M[3500][3500];
int rand(void);

void matrixMul(int m, int n, int q)
{
    int sum;
    int i, j, k, jj, kk;

    for (kk = 0; kk < n; kk += BLOCK)
        for (jj = 0; jj < q; jj += BLOCK)  
            for (i = 0; i < m; i++) 
                for (k = kk; k < (( n < kk + BLOCK ) ? n : kk + BLOCK); k++)
                    for (j = jj; j < (( q < jj + BLOCK) ? q : jj + BLOCK); j++)
                        M[i][j]  += A[i][k] * B[k][j];
        
}

int main()
{
	clock_t start, end;
    start = clock();
    time_t t;
	srand((unsigned) time(&t));

	int m = 3500, n = 3500, q = 3500;
    int c, d, k, sum = 0;

    scanf("%d %d %d", &m, &n, &q);


	for (c = 0; c < m; c++)
        for (d = 0; d < n; d++)
            scanf("%d", &A[c][d]);   // A[c][d] = (rand() % 600);

	for (c = 0; c < n; c++)
		for (d = 0; d < q; d++)
		    scanf("%d", &B[c][d]); // B[c][d] = (rand() % 600);

	// Matrix Multiplication 
    matrixMul(m, n, q);

    for (c = 0; c < m; c++)
    {
        for (d = 0; d < q; d++)
            printf("%d ", M[c][d]);
    } 

    end = clock();
    printf("Required Time: %lf", ((double) (end - start)) / CLOCKS_PER_SEC);

    return 0;
}