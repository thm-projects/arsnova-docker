# ARSnova Docker

This repository contains configuration files for the creation of Docker images for the ARSnova Audience Response System.
Pre-built ARSnova images are available at [Docker Hub](https://hub.docker.com/u/arsnova/).

The information in this repository applies to ARSnova version 2 which is no longer under active development.
ARSnova 2 is still maintained meaning it receives security and other important bug fixes but you should not expect any new features.
Head over to our [main repository](https://gitlab.com/particify/dev/foss/arsnova) for information regarding ARSnova 3.


## Running ARSnova 2 on Docker

Follow these steps to setup Docker for running ARSnova:

1. Make sure that Docker is installed and up to date.
2. Initialize Docker's swarm mode:
   `docker swarm init`
3. Download [docker-compose.yml](docker-compose.yml) and [webapp.env](webapp.env) to a new directory.
4. Run `docker stack deploy -c docker-compose.yml arsnova` in the previously created directory.

That's it. You should now be able to access ARSnova at http://localhost.
You can change configuration settings in webapp.env.

## Building the Images

Follow these steps to build Docker images for ARSnova:

1. Make sure that Docker and Docker Compose are installed and up to date.
2. Clone this repository and `cd` into it.
3. Run `docker-compose build`.

You can now run `docker-compose start` and test the images.
ARSnova should be running at http://localhost.
