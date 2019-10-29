.PHONY: build clean deploy

build:
	dep ensure -v
	env GOOS=linux go build -ldflags="-s -w" -o bin/configs configs/main.go
	env GOOS=linux go build -ldflags="-s -w" -o bin/findings findings/main.go
	env GOOS=linux go build -ldflags="-s -w" -o bin/start-scan start-scan/main.go
	env GOOS=linux go build -ldflags="-s -w" -o bin/summary summary/main.go

clean:
	rm -rf ./bin ./vendor Gopkg.lock

deploy: clean build
	sls deploy --verbose
