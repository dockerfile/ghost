## Ghost Dockerfile


This repository contains **Dockerfile** of [Ghost](https://www.ghost.org/) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/dockerfile/ghost/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [dockerfile/nodejs](http://dockerfile.github.io/#/nodejs)


### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/dockerfile/ghost/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull dockerfile/ghost`

   (alternatively, you can build an image from Dockerfile: `docker build -t="dockerfile/ghost" github.com/dockerfile/ghost`)


### Usage

    docker run -d -p 80:2368 dockerfile/ghost

#### Customizing Ghost

    docker run -d -p 80:2368 -v <override-dir>:/ghost-override dockerfile/ghost

where `<override-dir>` is an absolute path of a directory that could contain:

  - `config.js`: custom config file copied from [here](https://github.com/TryGhost/Ghost/blob/master/config.example.js) (you must replace `127.0.0.1` with `0.0.0.0`)
  - `content/data/`: persistent/shared data
  - `content/images/`: persistent/shared images
  - `content/themes/`: more themes

After few seconds, open `http://<host>` for blog or `http://<host>/ghost` for admin page.


#### Running Ghost in development environment with forever

    docker run -d -p 80:2368 -e NODE_ENV=development -e WATCH_DIRECTORY=<dir-to-watch> -v <override-dir>:/ghost-override dockerfile/ghost

where `<dir-to-watch>` is a relative path to /ghost

##### Why forever
When Ghost starts with the help of forever https://www.npmjs.com/package/forever and its watchDirectory option.
Then we can develop on a shared `ghost-override` volume and forever will watch for file changes in `watchDirectory`.
When we change a file inside `watchDirectory` forever, after a few seconds, restarts the Ghost process without stoping docker.

e.g.
    
    docker run -d -p 80:2368 -e NODE_ENV=development -e WATCH_DIRECTORY=content/themes/my_theme -v /home/my_localhost_ghost:/ghost-override dockerfile/ghost

or in this case better interactive to see when our process restarts

    docker run -p 80:2368 -e NODE_ENV=development -e WATCH_DIRECTORY=content/themes/my_theme -v /home/my_localhost_ghost:/ghost-override dockerfile/ghost

