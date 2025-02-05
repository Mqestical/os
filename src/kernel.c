#include "inb_outb.c"

#define SERIAL_PORT 0x3F8

void write_serial(char a) {
    while ((inb(SERIAL_PORT + 5) & 0x20) == 0); // waiting for port to be ready.
    outb(SERIAL_PORT, a);
}

void print_char(char c, unsigned char color) {
    unsigned short* video_memory = (unsigned short*) 0xB8000;
    static unsigned int offset = 0;

    video_memory[offset] = (color << 8) | c;

    // move to the next position
    offset++;
    if (offset >= 2000) offset = 0;  // wrap around if we exceed 80x25
}
void print_string(const char* str, unsigned char color) {
    while (*str) {
        print_char(*str, color);
        str++;
    }
}

void shutdown() {
    outb(0x64, 0xFE);
}


void main() {
    print_string("Hello, World!", 0x1F);

    while (1);
}
