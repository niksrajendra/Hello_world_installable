CC = clang
LIBS = lib
BUILD_DIR = bin
SRCS = $(wildcard app/*.c)
#shell find $(SRC_DIR) -name '*.c'
LIBSRC = $(shell find app/utility/ -name '*.c')
LIB_INC_DIRS := $(sort $(dir $(shell find app/utility -name "*.h")))
OBJS = $(patsubst %.c, $(BUILD_DIR)/%.o, $(SRCS))
LIB_OBJS = $(patsubst %.c, $(BUILD_DIR)/%.o, $(LIBSRC))
.phony = clean install uninstall disributable
target = Hello_world
LIB_TARGET = $(LIBS)/libutility.so
LD_FLAGS = -l $(LIB_TARGET)
all: $(LIB_TARGET) $(OBJS)
	@echo dependancy is $(LIB_TARGET)
	$(CC) -L $(LIBS) $(OBJS) -o $(target) -lutility -Wl -rpath $(LIBS)
	
$(LIB_TARGET): $(LIB_OBJS)
	@echo target is $(LIB_TARGET) and objects are $(LIB_OBJS)
	mkdir -p $(dir $@)
	$(CC) -shared $^ -o $@

$(BUILD_DIR)/%.o: %.c
	@echo compiling for $@
	mkdir -p $(dir $@)
	$(CC) -I$(LIB_INC_DIRS) -c $^ -o $@ 

install:
	mkdir -p /usr/local/bin
	mkdir -p /usr/local/lib
	cp $(target) /usr/local/bin
	cp $(LIB_TARGET) /usr/local/lib

uninstall:
	rm -f /usr/local/bin/$(target)
	#rm -f /usr/local/lib/$(LIB_TARGET)
	
clean:
	rm -rf $(OBJS) $(LIB_OBJS) $(target) $(LIB_TARGET)
