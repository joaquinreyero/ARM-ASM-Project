ARMGNU ?= aarch64-linux-gnu

AOPS = --warn --fatal-warnings

asm : build/kernel.img

all : asm

clean :
	rm -f build/*.o
	rm -f build/*.img
	rm -f build/*.hex
	rm -f build/*.elf
	rm -f build/*.list
	rm -f build/*.img
	rm -f build/memory_map.txt

build/main.o : main.s
	$(ARMGNU)-as $(AOPS) main.s gpio.s app.s -o build/main.o

build/kernel.img : memmap build/main.o
	$(ARMGNU)-ld build/main.o -T memmap -o build/main.elf -M > build/memory_map.txt
	$(ARMGNU)-objdump -D build/main.elf > build/main.list
	$(ARMGNU)-objcopy build/main.elf -O ihex build/main.hex
	$(ARMGNU)-objcopy build/main.elf -O binary build/kernel8.img