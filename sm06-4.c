#include <stdio.h>
#include <stdlib.h>

struct Node {
    struct Node* next;
    int val;
};

int main() {
    struct Node *a = calloc(1, sizeof(struct Node)), *b;
    if (a == NULL) {
        return 1;
    }
    int v;
    while (scanf("%d", &v) == 1) {
        b = calloc(1, sizeof(struct Node));
        if (b == NULL) {
            break;
        }
        b->val = v;
        b->next = a;
        a = b;
    }
    while (a->next != NULL) {
        printf("%d\n", a->val);
        struct Node *c = a;
        a = a->next;
        free(c);
    }
    free(a);
}
