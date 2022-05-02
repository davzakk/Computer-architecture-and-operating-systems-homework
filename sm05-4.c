#include <stdio.h>
#include <unistd.h>

struct FileWriteState {
    int fd;
    unsigned char *buf;
    int bufsize;
    int counter;
};

static unsigned char lst[4096];

static struct FileWriteState stout_not_ptr = {1, lst, sizeof(lst), 0};

struct FileWriteState *stout = &stout_not_ptr;

void flush(struct FileWriteState *out) {
	write(out->fd, out->buf, out->counter);
	out->counter = 0;
}

void writechar(int c, struct FileWriteState *out) {
	*(out->buf + out->counter) = c;
	out->counter++;
	if (out->counter == sizeof(lst)) {
		flush(out);
	}
}
