.PHONY: payload.dylib

shellcode.bin: shellcode.s payload.dylib Makefile2
	#aarch64-linux-gnu-as -EL -o shellcode.o shellcode.s
	#aarch64-linux-gnu-objcopy -O binary shellcode.o shellcode.bin
	as -arch arm64 shellcode.s -o shellcode.o
	gobjcopy -Obinary shellcode.o shellcode.bin
	rm shellcode.o
	dd if=/dev/zero of=shellcode.bin bs=1 count=1 seek=4095
	cat payload.dylib >> shellcode.bin

shellcode.s: shellcode.in.s payload.dylib Makefile2
	python2 gen_shellcode.py

payload.dylib:
	Makefile2
