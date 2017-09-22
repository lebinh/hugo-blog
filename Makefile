.PHONY: all

all: build deploy

build:
	hugo

deploy:
	cd public
	git add .
ifdef msg
	git commit -m '$(msg)'
else
	git commit -m 'site deploy'
	git push origin master
	cd ..
endif

