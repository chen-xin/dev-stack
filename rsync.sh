#!/bin/bash
# set RSYNC_PASSWORD to avoid password prompt
# RUN: RSYNC_USER=nobody RSYNC_SERVER=0.0.0.0:0000 RSYNC_PASSWORD=awesome rsync.sh backup

export MSYS_NO_PATHCONV=1

volumes="-v $PWD/data:/backup"
prefix="devstack_"

for i in $(docker volume ls -q | grep devstack | sed 's#'"$prefix"'##g')
  do volumes+=" -v $prefix$i:/data/$i "
done

case $@ in
  backup)
    op="cd data && rsync -auvz . rsync://${RSYNC_USER}@${RSYNC_SERVER}/data/dev-stack/"
    ;;
  restore)
    op="cd data && rsync -auvz rsync://${RSYNC_USER}@${RSYNC_SERVER}/data/dev-stack/ ."
    ;;
  *)
    echo "usage: data.sh [backup|restore]"
    ;;
esac

echo -------------------------
echo
echo Input arguments: "$@"
echo
echo volumes: ${volumes}
echo 
echo   SERVER: ${RSYNC_SERVER}
echo     USER: ${RSYNC_USER}
echo PASSWORD: ${RSYNC_PASSWORD}
echo 
echo  COMMAND: ${op}
echo
echo -------------------------

# docker volume prune -f
docker run --rm --env RSYNC_PASSWORD=${RSYNC_PASSWORD} $volumes chenxinaz/rsync sh -c "${op}"

