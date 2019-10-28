#include <stdio.h>
#include <limits.h>

int main() {
    int n, x, max = INT_MIN;

    scanf("%d", &n);

    max_vect:
    if (n) {
        scanf("%d", &x);

        max = (max < x ? x : max);

        --n;
        goto max_vect;
    }

    printf("%d\n", max);

    return 0;
}