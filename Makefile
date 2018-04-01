.PHONY: all

all: build deploy

build:
	hugo

deploy:
ifdef msg
	$(MAKE) -C public deploy msg="$(msg)"
else
	$(MAKE) -C public deploy msg='site deploy'
endif

