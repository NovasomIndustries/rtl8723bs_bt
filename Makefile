CROSS_COMPILE ?=

CC      := $(CROSS_COMPILE)gcc
CFLAGS  ?= -O2 -W -Wall
LDFLAGS ?=

%.o : %.c
        $(CC) $(CFLAGS) -c -o $@ $<

all: rtk_hciattach

rtk_hciattach: hciattach_rtk.o
        $(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

clean:
        -rm -f *.o
        -rm -f rtk_hciattach

