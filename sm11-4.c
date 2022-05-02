#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main() {
    int v, f = 1;
    while (scanf("%d", &v) != EOF) {
        size_t pid = fork();
        if (pid == -1) {
            printf("-1\n");
            exit(1);
        }
        if (pid == 0) {
            f = 0;
        } else {
            int pid2;
            wait(&pid2);
            if (WIFEXITED(pid2) == 1 && WEXITSTATUS(pid2) == 1) {
                if (f) {
				    return 0;
                } else {
                    exit(1);
                }
            }
            printf("%d\n", v);
            return 0;
        }
    }
}
