
BINNAME?=hello
ARCH?=x86_64
OS?=linux
USERSPACE?=musl

SRCDIR:=src
INCLUDE:=-Iinclude/ -I$(SRCDIR)/
LIBDIR:=lib

CC:=gcc
CXX:=g++
AS:=nasm
LD:=ld

LIBC:=lib/musl/lib
OBJ:=$(LIBC)/crt1.o
LIB:=$(wildcard $(LIBC)/*.a)

ifeq ($(RELEASE),1)
TARGET:=release
NDEBUG:=1
else
TARGET:=debug
endif

ifeq ($(OS),linux)
EXE64:=elf64
EXE32:=elf32
else ifeq ($(OS),windows)
EXE64:=win64
EXE32:=win32
else ifeq ($(OS),osx)
EXE64:=macho64
EXE32:=macho32
else
$(error unsuppored os \"$(ARCH)\")
endif # $(OS)

ifeq ($(ARCH),x86_64)
EXEFORMAT:=$(EXE64)
BITS:=64
else ifeq ($(ARCH),x86-64)
ARCH:=x86_64
EXEFORMAT:=$(EXE64)
BITS:=64
else ifeq ($(ARCH),amd64)
ARCH:=x86_64
EXEFORMAT:=$(EXE64)
BITS:=64
else ifeq ($(ARCH),x86)
EXEFORMAT:=$(EXE32)
BITS:=32
else
$(error unsuppored architecture \"$(ARCH)\")
endif # $(ARCH)

ifdef NDEBUG
CFLAGS+=-DNDEBUG
endif

ifdef DELAY_SEC
CFLAGS+=-DDELAY_SEC=$(DELAY_SEC)
endif

ifdef DELAY_NSEC
CFLAGS+=-DDELAY_NSEC=$(DELAY_NSEC)
endif

ifdef RANDOM_IGNORE
CFLAGS+=-DRANDOM_IGNORE=$(RANDOM_IGNORE)
endif

CFLAGS+=-Wall -O0
CXXFLAGS+=$(CFLAGS)
ASFLAGS+=-f $(EXEFORMAT) 

ifdef DRY
RUN:=@echo
else
RUN:=
endif

BUILD:=target/$(TARGET)/$(ARCH)-$(OS)-$(USERSPACE)
OBJDIR:=$(BUILD)/obj
