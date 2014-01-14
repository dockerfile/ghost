#
# Ghost Dockerfile
#
# https://github.com/dockerfile/ghost
#

# Pull base image.
FROM dockerfile/nodejs

# Install Ghost
RUN wget https://ghost.org/zip/ghost-0.4.0.zip -O ghost.zip
RUN mkdir /ghost && unzip ghost.zip -d /ghost && rm -f ghost.zip
RUN cd /ghost && npm install --production
RUN sed 's/127.0.0.1/0.0.0.0/' /ghost/config.example.js > /ghost/config.js

# Mount data directory.
VOLUME /ghost/content/data

# Define working directory.
WORKDIR /ghost

# Expose ports.
EXPOSE 2368

# Define an entry point.
ENV NODE_ENV production
CMD ["npm", "start"]
