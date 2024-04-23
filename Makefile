CC = gcc
CFLAGS= -g -Wall
INCLUDE = -L /usr/lib/x86_64-linux-gnu
LIBS = -lX11 -lXext -lXrender

all:
	${CC} x11.c ${CFLAGS} ${INCLUDE} ${LIBS} -o x11

install:
	install x11 '/usr/local/bin'

uninstall:
	rm -f '/usr/local/bin/xwinwrap'

clean:
	rm -f x11
