all:hciattach.c hciattach_rtk.o  
	cc -o rtk_hciattach hciattach.c hciattach_rtk.o  

hciattach_rtk.o:hciattach_rtk.c
	cc -c hciattach_rtk.c

clean:
	rm -f *.o  rtk_hciattach

install:
	cp -p rtk_hciattach /usr/bin/.
