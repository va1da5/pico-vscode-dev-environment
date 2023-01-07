.PHONY: all
all: build flash

BINARY = blink

.PHONY: build
build:
	mkdir -p build \
	&& cd ./build \
	&& cmake ..; \
	make $(BINARY)

.PHONY: flash
flash:
	cd ./build; \
	openocd -f interface/picoprobe.cfg -f target/rp2040.cfg -c "program $(BINARY).elf verify reset exit"
