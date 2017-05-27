CC = gcc
CFLAGS = -g -Wall -O0

EXEC = libsum

OUT = .build

LIB_SUM_RELEASE = libsum.so.1.0.0
LIB_SUM_MAJOR = libsum.so.1

.PHONY: all
all: $(OUT) $(EXEC)

$(OUT)/%_static.o: %.c %.h
	$(CC) $(CFLAGS) -c $< -o $@

$(OUT)/%_dynamic.o: %.c %.h
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

libsum: $(OUT)/sum_static.o $(OUT)/sum_dynamic.o
	ar -rcs $(OUT)/libsum.a $(OUT)/sum_static.o
	$(CC) $(CFLAGS) -shared -Wl,-soname,$(LIB_SUM_MAJOR) -o $(OUT)/$(LIB_SUM_RELEASE) $(OUT)/sum_dynamic.o
	ln -sf $(LIB_SUM_RELEASE) $(OUT)/libsum.so
	ln -sf $(LIB_SUM_RELEASE) $(OUT)/$(LIB_SUM_MAJOR)

$(OUT):
	mkdir -p $@

.PHONY: clean clobber
clean: 
	-rm -rf $(OUT)/*.o

clobber: clean
	-rm -rf $(OUT)

