# Compiler and Assembler
ASM = nasm
CC = gcc
LD = ld

# Directories
SRC_DIR = ../src  # Ensure the correct relative path
BUILD_DIR = ../bin

# Kernel and bootloader sources
KERNEL_SRC = ../src/kernel.c  # Corrected to the relative path
KERNEL_SRC_EXTRA = ../src/inb_outb.c  # Extra C source file for inb/outb
BOOTLOADER_SRC = ../src/load.asm

# Output files
KERNEL_OBJ = $(BUILD_DIR)/kernel.o $(BUILD_DIR)/inb_outb.o  # Object files
KERNEL_BIN = $(BUILD_DIR)/kernel.bin
BOOTLOADER_BIN = $(BUILD_DIR)/load.bin
FLP_IMAGE = $(BUILD_DIR)/load_floppy.img

# Kernel load address
KERNEL_LOAD_ADDR = 0x1000

# Compile the kernel (C -> OBJ)
$(KERNEL_OBJ): $(KERNEL_SRC) $(KERNEL_SRC_EXTRA)  # Include inb_outb.c in the compilation
	$(CC) -ffreestanding -c $(KERNEL_SRC) -o $(BUILD_DIR)/kernel.o
	$(CC) -ffreestanding -c $(KERNEL_SRC_EXTRA) -o $(BUILD_DIR)/inb_outb.o  # Compile inb_outb.c

# Link the kernel with the bootloader (OBJ + BIN -> BIN)
$(KERNEL_BIN): $(KERNEL_OBJ) $(BOOTLOADER_BIN)
	$(LD) -T linker.ld -o $(KERNEL_BIN) $(KERNEL_OBJ) $(BOOTLOADER_BIN)

# Compile the bootloader (ASM -> BIN)
$(BOOTLOADER_BIN): $(BOOTLOADER_SRC)
	$(ASM) $(BOOTLOADER_SRC) -f bin -o $(BOOTLOADER_BIN)

# Create the floppy image (BOOTLOADER + KERNEL)
$(FLP_IMAGE): $(KERNEL_BIN)
	cp $(KERNEL_BIN) $(FLP_IMAGE)
	truncate -s 1440k $(FLP_IMAGE)

# Clean up intermediate files
clean:
	rm -f $(KERNEL_OBJ) $(KERNEL_BIN) $(BOOTLOADER_BIN) $(FLP_IMAGE)