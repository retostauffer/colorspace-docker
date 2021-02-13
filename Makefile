


# Delete all non-running containers and images
prune:
	docker system prune -a


build:
	-docker rm colorspace
	docker build . -t colorspace

# 3838 is the default port for shiny server
up:
	docker run -d -p 3000:3808 colorspace

run:
	docker run -p 3000:3838 -it colorspace:latest

shell:
	docker run -it --entrypoint /bin/bash colorspace:latest
