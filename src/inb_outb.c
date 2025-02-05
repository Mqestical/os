// Define the I/O port read and write functions
static inline unsigned char inb(unsigned short port) {
    unsigned char result;
    __asm__ __volatile__ ("inb %1, %0" : "=a" (result) : "d" (port));
    return result;
}

static inline void outb(unsigned short port, unsigned char data) {
    __asm__ __volatile__ ("outb %0, %1" : : "a" (data), "d" (port));
}
