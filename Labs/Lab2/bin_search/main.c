#include <stdio.h>
#include <malloc.h>

int main() {
    int n, i = 0, target, sol = -1, step = 1;

    scanf("%d %d", &n, &target);
    int *v = (int*)malloc(n * sizeof(*v));

read_data:
    if (i < n) {
        scanf("%d", v + i);

        ++i;
        goto read_data;
    }

make_step:
    if (step < n) {
        step <<= 1;
        goto make_step;
    }

    step >>= 1;
    i = 0;

bin_search:
    if (!step) {
        goto end;
    }

    if ((i + step < n && v[i + step] == target)) {
        sol = i + step;
        goto end;
    }

    if (i + step < n && v[i + step] < target) {
        i += step;
    }

    step >>= 1;
    goto bin_search;

end:
    if (sol != -1) {
        printf("%d\n", sol);
    } else {
        printf("ERROR 404: Not found!\n");
    }

    free(v);
    return 0;
}