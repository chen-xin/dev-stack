#!/bin/sh

# add this to prevent minsys from converting "$PWD/data/backup" to
# "/Y/projects/docker/gogs/data;C:\\Program Files\\Git\\backup"
export MSYS_NO_PATHCONV=1

docker run --rm \
    -v devstack_www:/data/www \
    -v devstack_gogs:/data/gogs \
    -v devstack_pg:/data/pg \
    -v $PWD/data:/backup \
    alpine sh -c \
    "cd /data && . <(find . -type d -maxdepth 1 -mindepth 1 | sed 's#^./\\(.\\+\\)#tar zcvf /backup/\\1.tar.gz \\1#g')"
