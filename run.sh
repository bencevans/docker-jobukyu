/usr/bin/mongod --nojournal --noprealloc &
while ! nc -vz localhost 27017; do sleep 3; done
bin/jobukyu