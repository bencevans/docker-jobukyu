/usr/bin/mongod &
while ! nc -vz localhost 27017; do sleep 3; done
bin/jobukyu