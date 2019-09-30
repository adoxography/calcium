SHARDS_BIN ?= $(shell which shards)

build: bin/calcium

bin/calcium:
	$(SHARDS_BIN) build $(CRFLAGS)

clean:
	rm -f ./bin/calcium ./bin/calcium.dwarf

bin: build
