#include <stdio.h>

unsigned long alignUp(unsigned long address) {
    unsigned long boundarySize = 1 << 12; // 4KB
    return (address + boundarySize - 1) & ~(boundarySize - 1);
}
extern void mvstk();
extern unsigned long getsp();
unsigned recur(int n) {
	printf("%d\n", n);
        if (n > 0) {
                return recur(n-1) * 3;
        }
        return 1;
}


int main() {
	printf("sp %lx aligned %lx\n", getsp(), alignUp(getsp()));
	//while (1);
	mvstk();
	printf("%lx\n", alignUp(0x16fd00dc0));
	printf("%u\n", recur(100000));
	return 0;
}
