#include "stdio.h"
#include "unistd.h"
#include "fcntl.h"
#include "sys/stat.h"
#include "stdlib.h"
#include "inttypes.h"
#include "sys/mman.h"
#include "unistd.h"
#include "sys/types.h"
#include "sys/wait.h"


int mysys(const char *str) {
    int pid1 = fork();
    if (pid1 == -1) {
        return -1;
    }
    if (pid1 == 0) {
        execlp("/bin/sh", "/bin/sh", "-c", str, NULL);
        _exit(127);
    }
    int st1;
    waitpid(pid1, &st1, 0);
    if (WIFEXITED(st1)) {
        if (0 <= WEXITSTATUS(st1) && WEXITSTATUS(st1) <= 127) {
            return WEXITSTATUS(st1);
        }
    } else if (WIFSIGNALED(st1)) {
        return 128 + WTERMSIG(st1);
    }
}
    
int main(int argc, char **argv) {
    if (argc != 4) {
        return 1;
    }
    return !((!mysys(argv[1]) || !mysys(argv[2])) && !mysys(argv[3]));
}
