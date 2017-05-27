EXEC = main_static \
       main_dynamic \
       main_dl

export CC = gcc
export CFLAGS = -g -Wall -O0
export LD_LIBRARY_PATH=./lib/.build

DIR_LIB = ./lib

.PHONY: all
all: $(OUT) $(EXEC)

run: all
	./main_static
	./main_dynamic
	./main_dl

$(EXEC):
	cd $(DIR_LIB) && $(MAKE)
	$(CC) $(CFLAGS) main.c -I$(DIR_LIB) -static -L$(DIR_LIB)/.build -lsum -o main_static -DSTATIC
	$(CC) $(CFLAGS) main.c -I$(DIR_LIB) -L$(DIR_LIB)/.build -lsum -o main_dynamic -DDYNAMIC
	$(CC) $(CFLAGS) main.c -ldl -o main_dl -DDL

.PHONY: clean clobber
clean:
	cd $(DIR_LIB) && $(MAKE) $@

clobber:
	cd $(DIR_LIB) && $(MAKE) $@
	-rm -rf $(EXEC)


