CC := clang
CL := clang-cl
LIBS = lib
BUILD_DIR = bin
SRCS = $(wildcard app/*.c)
#shell find $(SRC_DIR) -name '*.c'
#shell := C:\Windows\System32\cmd.exe
LIB_ROOT := app/utility
#LIBSRC := $(shell dir /b /s $(LIB_ROOT)\*.c 2>nul)
# LIB_INCS := $(shell dir /b /s $(LIB_ROOT)\*.h 2>nul)
# LIB_INC_DIRS := $(sort $(dir $(LIB_INCS)))
ifneq ($(OS),Windows_NT)
# use dir on Windows and convert backslashes to forward slashes
# Get-ChildItem -Path "C:\Your\FolderPath" -Filter "*.txt" -Recurse
LIBSRC := $(subst \,/,$(strip $(shell "dir /b /s "$(LIB_ROOT)//*.c" 2>nul")))
LIB_INCS := $(subst \,/,$(strip $(shell dir /b /s "$(LIB_ROOT)//*.h" 2>nul)))
else
LIBSRC := $(shell find $(LIB_ROOT) -name "*.c" 2>/dev/null)
LIB_INCS := $(shell find $(LIB_ROOT) -name "*.h" 2>/dev/null)
endif
LIB_INC_DIRS := $(sort $(dir $(LIB_INCS)))
OBJS = $(patsubst %.c, $(BUILD_DIR)/%.o, $(SRCS))
LIB_OBJS = $(patsubst %.c, $(BUILD_DIR)/%.obj, $(LIBSRC))
.PHONY = clean install uninstall disributable
target := Hello_world.exe
LIB_TARGET := $(LIBS)/libutility.dll
LD_FLAGS := -l $(LIB_TARGET)
all: $(LIB_TARGET) $(OBJS)
	@echo dependancy is $(LIB_TARGET)
	$(CC) -L $(LIBS) -I$(LIB_INC_DIRS) $(OBJS) -o $(target) -llibutility -Wl $(BUILD_DIR)/$(LIB_ROOT)/src/factorial.obj
	
$(LIB_TARGET): $(LIB_OBJS)
	@echo source files for library are $(LIBSRC) and application source files are $(SRCS)
	@echo target is $(LIB_TARGET) and objects are $(LIB_OBJS)
	mkdir -p $(dir $@)
	$(CC) -shared $^ -o $@

$(BUILD_DIR)/%.o: %.c
	@echo compiling for $@
	mkdir -p $(dir $@)
	$(CC) -I$(LIB_INC_DIRS) -c $^ -o $@ 

$(BUILD_DIR)/%.obj: %.c
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
#shell find $(SRC_DIR) -name '*.c'
# shell := C:\Windows\System32\cmd.exe
# LIBSRC = $(shell find app -name "*.c")
# LIB_INC_DIRS := $(sort $(dir $(shell /c dir app\utility\*.h /S /B)))
# OBJS = $(patsubst %.c, $(BUILD_DIR)/%.o, $(SRCS))
# LIB_OBJS = $(patsubst %.c, $(BUILD_DIR)/%.o, $(LIBSRC))
# .phony = clean install uninstall disributable
# target = Hello_world
# LIB_TARGET = $(LIBS)/libutility.dll
# LD_FLAGS = -l $(B_TARGET) $(OBJS)
# 	@echo dependancy is $(LIB_TARGET)
# 	$(CC) -L $(LIBS) $(OBJS) -o $(target) -lutility -Wl -rpath $(LIBS)
	
# $(LIB_TARGET): $(LIB_OBJS)
# 	@echo target is $(LIB_TARGET) and objects are $(LIB_OBJS)
# 	mkdir -p $(dir $@)
# 	$(CC) -shared $^ -o $@

# $(BUILD_DIR)/%.o: %.c
# 	@echo compiling for $@
# 	mkdir -p $(dir $@)
# 	$(CC) -I$(LIB_INC_DIRS) -c $^ -o $@ 

# install:
# 	mkdir -p /usr/local/bin
# -p /usr/local/lib
# 	cp $(target) /usr/local/bin
# 	cp $(LIB_TARGET) /usr/local/lib

# uninstall:
# 	rm -f /usr/local/bin/$(target)
# 	#rm -f /usr/local/lib/$(LIB_TARGET)
	
# clean:
# 	rm -rf $(OBJS) $(LIB_OBJS) $(target) $(LIB_TARGET)
# stall:
# 	rm -f /usr/local/bin/$(target)
# 	#rm -f /usr/local/lib/$(LIB_TARGET)
# 		rm -rf $(OBJS) $(LIB_OBJS) $(target) $(LIB_TARGET)
# $(LIB_TARGET)##