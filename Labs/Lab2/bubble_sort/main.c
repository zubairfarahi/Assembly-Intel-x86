#include <stdio.h>
#include <stdlib.h>

int main() {
    int n, i = 0, j;
    char swapped = 1;

    scanf("%d", &n);
    int *v = (int*)malloc(n * sizeof(*v));

read_vect:
    if (i < n) {
        scanf("%d", v + i);
        ++i;

        goto read_vect;
    }

    i = 0;

first_for:
    if (!swapped) {
        goto end;
    }

    swapped = 0;
    j = 0;

second_for:
    if (j == n - i - 1) {
        ++i;
        goto first_for;
    }

    if (v[j] > v[j + 1]) {
        int aux = v[j + 1];

        v[j + 1] = v[j];
        v[j] = aux;

        swapped = 1;
    }

    ++j;
    goto second_for;

end:
    i = 0;

print_for:
    if (i < n) {
        printf("%d ", v[i]);

        ++i;
        goto print_for;
    }
    printf("\n");

    free(v);
    return 0;
}