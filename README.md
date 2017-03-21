# ARSnova Docker

This repository contains configuration files for the creation of Docker images for the ARSnova Audience Response System.
Pre-built ARSnova images are available at [Docker Hub](https://hub.docker.com/u/arsnova/).

## Running ARSnova on Docker

Follow these steps to setup Docker for running ARSnova:

1. Make sure that Docker is installed
2. Initialize Docker's swarm mode:
   `docker swarm init`
3. Download [docker-compose.yml](docker-compose.yml)
4. Run `docker deploy --compose-file docker-compose.yml`

That's it. You should now be able to access ARSnova at http://localhost.

## Building the Images

Follow these steps to build Docker images for ARSnova:

1. Make sure that Docker and Docker Compose are installed
2. Clone this repository and `cd` into it
3. Run `docker-compose build`

You can now run `docker-compose start` and test the images.
ARSnova should be running at http://localhost.
