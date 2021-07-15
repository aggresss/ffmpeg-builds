all:
	@cmake . -Bbuild && make -C build
clean:
distclean: clean
	@rm -rf build
