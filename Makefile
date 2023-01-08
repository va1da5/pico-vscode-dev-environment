.PHONY: all
all: build flash

BINARY = usb_host

.PHONY: build
build:
	mkdir -p build \
	&& cd ./build \
	&& cmake ..; \
	make $(BINARY)

.PHONY: reset
reset:
	openocd -f interface/picoprobe.cfg -f target/rp2040.cfg -c "init; reset; exit"

.PHONY: flash
flash: reset
	cd ./build; \
	openocd -f interface/picoprobe.cfg -f target/rp2040.cfg -c "program $(BINARY).elf verify reset exit"

.PHONY: clean
clean:
	@rm -rf ./build