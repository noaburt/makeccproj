
# A simple makefile to compile the mkcc tool

all: mkcc

mkcc: src/mkcc.c src/functions.c
	gcc -o mkcc src/functions.c src/mkcc.c -I includes/. -Wall -pedantic
