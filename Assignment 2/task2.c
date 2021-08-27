#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int min(int a, int b){
    return ((a) < (b) ? (a) : (b));
} 

#define BLOCK 16
int arr[6000000];
int L[6000000], R[6000000];
int rand(void);
 
void insertionSort(int arr[], int l, int r)
{
    for (int i = l + 1; i <= r; i++)
    {
        int temp = arr[i], j = i - 1;

        while (j >= l && arr[j] > temp)
        {
            arr[j+1] = arr[j];
            j--;
        }
        arr[j+1] = temp;
    }
}
 
void mergeSort(int arr[], int l, int m, int r)
{
    int c = 0;
    
    for (c = 0; c < m - l + 1; c++)
        L[c] = arr[l + c];
    for (c = 0; c < r - m; c++)
        R[c] = arr[m + 1 + c];
 
    
    int i = 0, j = 0, k = l;

    while (i < m - l + 1 && j < r - m)
    {
        if (R[i] <= R[j])
        {
            arr[k] = R[i];
            i++;
        }
        else
        {
            arr[k] = R[j];
            j++;
        }
        k++;
    }
 
    while (i < m - l + 1)
    {
        arr[k] = R[i];
        k++;
        i++;
    }
 
    while (j < r - m)
    {
        arr[k] = R[j];
        k++;
        j++;
    }
}
 
void timSort(int arr[], int n)
{
    int i;

    for (i = 0; i < n; i += BLOCK)
        insertionSort(arr, i, min((i + BLOCK - 1 ), ( n - 1)));
 
    for (i = BLOCK; i < n; i = 2*i)
    {
        for (int l = 0; l < n; l += 2*i)
        {
            int m = l + i - 1, r = min((l + 2*i - 1), (n - i));

            if(m < l)
                mergeSort(arr, l, m, r);
        }
    }
}
 
void printArray(int A[], int size)
{
    int i;
    for (i = 0; i < size; i++)
        printf("%d ", A[i]);
    printf("\n");
}
 
int main()
{
    clock_t start, end;
    start = clock();
    time_t t;
    srand((unsigned) time(&t));
  
  /* Intializes random number generator */
    int arr_size = 6000000;
    scanf("%d", &arr_size);

    for(int i=0;i<arr_size;i++)
        scanf("%d",&arr[i]);    // arr[i] = (rand() % 10000000); 
     
    timSort(arr, arr_size - 1);
    
    printArray(arr, arr_size);
    
    end = clock();
    printf("Required Time: %lf", ((double) (end - start)) / CLOCKS_PER_SEC);
    return 0;
}   