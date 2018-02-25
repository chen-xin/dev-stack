#!/bin/sh

export MSYS_NO_PATHCONV=1

volumes="-v $PWD/data:/backup"
prefix="devstack_"
backup="cd /data && find . -type d -maxdepth 1 -mindepth 1 -exec tar zcvf /backup/{}.tar.gz {} \\;"
restore="cd /backup && ls *.tar.gz | xargs -I filename tar zxvf filename -C /data"

for i in $(docker volume ls -q | grep devstack | sed 's#'"$prefix"'##g')
  do volumes+=" -v $prefix$i:/data/$i "
done
echo "$@"

case $@ in
  backup)
    op="$backup"
    ;;
  restore)
    op="$restore"
    ;;
  *)
    echo "usage: data.sh [backup|restore]"
    ;;
esac

docker run --rm $volumes alpine sh -c "$op"

