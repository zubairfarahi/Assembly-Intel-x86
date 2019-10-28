#include <stdio.h>
#include <string.h>
#include <malloc.h>

#define MAX_STR 2000002
#define MAX_APPS 1001

int main() {
    char *pattern = malloc(MAX_STR);
    char *str = malloc(MAX_STR);

    FILE *pFileIn = fopen("strmatch.in", "r");
    FILE *pFileOut = fopen("strmatch.out", "w");

    fgets(pattern, MAX_STR, pFileIn);
    fgets(str, MAX_STR, pFileIn);

    int lenStr = strlen(str) - 1;
    int lenPatt = strlen(pattern) - 1;

    if (lenPatt > lenStr) {
        fprintf(pFileOut, "0\n");
        goto return_label;
    }

    int *map = malloc(lenPatt * sizeof(*map));
    int *apps = malloc(MAX_APPS * sizeof(*apps));
    int i = 1, j = 0, numApp = 0;

build_prefArray:
    if (i == lenPatt) {
        goto make_KMP;
    }

back_prefArray:
    if (pattern[i] != pattern[j] && j) {
        j = map[j - 1];
        goto back_prefArray;
    }

    if (pattern[i] == pattern[j]) {
        ++j;
    }

    map[i] = j;
    ++i;
    goto build_prefArray;

make_KMP:
    i = 0; j = 0;

KMP_search:
    if (i == lenStr) {
        goto print_matches;
    }

back_on_array:
    if (pattern[j] != str[i] && j) {
        j = map[j - 1];
        goto back_on_array;
    }

    if (str[i] == pattern[j]) {
        ++j;
    }

    if (j == lenPatt) {

        apps[numApp++] = i - lenPatt + 1;

        j = map[j - 1];
    }

    ++i;
    goto KMP_search;

print_matches:
    fprintf(pFileOut, "%d\n", numApp);
    i = 0;

print_apps:
    if (i < numApp) {
        fprintf(pFileOut, "%d ", apps[i]);
        ++i;
        goto print_apps;
    }
    fprintf(pFileOut, "\n");

    free(map);
    free(apps);

return_label:
    free(pattern);
    free(str);
    fclose(pFileIn);
    fclose(pFileOut);

    return 0;
}
