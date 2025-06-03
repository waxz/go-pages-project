.PHONY: go-init
go-init:
	go mod tidy

.PHONY: dev
dev:
	npx wrangler pages dev

.PHONY: build-go
build-go:
	if [ -d ./build ]; then rm -r ./build/;fi
	go run github.com/syumai/workers/cmd/workers-assets-gen@v0.29.0 -mode go
	GOOS=js GOARCH=wasm go build -o ./build/app.wasm ./...

.PHONY: build
build:
	if [ -d ./build ]; then rm -r ./build/;fi
	go run github.com/syumai/workers/cmd/workers-assets-gen@v0.29.0
	tinygo build -o ./build/app.wasm -target wasm -no-debug ./...

.PHONY: deploy
deploy:
	npx wrangler pages deploy
