#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    struct Node *l, *r, *p;
    int val;
} Node;

int insert(Node* tree, int x, Node* parent) {
    if (x == tree->val) {
        return 0;
    } else if (x < tree->val) {
        if (tree->l == NULL) {
            tree->l = calloc(1, sizeof(struct Node));
            if (tree->l == NULL) {
                return 1;
            }
            tree->l->val = x;
            tree->l->p = parent;
        } else if (insert(tree->l, x, tree)) {
            return 1;
        }
    } else if (x > tree->val) {
        if (tree->r == NULL) {
            tree->r = calloc(1, sizeof(struct Node));
            if (tree->r == NULL) {
                return 1;
            }
            tree->r->val = x;
            tree->r->p = parent;
        } else if (insert(tree->r, x, tree)) {
            return 1;
        }
    }
    return 0;
}

void print(Node* tree) {
    if (tree != NULL) {
        if (tree->r != NULL) {
            print(tree->r);
        }
        printf("%d ", tree->val);
        if (tree->l != NULL) {
            print(tree->l);
        }
        if (tree != tree->p) {
            free(tree);
        }
    }
}


int main() {
    struct Node *a = calloc(1, sizeof(struct Node));
    if (a == NULL) {
        return 1;
    }
    a->val = 0;
    int v = 0;
    while (scanf("%d", &v) == 1) {
        if (v == 0) {
            if (a->val == 0) {
                printf("0 ");
                continue;
            }
            print(a);
            printf("0 ");
            a->val = 0;
            a->l = NULL;
            a->r = NULL;
            continue;
        } else if (a->val == 0) {
            a->val = v;
            a->p = a;
        } else if (insert(a, v, a)) {
            print(a);
            free(a);
            return 1;
        }
    }
    if (v != 0) {
        print(a);
        printf("0 ");
    }
    printf("\n");
    free(a);
}
