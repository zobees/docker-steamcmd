NAME=zobees/steamcmd

.PHONY: all build

all: build

build:
	docker build -t $(NAME) --rm .
