FROM dockerfile/nodejs

# Install MongoDB.
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl
RUN apt-get update
RUN apt-get install -y mongodb-10gen

# Create default MongoDB data directory.
RUN mkdir -p /data/db

# Expose ports.
#   - 27017: process
#   - 28017: http
EXPOSE 27017
EXPOSE 28017


RUN git clone git://github.com/webcast-io/jobukyu /jobukyu
WORKDIR /jobukyu
ADD config.js /jobukyu/config.js
ADD run.sh /jobukyu/run.sh
RUN npm install

EXPOSE 3800
CMD ["bash", "./run.sh"]

