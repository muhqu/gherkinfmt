

all: build dist

build: build/gherkinfmt.osx build/gherkinfmt.linux build/gherkinfmt.exe

build/gherkinfmt.osx: gherkinfmt.go
	GOOS=darwin GOARCH=386 CGO_ENABLED=0 go build -o $@ gherkinfmt.go

build/gherkinfmt.linux: gherkinfmt.go
	GOOS=linux GOARCH=386 CGO_ENABLED=0 go build -o $@ gherkinfmt.go

build/gherkinfmt.exe: gherkinfmt.go
	GOOS=windows GOARCH=386 CGO_ENABLED=0 go build -o $@ gherkinfmt.go

dist: dist/gherkinfmt.osx.zip dist/gherkinfmt.linux.zip dist/gherkinfmt.win.zip

dist/gherkinfmt.osx.zip: build/gherkinfmt.osx
	- rm dist/gherkinfmt.osx.zip
	- rm -r dist/gherkinfmt.osx
	mkdir -p dist/gherkinfmt.osx/gherkinfmt
	cp build/gherkinfmt.osx dist/gherkinfmt.osx/gherkinfmt/gherkinfmt
	cd dist/gherkinfmt.osx/; zip -r gherkinfmt.zip gherkinfmt; mv gherkinfmt.zip ../gherkinfmt.osx.zip
	- rm -r dist/gherkinfmt.osx

dist/gherkinfmt.linux.zip: build/gherkinfmt.linux
	- rm dist/gherkinfmt.linux.zip
	- rm -r dist/gherkinfmt.linux
	mkdir -p dist/gherkinfmt.linux/gherkinfmt
	cp build/gherkinfmt.linux dist/gherkinfmt.linux/gherkinfmt/gherkinfmt
	cd dist/gherkinfmt.linux/; zip -r gherkinfmt.zip gherkinfmt; mv gherkinfmt.zip ../gherkinfmt.linux.zip
	- rm -r dist/gherkinfmt.linux

dist/gherkinfmt.win.zip: build/gherkinfmt.exe
	- rm dist/gherkinfmt.win.zip
	- rm -r dist/gherkinfmt.win
	mkdir -p dist/gherkinfmt.win/gherkinfmt
	cp build/gherkinfmt.exe dist/gherkinfmt.win/gherkinfmt/gherkinfmt.exe
	cd dist/gherkinfmt.win/; zip -r gherkinfmt.zip gherkinfmt; mv gherkinfmt.zip ../gherkinfmt.win.zip
	- rm -r dist/gherkinfmt.win

.PHONY: all build dist