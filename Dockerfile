#
# Ghost Dockerfile
#
# https://github.com/dockerfile/ghost
#

# Pull base image.
FROM dockerfile/nodejs

# Install Ghost
RUN mkdir -p /ghost
RUN cd /ghost && wget https://ghost.org/zip/ghost-latest.zip
RUN cd /ghost && unzip ghost.zip && rm -f ghost.zip
RUN cd /ghost && npm install --production
RUN sed 's/127.0.0.1/0.0.0.0/' /ghost/config.example.js > /ghost/config.js

# Mount volumes.
VOLUME /ghost-override

# Define working directory.
WORKDIR /ghost

# Add files.
ADD start.bash /ghost-start

# Expose ports.
EXPOSE 2368

# Define an entry point.
ENV NODE_ENV production
CMD ["bash", "/ghost-start"]
