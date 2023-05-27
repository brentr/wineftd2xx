#Makefile for wineftd2xx<->ftd2xx shim dll
#WARNING:  omitting frame pointer causes crashes
CFLAGS = -Os -Wall
LIBS=libxftd2xx.a -ldl -lrt -lpthread

VER=1.4.22

RELEASE=wineftd2xx${VER}

ARCH ?= $(shell uname -m)
ifeq (i686,$(ARCH))
  ARCH = i386
endif

WINELIBDIR := $(shell ./winelibdir $(ARCH))
ifeq ("$(WINELIBDIR)", "")
$(error Can't guess WINELIBDIR -- \
  specify it with make WINELIBDIR={path_to_dll.so directory})
endif
$(info WINELIBDIR=$(WINELIBDIR))

#path to FTDI's linux libftd2xx1.4.22 top-level directory
LIBFTD = libftd2xx${VER}
IDIR = $(LIBFTD)

TARBALL = libftd2xx-${ARCH}-${VER}.tgz

ARCHIVE = $(LIBFTD)/build/libftd2xx.a
$(info Linked with $(ARCHIVE))

ifeq (i386,$(ARCH))
MACHINE = -m32
endif

ifeq (x86_64,$(ARCH))
MACHINE = -m64
endif

CFLAGS += $(MACHINE)

all: ftd2xx.dll.so libftd2xx.def

$(TARBALL):
	wget https://www.ftdichip.com/Drivers/D2XX/Linux/${TARBALL}
	touch -t 1201010000 $(TARBALL)  #we want this file to look old!

$(ARCHIVE) $(IDIR)/ftd2xx.h:  $(TARBALL)
	tar xzf $(TARBALL)
	rm -rf $(LIBFTD)
	mv release $(LIBFTD)

libxftd2xx.a:  $(ARCHIVE) xFTsyms.objcopy
	objcopy --redefine-syms=xFTsyms.objcopy $(ARCHIVE) libxftd2xx.a

xftd2xx.h:  $(IDIR)/ftd2xx.h Makefile
	sed "s/WINAPI FT_/xFT_/g" $(IDIR)/ftd2xx.h >$@
	sed -i "/^#include <windows\.h>.*/a typedef const char \*LPCTSTR;" $@

ftd2xx.o: ftd2xx.c xftd2xx.h WinTypes.h
	winegcc -D_REENTRANT -D__WINESRC__ -c $(CFLAGS) \
          -I$(IDIR) -fno-omit-frame-pointer -o $@ ftd2xx.c

ftd2xx.dll.so: ftd2xx.o ftd2xx.spec libxftd2xx.a
	winegcc $(CFLAGS) -mwindows -lntdll -lkernel32 \
          -o ftd2xx.dll ftd2xx.o libxftd2xx.a -shared ftd2xx.spec $(LIBS)
	chmod -x $@

libftd2xx.def: ftd2xx.spec ftd2xx.dll.so
	winebuild $(MACHINE) -w --def -o $@ --export ftd2xx.spec

install:  ftd2xx.dll.so
	cp ftd2xx.dll.so $(WINELIBDIR)

uninstall:
	rm -f $(WINELIBDIR)/ftd2xx.dll.so $(WINELIBDIR)/libftd2xx.def

clean:
	rm -f *.o *xftd2xx.* *.so *.def $(ARCHIVE)

distclean:  clean
	rm -rf $(LIBFTD) $(RELEASE)
	rm -f $(TARBALL) $(RELEASE).tar.gz

release:
	rm -rf $(RELEASE)
	mkdir $(RELEASE)
	cp -a etc *.c *.h *.spec *.objcopy Makefile winelibdir README* \
	  $(RELEASE)
	tar zvcf $(RELEASE).tar.gz $(RELEASE)

