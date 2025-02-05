# linker.ld
OUTPUT_FORMAT("elf32-i386")
ENTRY(start)

SECTIONS {
    . = 0x1000;  # Load the kernel at address 0x1000

    .text : {
        *(.text)  # Include all text (code) sections
    }
    .data : {
        *(.data)  # Include all data sections
    }
}

