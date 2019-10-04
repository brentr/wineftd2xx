#Makefile for wineftd2xx<->ftd2xx shim dll
#WARNING:  omitting frame pointer causes crashes
CFLAGS = -g -O0 -Wall
LIBS=libxftd2xx.a -ldl -lrt -lpthread

RELEASE=wineftd2xx1.1.1

#ARCH ?= $(shell uname -m)
ARCH=i386

#WINEDLLPATH := $(shell ./winedllpath $(ARCH))

WINEDLLPATH := "/usr/lib32/wine/"

ifeq ("$(WINEDLLPATH)", "")
$(error Can't guess WINEDLLPATH -- \
  specify it with make WINEDLLPATH={path_to_dll.so directory})
endif
$(info WINEDLLPATH=$(WINEDLLPATH))

#path to FTDI's linux libftd2xx1.1.12 top-level directory
LIBFTD = libftd2xx1.1.12
IDIR = $(LIBFTD)
TARBALL = $(LIBFTD).tar.gz

sixty4 := $(findstring 64-bit, $(shell file $(WINEDLLPATH)/version.dll.so))

ifeq (,$(ARCH))
ifneq (,$(sixty4))
ARCH = x86_64
else
ARCH = i386
endif
endif
ARCHIVE = $(LIBFTD)/build/$(ARCH)/libftd2xx.a
$(info Link with $(ARCHIVE))

ifeq (i386,$(ARCH))
CFLAGS += -m32
endif

all: libftd2xx.def ftd2xx.dll.so

$(TARBALL):
	wget http://www.ftdichip.com/Drivers/D2XX/Linux/$(TARBALL)
	touch -t 1201010000 $(TARBALL)

$(ARCHIVE) $(IDIR)/ftd2xx.h:  $(TARBALL)
	tar xzf $(TARBALL)
	rm -rf $(LIBFTD)
	mv release $(LIBFTD)

libxftd2xx.a:  $(ARCHIVE) xFTsyms.objcopy
	objcopy --redefine-syms=xFTsyms.objcopy $(ARCHIVE) libxftd2xx.a

xftd2xx.h:  $(IDIR)/ftd2xx.h Makefile
	sed "s/WINAPI FT_/xFT_/g" $(IDIR)/ftd2xx.h >$@

ftd2xx.o: ftd2xx.c xftd2xx.h WinTypes.h
	winegcc -D_REENTRANT -D__WINESRC__ -c $(CFLAGS) \
          -I$(IDIR) -fno-omit-frame-pointer -o $@ ftd2xx.c

ftd2xx.dll.so: ftd2xx.o ftd2xx.spec libxftd2xx.a
	winegcc $(CFLAGS) -mwindows -lntdll -lkernel32 \
          -o ftd2xx.dll ftd2xx.o libxftd2xx.a -shared ftd2xx.spec $(LIBS)

libftd2xx.def: ftd2xx.spec ftd2xx.dll.so
	winebuild -w --def -o $@ --export ftd2xx.spec

install:        ftd2xx.dll.so libftd2xx.def
	cp ftd2xx.dll.so libftd2xx.def  $(WINEDLLPATH)

uninstall:
	rm -f $(WINEDLLPATH)/ftd2xx.dll.so $(WINEDLLPATH)/libftd2xx.def

clean:
	rm -f *.o *xftd2xx.* *.so *.def

distclean:  clean
	rm -rf $(LIBFTD) $(RELEASE)
	rm -f $(TARBALL) $(RELEASE).tar.gz

release:
	rm -rf $(RELEASE)
	mkdir $(RELEASE)
	cp -a etc *.c *.h *.spec *.objcopy Makefile winedllpath README* \
	  $(RELEASE)
	tar zvcf $(RELEASE).tar.gz $(RELEASE)

