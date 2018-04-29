
include config.mk

CXX_SRC:=$(wildcard $(SRCDIR)/*.cpp)
C_SRC:=$(wildcard $(SRCDIR)/*.c)
ASM_SRC:=$(wildcard $(SRCDIR)/*.asm)
S_SRC:=$(wildcard $(SRCDIR)/*.s)

SRC+=$(CXX_SRC) $(C_SRC) $(ASM_SRC) $(S_SRC)
OBJ+=$(patsubst $(SRCDIR)/%.cpp,$(OBJDIR)/%.cpp.o,$(CXX_SRC)) \
 	$(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.c.o,$(C_SRC)) \
	$(patsubst $(SRCDIR)/%.asm,$(OBJDIR)/%.asm.o,$(ASM_SRC)) \
	$(patsubst $(SRCDIR)/%.s,$(OBJDIR)/%.s.o,$(S_SRC))
BIN+=$(BUILD)/$(BINNAME)
LIB+=

.PHONY: all run clean mrproper

all: $(BINNAME)

run: $(BINNAME)
	./$(BINNAME)

$(BINNAME): $(SRC) $(OBJ) $(LIB) $(BIN)
	$(RUN) cp $(BIN) .

$(OBJDIR)/%.cpp.o: $(SRCDIR)/%.cpp
	$(RUN) mkdir -p $(OBJDIR)
	$(RUN) $(CXX) $(CXXLAGS) $(INCLUDE) -c -o $@ $^

$(OBJDIR)/%.c.o: $(SRCDIR)/%.c
	$(RUN) mkdir -p $(OBJDIR)
	$(RUN) $(CC) $(CFLAGS) $(INCLUDE) -c -o $@ $^

$(OBJDIR)/%.asm.o: $(SRCDIR)/%.asm
	$(RUN) mkdir -p $(OBJDIR)
	$(RUN) $(AS) $(ASFLAGS) $(INCLUDE) -o $@ $^

$(OBJDIR)/%.s.o: $(SRCDIR)/%.s
	$(RUN) mkdir -p $(OBJDIR)
	$(RUN) $(AS) $(ASFLAGS) $(INCLUDE) -o $@ $^

$(BIN): $(OBJ) $(LIB)
	$(RUN) mkdir -p $(BUILD)
	$(RUN) $(LD) $(LDFLAGS) -o $@ $^

clean:
	$(RUN) rm -rf target

mrproper: clean
	$(RUN) rm -rf $(BINNAME)
