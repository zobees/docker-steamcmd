NAME=zobees/steamcmd
VERSION=0.0.1

.PHONY: all build

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .
