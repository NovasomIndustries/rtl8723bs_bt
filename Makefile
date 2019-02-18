CROSS_COMPILE ?=

CC      := $(CROSS_COMPILE)gcc
CFLAGS  ?= -O2 -W -Wall
LDFLAGS ?=
LIBS    := -lrt

%.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $<

all: rtk_hciattach

rtk_hciattach:hciattach.c hciattach_rtk.o
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

hciattach_rtk.o:hciattach_rtk.c

clean:
	-rm -f *.o
	-rm -f rtk_hciattach

