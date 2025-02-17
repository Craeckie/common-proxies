BUILD_DIR=./bin
DOCKER_CMD=docker run --rm -it -v "$$PWD":/usr/src/myapp -w /usr/src/myapp golang:1.15

local:
	go build -o up-rewrite
local-docker:
	$(DOCKER_CMD) make local
all:
	install -d bin
	OUTPUT="${BUILD_DIR}/up-rewrite" ./go-build-all.sh	
	cd bin; \
		sha256sum * > sha256
all-docker:
	$(DOCKER_CMD) make all	

test: local
	go test ./...  
test-docker:
	$(DOCKER_CMD) go test ./...

# check out this if the cross-docker things don't work https://stackoverflow.com/a/65371609/8919142

build-local:
	docker build . -t unifiedpush/common-proxies:testing

