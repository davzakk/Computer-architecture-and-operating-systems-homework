#include <signal.h>
#include <stdio.h>
#include <unistd.h>
#include <stdint.h>


volatile int counter1 = 0, counter2 = 0, flag = 0, pr = 0;

void handler(int sig) {
    if (sig == SIGUSR1) {
        pr = 1;
        counter1++;
    } else if (sig == SIGUSR2) {
        counter2++;
    } else if (sig == SIGTERM) {
        flag = 1;
    }
}

int main() {
    struct sigaction sa;
    sigset_t oldmask;

    
    sa.sa_handler = handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0 | SA_RESTART;
    sigaction(SIGUSR1, &sa, NULL);
    sigaction(SIGUSR2, &sa, NULL);
    sigaction(SIGTERM, &sa, NULL);
    printf("%d\n", getpid());
    fflush(stdout);
    sigprocmask(SIG_BLOCK, &sa.sa_mask, &oldmask);
    while (!flag) {
        sigsuspend(&oldmask);
        if (pr) {
            printf("%d %d\n", counter1 - 1, counter2);
            fflush(stdout);
            pr = 0;
        }
    }
    
}
