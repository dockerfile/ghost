#
# Ghost Dockerfile
#
# https://github.com/dockerfile/ghost
#

# Pull base image.
FROM dockerfile/nodejs

# Install Ghost
RUN cd /tmp && wget https://ghost.org/zip/ghost-latest.zip
RUN cd /tmp && unzip ghost-latest.zip -d /ghost && rm -f ghost-latest.zip
RUN cd /ghost && npm install --production
RUN sed 's/127.0.0.1/0.0.0.0/' /ghost/config.example.js > /ghost/config.js

# Add files.
ADD start.bash /ghost-start

# Set environment variables.
ENV NODE_ENV production

# Define mountable directories.
VOLUME ["/data", "/ghost-override"]

# Define working directory.
WORKDIR "/ghost"

# Define default command.
CMD ["bash", "/ghost-start"]

# Expose ports.
EXPOSE 2368
