#include <stdio.h>

extern void caesar(char *input, int shift, char *output);

int main() {
    char *input = "!ZzLABO\0";
    char output [20];
    caesar(input , 2 , output );
    printf( "%s ---> %s\n" , input , output );
    return 0;
}
