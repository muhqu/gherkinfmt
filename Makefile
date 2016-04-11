

all: version build dist dist-info

GIT_VERSION=$(shell git describe HEAD 2>/dev/null || git describe --tags HEAD)

version:
	@echo "version: $(GIT_VERSION)" >&2
	@cat version.go | sed -e 's/\(VERSION = "\)[^\"]*\("\)/\1'$(GIT_VERSION)'\2/' > version.go.tmp
	@diff version.go.tmp version.go || (cat version.go.tmp > version.go)
	@rm version.go.tmp

build: build/gherkinfmt.osx build/gherkinfmt.linux build/gherkinfmt.exe

build/gherkinfmt.osx: *.go
	GOOS=darwin GOARCH=amd64 CGO_ENABLED=0 go build -o $@

build/gherkinfmt.linux: *.go
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o $@

build/gherkinfmt.exe: *.go
	GOOS=windows GOARCH=amd64 CGO_ENABLED=0 go build -o $@

dist: dist/gherkinfmt.osx.zip dist/gherkinfmt.linux.zip dist/gherkinfmt.win.zip

dist/gherkinfmt.osx.zip: build/gherkinfmt.osx build/gherkinfmt.osx.sha1
	- rm dist/gherkinfmt.osx.zip
	- rm -r dist/gherkinfmt.osx
	mkdir -p dist/gherkinfmt.osx/gherkinfmt
	cp build/gherkinfmt.osx dist/gherkinfmt.osx/gherkinfmt/gherkinfmt
	cd dist/gherkinfmt.osx/; zip -r gherkinfmt.zip gherkinfmt; mv gherkinfmt.zip ../gherkinfmt.osx.zip
	- rm -r dist/gherkinfmt.osx

dist/gherkinfmt.linux.zip: build/gherkinfmt.linux build/gherkinfmt.linux.sha1
	- rm dist/gherkinfmt.linux.zip
	- rm -r dist/gherkinfmt.linux
	mkdir -p dist/gherkinfmt.linux/gherkinfmt
	cp build/gherkinfmt.linux dist/gherkinfmt.linux/gherkinfmt/gherkinfmt
	cd dist/gherkinfmt.linux/; zip -r gherkinfmt.zip gherkinfmt; mv gherkinfmt.zip ../gherkinfmt.linux.zip
	- rm -r dist/gherkinfmt.linux

dist/gherkinfmt.win.zip: build/gherkinfmt.exe build/gherkinfmt.exe.sha1
	- rm dist/gherkinfmt.win.zip
	- rm -r dist/gherkinfmt.win
	mkdir -p dist/gherkinfmt.win/gherkinfmt
	cp build/gherkinfmt.exe dist/gherkinfmt.win/gherkinfmt/gherkinfmt.exe
	cd dist/gherkinfmt.win/; zip -r gherkinfmt.zip gherkinfmt; mv gherkinfmt.zip ../gherkinfmt.win.zip
	- rm -r dist/gherkinfmt.win

%.sha1: %
	openssl sha1 $^ | cut -d' ' -f2 | tee $@

clean:
	- rm -r build/ dist/

dist-info:
	@echo
	@printf "| %-20s | %-46s |\n" "Executable" "Checksum";
	@echo "|----------------------|------------------------------------------------|";
	@find ./build -name '*.sha1'\
	 | while read file; do \
	   printf "| %-20s | %-46s |\n" "$$(basename $$file .sha1)" "SHA1($$(cat $$file))"; \
	   done
	@echo

.PHONY: all build dist clean dist-info
