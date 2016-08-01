PROJECT = FUJI
OUTDIR = bin
EXECUTABLE = $(OUTDIR)/$(PROJECT)
#tool chain
CROSS_COMPILE ?=
CC = $(CROSS_COMPILE)g++
LD = $(CROSS_COMPILE)ld
CFLAGS += -Wall
LDFLAGS += -lwinmm
#file
SRCDIR = src
INCDIR = inc
SRC += $(wildcard $(addsuffix /*.cpp,$(SRCDIR)))
#SRC += $(wildcard $(addsuffix /$(OTHER_SRC_DIR)/*.c,$(SRCDIR)))
OBJS += $(addprefix $(OUTDIR)/,$(patsubst %.s,%.o,$(SRC:.cpp=.o)))
INCLUDES = $(addprefix -I,$(INCDIR))
#INCLUDES += $(addprefix -I,$(INCDIR)/$(OTHER_INC_DIR))

all:$(EXECUTABLE)

#link stage
$(EXECUTABLE): $(OBJS)
	@echo "[ LD ]    "$@
	@$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) 

#compile stage
$(OUTDIR)/%.o: %.cpp
	@echo "[ CC ]    "$@
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -MMD -MF $(patsubst %.o,%.d,$@) -c $(INCLUDES) $< -o $@  

.PHONY: clean
clean:
	@rm -rf $(OUTDIR)
	@echo "Removing output directory"
