#!make

FN_NAME?=bitcoinfn

deps:
	@$(which docker)
	@$(which helm)

build: deps
	@echo "build"
	docker image build \
    -f Dockerfile.lambda \
    -t lambda-zip:latest .

	docker container run --rm \
    --name lambda-zip \
    -v "$$(pwd)":/lambda \
    lambda-zip:latest

	sha256sum function.zip

deploy: deps
	@echo "deploy"
	helm upgrade --wait \
		-i $(FN_NAME) \
		./charts/$(FN_NAME) \
		--namespace default \
		-f ./charts/$(FN_NAME)/values.yaml \
		--set-string function.sha256Sum="$$(sha256sum function.zip | awk -F ' ' '{print $$1}')"

build-local: deps
	@echo "build-local"
	docker image build \
    -f Dockerfile \
    -t lambda:latest .

run-local: deps
	@echo "run-local"
	docker container run --rm \
    --name lambda \
    -v "$$(pwd)/src:/usr/src/app" \
    lambda:latest

destroy: deps
	@echo "destroy"
	helm uninstall $(FN_NAME) \
		--namespace default
